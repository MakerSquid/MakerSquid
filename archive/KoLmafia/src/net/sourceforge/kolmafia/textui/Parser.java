/**
 * Copyright (c) 2005-2009, KoLmafia development team
 * http://kolmafia.sourceforge.net/
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *  [1] Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *  [2] Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in
 *      the documentation and/or other materials provided with the
 *      distribution.
 *  [3] Neither the name "KoLmafia" nor the names of its contributors may
 *      be used to endorse or promote products derived from this software
 *      without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION ) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE ) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

package net.sourceforge.kolmafia.textui;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.PrintStream;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.TreeMap;

import net.java.dev.spellcast.utilities.DataUtilities;

import net.sourceforge.kolmafia.KoLConstants;
import net.sourceforge.kolmafia.KoLmafiaCLI;
import net.sourceforge.kolmafia.StaticEntity;
import net.sourceforge.kolmafia.textui.parsetree.AggregateType;
import net.sourceforge.kolmafia.textui.parsetree.Assignment;
import net.sourceforge.kolmafia.textui.parsetree.BasicScope;
import net.sourceforge.kolmafia.textui.parsetree.BasicScript;
import net.sourceforge.kolmafia.textui.parsetree.CompositeReference;
import net.sourceforge.kolmafia.textui.parsetree.Conditional;
import net.sourceforge.kolmafia.textui.parsetree.Else;
import net.sourceforge.kolmafia.textui.parsetree.ElseIf;
import net.sourceforge.kolmafia.textui.parsetree.Expression;
import net.sourceforge.kolmafia.textui.parsetree.ForEachLoop;
import net.sourceforge.kolmafia.textui.parsetree.ForLoop;
import net.sourceforge.kolmafia.textui.parsetree.Function;
import net.sourceforge.kolmafia.textui.parsetree.FunctionCall;
import net.sourceforge.kolmafia.textui.parsetree.FunctionInvocation;
import net.sourceforge.kolmafia.textui.parsetree.FunctionList;
import net.sourceforge.kolmafia.textui.parsetree.FunctionReturn;
import net.sourceforge.kolmafia.textui.parsetree.If;
import net.sourceforge.kolmafia.textui.parsetree.LoopBreak;
import net.sourceforge.kolmafia.textui.parsetree.LoopContinue;
import net.sourceforge.kolmafia.textui.parsetree.Operator;
import net.sourceforge.kolmafia.textui.parsetree.ParseTreeNode;
import net.sourceforge.kolmafia.textui.parsetree.PluralValue;
import net.sourceforge.kolmafia.textui.parsetree.RecordType;
import net.sourceforge.kolmafia.textui.parsetree.RepeatUntilLoop;
import net.sourceforge.kolmafia.textui.parsetree.Scope;
import net.sourceforge.kolmafia.textui.parsetree.ScriptExit;
import net.sourceforge.kolmafia.textui.parsetree.SortBy;
import net.sourceforge.kolmafia.textui.parsetree.Switch;
import net.sourceforge.kolmafia.textui.parsetree.SwitchScope;
import net.sourceforge.kolmafia.textui.parsetree.Type;
import net.sourceforge.kolmafia.textui.parsetree.TypeDef;
import net.sourceforge.kolmafia.textui.parsetree.UserDefinedFunction;
import net.sourceforge.kolmafia.textui.parsetree.Value;
import net.sourceforge.kolmafia.textui.parsetree.ValueList;
import net.sourceforge.kolmafia.textui.parsetree.Variable;
import net.sourceforge.kolmafia.textui.parsetree.VariableList;
import net.sourceforge.kolmafia.textui.parsetree.VariableReference;
import net.sourceforge.kolmafia.textui.parsetree.VariableReferenceList;
import net.sourceforge.kolmafia.textui.parsetree.WhileLoop;
import net.sourceforge.kolmafia.utilities.ByteArrayStream;
import net.sourceforge.kolmafia.utilities.StringUtilities;

import net.sourceforge.kolmafia.persistence.Preferences;

public class Parser
{
	// Variables used during parsing

	private String fileName;
	private String shortFileName;
	private InputStream istream;

	private LineNumberReader commandStream;
	private String currentLine;
	private String nextLine;
	private int lineNumber;

	private String fullLine;

	private TreeMap imports;
	private Function mainMethod = null;
	private String notifyRecipient = null;

	public Parser()
	{
		this( null, null, null );
	}

	public Parser( final File scriptFile, final InputStream stream, final TreeMap imports )
	{
		this.imports = ( imports != null ) ? imports : new TreeMap();

		if ( scriptFile != null )
		{
			this.fileName = scriptFile.getPath();
			this.shortFileName = this.fileName.substring( this.fileName.lastIndexOf( File.separator ) + 1 );
			this.istream = DataUtilities.getInputStream( scriptFile );
		}
		else if ( stream != null )
		{
			this.fileName = null;
			this.shortFileName = null;
			this.istream = stream;
		}
		else
		{
			this.fileName = null;
			this.shortFileName = null;
			this.istream = null;
			return;
		}

		try
		{
			this.commandStream = new LineNumberReader( new InputStreamReader( istream ) );
			this.currentLine = this.getNextLine();
			this.lineNumber = this.commandStream.getLineNumber();
			this.nextLine = this.getNextLine();
		}
		catch ( Exception e )
		{
			// If any part of the initialization fails,
			// then throw an exception.

			throw this.parseException( this.fileName + " could not be accessed" );
		}
	}

	private void disconnect()
	{
		try
		{
			this.commandStream = null;
			this.istream.close();
		}
		catch ( IOException e )
		{
		}
	}

	public Scope parse()
	{
		Scope scope = null;

		try
		{
			scope = this.parseScope( null, null, new VariableList(), Parser.getExistingFunctionScope(), false, false );

			if ( this.currentLine != null )
			{
				throw this.parseException( "Script parsing error" );
			}
		}
		finally
		{
			this.disconnect();
		}

		return scope;
	}

	public String getFileName()
	{
		return this.fileName;
	}

	public String getShortFileName()
	{
		return this.shortFileName;
	}

	public int getLineNumber()
	{
		return this.lineNumber;
	}

	public TreeMap getImports()
	{
		return this.imports;
	}

	public Function getMainMethod()
	{
		return this.mainMethod;
	}

	public String getNotifyRecipient()
	{
		return this.notifyRecipient;
	}

	public static Scope getExistingFunctionScope()
	{
		return new Scope( RuntimeLibrary.functions, null, DataTypes.simpleTypes );
	}

	// **************** Parser *****************

	public static final char[] tokenList =
        { ' ', '.', ',', '{', '}', '(', ')', '$', '!', '+', '-', '=', '"', '\'', '*', '^', '/', '%', '[', ']', '!', ';', '<', '>', ':' };
	public static final String[] multiCharTokenList = { "==", "!=", "<=", ">=", "||", "&&", "/*", "*/" };

	private static final ArrayList reservedWords = new ArrayList();

	static
	{
		// Constants
		reservedWords.add( "true" );
		reservedWords.add( "false" );

		// Operators
		reservedWords.add( "contains" );
		reservedWords.add( "remove" );
		reservedWords.add( "new" );

		// Control flow
		reservedWords.add( "if" );
		reservedWords.add( "else" );
		reservedWords.add( "foreach" );
		reservedWords.add( "in" );
		reservedWords.add( "for" );
		reservedWords.add( "from" );
		reservedWords.add( "upto" );
		reservedWords.add( "downto" );
		reservedWords.add( "by" );
		reservedWords.add( "while" );
		reservedWords.add( "repeat" );
		reservedWords.add( "until" );
		reservedWords.add( "break" );
		reservedWords.add( "continue" );
		reservedWords.add( "return" );
		reservedWords.add( "exit" );
		reservedWords.add( "switch" );
		reservedWords.add( "case" );
		reservedWords.add( "default" );

		// Data types
		reservedWords.add( "void" );
		reservedWords.add( "boolean" );
		reservedWords.add( "int" );
		reservedWords.add( "float" );
		reservedWords.add( "string" );
		reservedWords.add( "buffer" );
		reservedWords.add( "matcher" );

		reservedWords.add( "item" );
		reservedWords.add( "location" );
		reservedWords.add( "class" );
		reservedWords.add( "stat" );
		reservedWords.add( "skill" );
		reservedWords.add( "effect" );
		reservedWords.add( "familiar" );
		reservedWords.add( "slot" );
		reservedWords.add( "monster" );
		reservedWords.add( "element" );

		reservedWords.add( "record" );
		reservedWords.add( "typedef" );
	}

	private static final boolean isReservedWord( final String name )
	{
		return Parser.reservedWords.contains( name.toLowerCase() );
	}

	public Scope importFile( final String fileName, final Scope scope )
	{
		File scriptFile = KoLmafiaCLI.findScriptFile( fileName );
		if ( scriptFile == null )
		{
			throw this.parseException( fileName + " could not be found" );
		}

		if ( this.imports.containsKey( scriptFile ) )
		{
			return scope;
		}

		Scope result = scope;
		Parser parser = null;

		try
		{
			parser = new Parser( scriptFile, null, this.imports );
			result = parser.parseScope( scope, null, new VariableList(), scope.getParentScope(), false, false );
			if ( parser.currentLine != null )
			{
				throw this.parseException( "Script parsing error" );
			}
		}
		finally
		{
			if ( parser != null )
			{
				parser.disconnect();
			}
		}

		this.imports.put( scriptFile, new Long( scriptFile.lastModified() ) );
		this.mainMethod = null;

		return result;
	}

	private Scope parseScope( final Scope startScope,
				  final Type expectedType,
				  final VariableList variables,
				  final BasicScope parentScope,
				  final boolean allowBreak,
				  final boolean allowContinue )
	{
		Scope result;
		String importString;

		result = startScope == null ? new Scope( variables, parentScope ) : startScope;
		this.parseNotify();

		while ( ( importString = this.parseImport() ) != null )
		{
			result = this.importFile( importString, result );
		}

		while ( true )
		{
			if ( this.parseTypedef( result ) )
			{
				if ( !this.currentToken().equals( ";" ) )
				{
					throw this.parseException( ";", this.currentToken() );
				}

				this.readToken(); //read ;
				continue;
			}

			Type t = this.parseType( result, true, true );

			// If there is no data type, it's a command of some sort
			if ( t == null )
			{
				// See if it's a regular command
				ParseTreeNode c = this.parseCommand( expectedType, result, false, allowBreak, allowContinue );
				if ( c != null )
				{
					result.addCommand( c );

					continue;
				}

				// No type and no command -> done.
				break;
			}

			// If this is a new record definition, enter it
			if ( t.getType() == DataTypes.TYPE_RECORD && this.currentToken() != null && this.currentToken().equals(
				";" ) )
			{
				this.readToken(); // read ;
				continue;
			}

			Function f = this.parseFunction( t, result );
			if ( f != null )
			{
				if ( f.getName().equalsIgnoreCase( "main" ) )
				{
					if ( parentScope.getParentScope() != null )
					{
						throw this.parseException( "main method must appear at top level" );
					}
					this.mainMethod = f;
				}

				continue;
			}

			if ( this.parseVariables( t, result ) )
			{
				if ( !this.currentToken().equals( ";" ) )
				{
					throw this.parseException( ";", this.currentToken() );
				}

				this.readToken(); //read ;
				continue;
			}

			//Found a type but no function or variable to tie it to
			throw this.parseException( "Script parse error" );
		}

		return result;
	}

	private Type parseRecord( final BasicScope parentScope )
	{
		if ( this.currentToken() == null || !this.currentToken().equalsIgnoreCase( "record" ) )
		{
			return null;
		}

		this.readToken(); // read record

		if ( this.currentToken() == null )
		{
			throw this.parseException( "Record name expected" );
		}

		// Allow anonymous records
		String recordName = null;

		if ( !this.currentToken().equals( "{" ) )
		{
			// Named record
			recordName = this.currentToken();

			if ( !this.parseIdentifier( recordName ) )
			{
				throw this.parseException( "Invalid record name '" + recordName + "'" );
			}

			if ( Parser.isReservedWord( recordName ) )
			{
				throw this.parseException( "Reserved word '" + recordName + "' cannot be a record name" );
			}

			if ( parentScope.findType( recordName ) != null )
			{
				throw this.parseException( "Record name '" + recordName + "' is already defined" );
			}

			this.readToken(); // read name
		}

		if ( this.currentToken() == null || !this.currentToken().equals( "{" ) )
		{
			throw this.parseException( "{", this.currentToken() );
		}

		this.readToken(); // read {

		// Loop collecting fields
		ArrayList fieldTypes = new ArrayList();
		ArrayList fieldNames = new ArrayList();

		while ( true )
		{
			// Get the field type
			Type fieldType = this.parseType( parentScope, true, true );
			if ( fieldType == null )
			{
				throw this.parseException( "Type name expected" );
			}

			// Get the field name
			String fieldName = this.currentToken();
			if ( fieldName == null )
			{
				throw this.parseException( "Field name expected" );
			}

			if ( !this.parseIdentifier( fieldName ) )
			{
				throw this.parseException( "Invalid field name '" + fieldName + "'" );
			}

			if ( Parser.isReservedWord( fieldName ) )
			{
				throw this.parseException( "Reserved word '" + fieldName + "' cannot be used as a field name" );
			}

			if ( fieldNames.contains( fieldName ) )
			{
				throw this.parseException( "Field name '" + fieldName + "' is already defined" );
			}

			this.readToken(); // read name

			if ( this.currentToken() == null || !this.currentToken().equals( ";" ) )
			{
				throw this.parseException( ";", this.currentToken() );
			}

			this.readToken(); // read ;

			fieldTypes.add( fieldType );
			fieldNames.add( fieldName.toLowerCase() );

			if ( this.currentToken() == null )
			{
				throw this.parseException( "}", "EOF" );
			}

			if ( this.currentToken().equals( "}" ) )
			{
				break;
			}
		}

		this.readToken(); // read }

		String[] fieldNameArray = new String[ fieldNames.size() ];
		Type[] fieldTypeArray = new Type[ fieldTypes.size() ];
		fieldNames.toArray( fieldNameArray );
		fieldTypes.toArray( fieldTypeArray );

		RecordType rec =
			new RecordType(
				recordName == null ? "(anonymous record)" : recordName, fieldNameArray, fieldTypeArray );

		if ( recordName != null )
		{
			// Enter into type table
			parentScope.addType( rec );
		}

		return rec;
	}

	private Function parseFunction( final Type functionType, final Scope parentScope )
	{
		if ( !this.parseIdentifier( this.currentToken() ) )
		{
			return null;
		}

		if ( this.nextToken() == null || !this.nextToken().equals( "(" ) )
		{
			return null;
		}

		String functionName = this.currentToken();

		if ( Parser.isReservedWord( functionName ) )
		{
			throw this.parseException( "Reserved word '" + functionName + "' cannot be used as a function name" );
		}

		this.readToken(); //read Function name
		this.readToken(); //read (

		VariableList paramList = new VariableList();
		VariableReferenceList variableReferences = new VariableReferenceList();

		while ( !this.currentToken().equals( ")" ) )
		{
			Type paramType = this.parseType( parentScope, true, false );
			if ( paramType == null )
			{
				throw this.parseException( ")", this.currentToken() );
			}

			Variable param = this.parseVariable( paramType, null );
			if ( param == null )
			{
				throw this.parseException( "identifier", this.currentToken() );
			}

			if ( !paramList.add( param ) )
			{
				throw this.parseException( "Variable " + param.getName() + " is already defined" );
			}

			if ( !this.currentToken().equals( ")" ) )
			{
				if ( !this.currentToken().equals( "," ) )
				{
					throw this.parseException( ")", this.currentToken() );
				}

				this.readToken(); //read comma
			}

			variableReferences.add( new VariableReference( param ) );
		}

		this.readToken(); //read )

		// Add the function to the parent scope before we parse the
		// function scope to allow recursion.

		UserDefinedFunction f = new UserDefinedFunction( functionName, functionType, variableReferences );
		UserDefinedFunction existing = parentScope.findFunction( f );

		if ( existing != null && existing.getScope() != null )
		{
			throw this.parseException( "Function '" + functionName + "' defined multiple times" );
		}

		// Add new function or replace existing forward reference

		UserDefinedFunction result = parentScope.replaceFunction( existing, f );

		if ( this.currentToken() != null && this.currentToken().equals( ";" ) )
		{
			// Return forward reference
			this.readToken(); // ;
			return result;
		}

		Scope scope;
		if ( this.currentToken() != null && this.currentToken().equals( "{" ) )
		{
			// Scope is a block

			this.readToken(); // {

			scope = this.parseScope( null, functionType, paramList, parentScope, false, false );
			if ( this.currentToken() == null || !this.currentToken().equals( "}" ) )
			{
				throw this.parseException( "}", this.currentToken() );
			}

			this.readToken(); // }
		}
		else
		{
			// Scope is a single command
			scope = new Scope( paramList, parentScope );
			ParseTreeNode cmd = this.parseCommand( functionType, parentScope, false, false, false );
			if ( cmd == null )
			{
				throw this.parseException( "Function with no body" );
			}
			scope.addCommand( cmd );
		}

		result.setScope( scope );
		if ( !result.assertReturn() && !functionType.equals( DataTypes.TYPE_VOID )
		// The following clause can't be correct. I think it
		// depends on the various conditional & loop constructs
		// returning a boolean. Or something. But without it,
		// existing scripts break. Aargh!
		&& !functionType.equals( DataTypes.TYPE_BOOLEAN ) )
		{
			throw this.parseException( "Missing return value" );
		}

		return result;
	}

	private boolean parseVariables( final Type t, final BasicScope parentScope )
	{
		while ( true )
		{
			Variable v = this.parseVariable( t, parentScope );
			if ( v == null )
			{
				return false;
			}

			if ( this.currentToken().equals( "," ) )
			{
				this.readToken(); //read ,
				continue;
			}

			return true;
		}
	}

	private Variable parseVariable( final Type t, final BasicScope scope )
	{
		if ( !this.parseIdentifier( this.currentToken() ) )
		{
			return null;
		}

		String variableName = this.currentToken();
		if ( Parser.isReservedWord( variableName ) )
		{
			throw this.parseException( "Reserved word '" + variableName + "' cannot be a variable name" );
		}

		Variable result = new Variable( variableName, t );
		if ( scope != null && !scope.addVariable( result ) )
		{
			throw this.parseException( "Variable " + result.getName() + " is already defined" );
		}

		this.readToken(); // If parsing of Identifier succeeded, go to next token.
		// If we are parsing a parameter declaration, we are done
		if ( scope == null )
		{
			if ( this.currentToken().equals( "=" ) )
			{
				throw this.parseException( "Cannot initialize parameter " + result.getName() );
			}
			return result;
		}

		// Otherwise, we must initialize the variable.

		VariableReference lhs = new VariableReference( result.getName(), scope );
		Value rhs;

		if ( this.currentToken().equals( "=" ) )
		{
			this.readToken(); // Eat the equals sign
			rhs = this.parseExpression( scope );

			if ( rhs == null )
			{
				throw this.parseException( "Expression expected" );
			}

			if ( !Parser.validCoercion( lhs.getType(), rhs.getType(), "assign" ) )
			{
				throw this.parseException(
					"Cannot store " + rhs.getType() + " in " + lhs + " of type " + lhs.getType() );
			}
		}
		else
		{
			rhs = null;
		}

		scope.addCommand( new Assignment( lhs, rhs ) );
		return result;
	}

	private boolean parseTypedef( final Scope parentScope )
	{
		if ( this.currentToken() == null || !this.currentToken().equalsIgnoreCase( "typedef" ) )
		{
			return false;
		}
		this.readToken(); // read typedef

		Type t = this.parseType( parentScope, true, true );
		if ( t == null )
		{
			throw this.parseException( "Missing data type for typedef" );
		}

		String typeName = this.currentToken();

		if ( !this.parseIdentifier( typeName ) )
		{
			throw this.parseException( "Invalid type name '" + typeName + "'" );
		}

		if ( Parser.isReservedWord( typeName ) )
		{
			throw this.parseException( "Reserved word '" + typeName + "' cannot be a type name" );
		}

		if ( parentScope.findType( typeName ) != null )
		{
			throw this.parseException( "Type name '" + typeName + "' is already defined" );
		}

		this.readToken(); // read name

		// Add the type to the type table
		TypeDef type = new TypeDef( typeName, t );
		parentScope.addType( type );

		return true;
	}

	private ParseTreeNode parseCommand( final Type functionType, final BasicScope scope, final boolean noElse, boolean allowBreak, boolean allowContinue )
	{
		ParseTreeNode result;

		if ( this.currentToken() == null )
		{
			return null;
		}

		if ( this.currentToken().equalsIgnoreCase( "break" ) )
		{
			if ( !allowBreak )
			{
				throw this.parseException( "Encountered 'break' outside of loop" );
			}

			result = new LoopBreak();
			this.readToken(); //break
		}

		else if ( this.currentToken().equalsIgnoreCase( "continue" ) )
		{
			if ( !allowContinue )
			{
				throw this.parseException( "Encountered 'continue' outside of loop" );
			}

			result = new LoopContinue();
			this.readToken(); //continue
		}

		else if ( this.currentToken().equalsIgnoreCase( "exit" ) )
		{
			result = new ScriptExit();
			this.readToken(); //exit
		}

		else if ( ( result = this.parseReturn( functionType, scope ) ) != null )
		{
			;
		}
		else if ( ( result = this.parseBasicScript() ) != null )
		{
			// basic_script doesn't have a ; token
			return result;
		}
		else if ( ( result = this.parseWhile( functionType, scope ) ) != null )
		{
			// while doesn't have a ; token
			return result;
		}
		else if ( ( result = this.parseForeach( functionType, scope ) ) != null )
		{
			// foreach doesn't have a ; token
			return result;
		}
		else if ( ( result = this.parseFor( functionType, scope ) ) != null )
		{
			// for doesn't have a ; token
			return result;
		}
		else if ( ( result = this.parseRepeat( functionType, scope ) ) != null )
		{
			;
		}
		else if ( ( result = this.parseSwitch( functionType, scope, allowContinue ) ) != null )
		{
			// switch doesn't have a ; token
			return result;
		}
		else if ( ( result = this.parseConditional( functionType, scope, noElse, allowBreak, allowContinue ) ) != null )
		{
			// loop doesn't have a ; token
			return result;
		}
		else if ( ( result = this.parseSort( scope ) ) != null )
		{
			;
		}
		else if ( ( result = this.parseInvoke( scope ) ) != null )
		{
			;
		}
		else if ( ( result = this.parseCall( scope ) ) != null )
		{
			;
		}
		else if ( ( result = this.parseAssignment( scope ) ) != null )
		{
			;
		}
		else if ( ( result = this.parseRemove( scope ) ) != null )
		{
			;
		}
		else if ( ( result = this.parseValue( scope ) ) != null )
		{
			;
		}
		else
		{
			return null;
		}

		if ( this.currentToken() == null || !this.currentToken().equals( ";" ) )
		{
			throw this.parseException( ";", this.currentToken() );
		}

		this.readToken(); // ;
		return result;
	}

	private Type parseType( final BasicScope scope, final boolean aggregates, final boolean records )
	{
		if ( this.currentToken() == null )
		{
			return null;
		}

		Type valType = scope.findType( this.currentToken() );
		if ( valType == null )
		{
			if ( records && this.currentToken().equalsIgnoreCase( "record" ) )
			{
				valType = this.parseRecord( scope );

				if ( valType == null )
				{
					return null;
				}

				if ( aggregates && this.currentToken().equals( "[" ) )
				{
					return this.parseAggregateType( valType, scope );
				}

				return valType;
			}

			return null;
		}

		this.readToken();

		if ( aggregates && this.currentToken().equals( "[" ) )
		{
			return this.parseAggregateType( valType, scope );
		}

		return valType;
	}

	private Type parseAggregateType( final Type dataType, final BasicScope scope )
	{
		this.readToken(); // [ or ,
		if ( this.currentToken() == null )
		{
			throw this.parseException( "Missing index token" );
		}

		if ( this.readIntegerToken( this.currentToken() ) )
		{
			int size = StringUtilities.parseInt( this.currentToken() );
			this.readToken(); // integer

			if ( this.currentToken() == null )
			{
				throw this.parseException( "]", this.currentToken() );
			}

			if ( this.currentToken().equals( "]" ) )
			{
				this.readToken(); // ]

				if ( this.currentToken().equals( "[" ) )
				{
					return new AggregateType( this.parseAggregateType( dataType, scope ), size );
				}

				return new AggregateType( dataType, size );
			}

			if ( this.currentToken().equals( "," ) )
			{
				return new AggregateType( this.parseAggregateType( dataType, scope ), size );
			}

			throw this.parseException( "]", this.currentToken() );
		}

		Type indexType = scope.findType( this.currentToken() );
		if ( indexType == null )
		{
			throw this.parseException( "Invalid type name '" + this.currentToken() + "'" );
		}

		if ( !indexType.isPrimitive() )
		{
			throw this.parseException( "Index type '" + this.currentToken() + "' is not a primitive type" );
		}

		this.readToken(); // type name
		if ( this.currentToken() == null )
		{
			throw this.parseException( "]", this.currentToken() );
		}

		if ( this.currentToken().equals( "]" ) )
		{
			this.readToken(); // ]

			if ( this.currentToken().equals( "[" ) )
			{
				return new AggregateType( this.parseAggregateType( dataType, scope ), indexType );
			}

			return new AggregateType( dataType, indexType );
		}

		if ( this.currentToken().equals( "," ) )
		{
			return new AggregateType( this.parseAggregateType( dataType, scope ), indexType );
		}

		throw this.parseException( ", or ]", this.currentToken() );
	}

	private boolean parseIdentifier( final String identifier )
	{
		if ( !Character.isLetter( identifier.charAt( 0 ) ) && identifier.charAt( 0 ) != '_' )
		{
			return false;
		}

		for ( int i = 1; i < identifier.length(); ++i )
		{
			if ( !Character.isLetterOrDigit( identifier.charAt( i ) ) && identifier.charAt( i ) != '_' )
			{
				return false;
			}
		}

		return true;
	}

	private FunctionReturn parseReturn( final Type expectedType, final BasicScope parentScope )
	{
		if ( this.currentToken() == null || !this.currentToken().equalsIgnoreCase( "return" ) )
		{
			return null;
		}

		this.readToken(); //return

		if ( this.currentToken() != null && this.currentToken().equals( ";" ) )
		{
			if ( expectedType != null && expectedType.equals( DataTypes.TYPE_VOID ) )
			{
				return new FunctionReturn( null, DataTypes.VOID_TYPE );
			}

			throw this.parseException( "Return needs " + expectedType + " value" );
		}
		else
		{
			if ( expectedType != null && expectedType.equals( DataTypes.TYPE_VOID ) )
			{
				throw this.parseException( "Cannot return a value from a void function" );
			}

			Value value = this.parseExpression( parentScope );

			if ( value == null )
			{
				throw this.parseException( "Expression expected" );
			}

			if ( expectedType != null &&
				!Parser.validCoercion( expectedType, value.getType(), "return" ) )
			{
				throw this.parseException( "Cannot return " + value.getType() + " value from " + expectedType + " function");
			}

			return new FunctionReturn( value, expectedType );
		}
	}

	private Conditional parseConditional( final Type functionType,
					      final BasicScope parentScope,
					      boolean noElse,
					      final boolean allowBreak,
					      final boolean allowContinue )
	{
		if ( this.currentToken() == null || !this.currentToken().equalsIgnoreCase( "if" ) )
		{
			return null;
		}

		if ( this.nextToken() == null || !this.nextToken().equals( "(" ) )
		{
			throw this.parseException( "(", this.nextToken() );
		}

		this.readToken(); // if
		this.readToken(); // (

		Value condition = this.parseExpression( parentScope );
		if ( this.currentToken() == null || !this.currentToken().equals( ")" ) )
		{
			throw this.parseException( ")", this.currentToken() );
		}

		if ( condition == null || condition.getType() != DataTypes.BOOLEAN_TYPE )
		{
			throw this.parseException( "\"if\" requires a boolean conditional expression" );
		}

		this.readToken(); // )

		If result = null;
		boolean elseFound = false;
		boolean finalElse = false;

		do
		{
			Scope scope;

			if ( this.currentToken() == null || !this.currentToken().equals( "{" ) ) //Scope is a single call
			{
				ParseTreeNode command = this.parseCommand( functionType, parentScope, !elseFound, allowBreak, allowContinue );
				scope = new Scope( command, parentScope );
			}
			else
			{
				this.readToken(); //read {
				scope = this.parseScope( null, functionType, null, parentScope, allowBreak, allowContinue );

				if ( this.currentToken() == null || !this.currentToken().equals( "}" ) )
				{
					throw this.parseException( "}", this.currentToken() );
				}

				this.readToken(); //read }
			}

			if ( result == null )
			{
				result = new If( scope, condition );
			}
			else if ( finalElse )
			{
				result.addElseLoop( new Else( scope, condition ) );
			}
			else
			{
				result.addElseLoop( new ElseIf( scope, condition ) );
			}

			if ( !noElse && this.currentToken() != null && this.currentToken().equalsIgnoreCase( "else" ) )
			{
				if ( finalElse )
				{
					throw this.parseException( "Else without if" );
				}

				if ( this.nextToken() != null && this.nextToken().equalsIgnoreCase( "if" ) )
				{
					this.readToken(); //else
					this.readToken(); //if

					if ( this.currentToken() == null || !this.currentToken().equals( "(" ) )
					{
						throw this.parseException( "(", this.currentToken() );
					}

					this.readToken(); //(
					condition = this.parseExpression( parentScope );

					if ( this.currentToken() == null || !this.currentToken().equals( ")" ) )
					{
						throw this.parseException( ")", this.currentToken() );
					}

					if ( condition == null || condition.getType() != DataTypes.BOOLEAN_TYPE )
					{
						throw this.parseException( "\"if\" requires a boolean conditional expression" );
					}

					this.readToken(); // )
				}
				else
				//else without condition
				{
					this.readToken(); //else
					condition = DataTypes.TRUE_VALUE;
					finalElse = true;
				}

				elseFound = true;
				continue;
			}

			elseFound = false;
		}
		while ( elseFound );

		return result;
	}

	private BasicScript parseBasicScript()
	{
		if ( this.currentToken() == null )
		{
			return null;
		}

		if ( !this.currentToken().equalsIgnoreCase( "cli_execute" ) )
		{
			return null;
		}

		if ( this.nextToken() == null || !this.nextToken().equals( "{" ) )
		{
			return null;
		}

		this.readToken(); // while
		this.readToken(); // {

		ByteArrayStream ostream = new ByteArrayStream();

		while ( this.currentToken() != null && !this.currentToken().equals( "}" ) )
		{
			try
			{
				ostream.write( this.currentLine.getBytes() );
				ostream.write( KoLConstants.LINE_BREAK.getBytes() );
			}
			catch ( Exception e )
			{
				// Byte array output streams do not throw errors,
				// other than out of memory errors.

				StaticEntity.printStackTrace( e );
			}

			this.currentLine = "";
			this.fixLines();
		}

		if ( this.currentToken() == null )
		{
			throw this.parseException( "}", this.currentToken() );
		}

		this.readToken(); // }

		return new BasicScript( ostream );
	}

	private WhileLoop parseWhile( final Type functionType, final BasicScope parentScope )
	{
		if ( this.currentToken() == null )
		{
			return null;
		}

		if ( !this.currentToken().equalsIgnoreCase( "while" ) )
		{
			return null;
		}

		if ( this.nextToken() == null || !this.nextToken().equals( "(" ) )
		{
			throw this.parseException( "(", this.nextToken() );
		}

		this.readToken(); // while
		this.readToken(); // (

		Value condition = this.parseExpression( parentScope );
		if ( this.currentToken() == null || !this.currentToken().equals( ")" ) )
		{
			throw this.parseException( ")", this.currentToken() );
		}

		if ( condition == null || condition.getType() != DataTypes.BOOLEAN_TYPE )
		{
			throw this.parseException( "\"while\" requires a boolean conditional expression" );
		}

		this.readToken(); // )

		Scope scope = this.parseLoopScope( functionType, null, parentScope );

		return new WhileLoop( scope, condition );
	}

	private RepeatUntilLoop parseRepeat( final Type functionType, final BasicScope parentScope )
	{
		if ( this.currentToken() == null )
		{
			return null;
		}

		if ( !this.currentToken().equalsIgnoreCase( "repeat" ) )
		{
			return null;
		}

		this.readToken(); // repeat

		Scope scope = this.parseLoopScope( functionType, null, parentScope );
		if ( this.currentToken() == null || !this.currentToken().equals( "until" ) )
		{
			throw this.parseException( "until", this.currentToken() );
		}

		if ( this.nextToken() == null || !this.nextToken().equals( "(" ) )
		{
			throw this.parseException( "(", this.nextToken() );
		}

		this.readToken(); // until
		this.readToken(); // (

		Value condition = this.parseExpression( parentScope );
		if ( this.currentToken() == null || !this.currentToken().equals( ")" ) )
		{
			throw this.parseException( ")", this.currentToken() );
		}

		if ( condition == null || condition.getType() != DataTypes.BOOLEAN_TYPE )
		{
			throw this.parseException( "\"repeat\" requires a boolean conditional expression" );
		}

		this.readToken(); // )

		return new RepeatUntilLoop( scope, condition );
	}

	private Switch parseSwitch( final Type functionType, final BasicScope parentScope, final boolean allowContinue )
	{
		if ( this.currentToken() == null ||
		     !this.currentToken().equalsIgnoreCase( "switch" ) )
		{
			return null;
		}

		if ( this.nextToken() == null ||
		     ( !this.nextToken().equals( "(" ) && !this.nextToken().equals( "{" ) ) )
		{
			throw this.parseException( "( or {", this.nextToken() );
		}

		this.readToken(); // switch

		Value condition = DataTypes.TRUE_VALUE;
		if ( this.currentToken().equals( "(" ) )
		{
			this.readToken(); // (

			condition = this.parseExpression( parentScope );
			if ( this.currentToken() == null || !this.currentToken().equals( ")" ) )
			{
				throw this.parseException( ")", this.currentToken() );
			}

			this.readToken(); // )
		}

		Type type = condition.getType();

		if ( this.currentToken() == null || !this.currentToken().equals( "{" ) )
		{
			throw this.parseException( "{", this.currentToken() );
		}

		this.readToken(); // {

		ArrayList tests = new ArrayList();
		ArrayList indices = new ArrayList();
		int defaultIndex = -1;

		SwitchScope scope = new SwitchScope( parentScope );
		int currentIndex = 0;
		Integer currentInteger = null;

		TreeMap labels = new TreeMap();
		boolean constantLabels = true;

		while ( true )
		{
			if ( this.currentToken().equals( "case" ) )
			{
				this.readToken(); // case

				Value test = this.parseExpression( parentScope );

				if ( this.currentToken() == null || !this.currentToken().equals( ":" ) )
				{
					throw this.parseException( ":", this.currentToken() );
				}

				if ( !test.getType().equals( type ) )
				{
					throw this.parseException( "Switch conditional has type " + type + " but label expression has type " + test.getType() );
				}

				this.readToken(); // :

				if ( currentInteger == null )
				{
					currentInteger = new Integer( currentIndex );
				}

				if ( test.getClass() == Value.class )
				{
					if ( labels.get( test ) != null )
					{
						throw this.parseException( "Duplicate case label: " + test );
					}
					labels.put( test, currentInteger );
				}
				else
				{
					constantLabels = false;
				}


				tests.add( test );
				indices.add( currentInteger );

				continue;
			}

			if ( this.currentToken().equals( "default" ) )
			{
				this.readToken(); // default

				if ( this.currentToken() == null || !this.currentToken().equals( ":" ) )
				{
					throw this.parseException( ":", this.currentToken() );
				}

				if ( defaultIndex != -1 )
				{
					throw this.parseException( "Only one default label allowed in a switch statement" );
				}

				this.readToken(); // :

				defaultIndex = currentIndex;

				continue;
			}

			Type t = this.parseType( scope, true, true );

			// If there is no data type, it's a command of some sort
			if ( t == null )
			{
				// See if it's a regular command
				ParseTreeNode c = this.parseCommand( functionType, scope, false, true, allowContinue );
				if ( c != null )
				{
					scope.addCommand( c );
					currentIndex = scope.commandCount();
					currentInteger = null;
					continue;
				}

				// No type and no command -> done.
				break;
			}

			if ( this.parseVariables( t, scope ) )
			{
				if ( !this.currentToken().equals( ";" ) )
				{
					throw this.parseException( ";", this.currentToken() );
				}

				this.readToken(); //read ;
                                currentIndex = scope.commandCount();
                                currentInteger = null;
				continue;
			}

			//Found a type but no function or variable to tie it to
			throw this.parseException( "Script parse error" );
		}

		if ( this.currentToken() == null || !this.currentToken().equals( "}" ) )
		{
			throw this.parseException( "}", this.currentToken() );
		}

		this.readToken(); // }

		return new Switch( condition, tests, indices, defaultIndex, scope,
				   constantLabels ? labels : null );
	}

	private SortBy parseSort( final BasicScope parentScope )
	{
		// sort aggregate by expr

		if ( this.currentToken() == null )
		{
			return null;
		}

		if ( !this.currentToken().equalsIgnoreCase( "sort" ) )
		{
			return null;
		}
		
		if ( this.nextToken() == null || this.nextToken().equals( "(" )
			|| this.nextToken().equals( "=" ) )
		{	// it's a call to a function named sort(), or an assigment to
			// a variable named sort, not the sort statement.
			return null;
		}

		this.readToken(); // sort

		// Get an aggregate reference
		Value aggregate = this.parseVariableReference( parentScope );

		if ( aggregate == null || !( aggregate instanceof VariableReference ) || !( aggregate.getType().getBaseType() instanceof AggregateType ) )
		{
			throw this.parseException( "Aggregate reference expected" );
		}

		if ( this.currentToken() == null ||
			!this.currentToken().equalsIgnoreCase( "by" ) )
		{
			throw this.parseException( "by", this.currentToken() );
		}
		this.readToken();	// by

		// Define key variables of appropriate type
		VariableList varList = new VariableList();
		AggregateType type = (AggregateType) aggregate.getType().getBaseType();
		Variable valuevar = new Variable( "value", type.getDataType() );
		varList.add( valuevar );
		Variable indexvar = new Variable( "index", type.getIndexType() );
		varList.add( indexvar );

		// Parse the key expression in a new scope containing 'index' and 'value'
		Scope scope = new Scope( varList, parentScope );
		Value expr = this.parseExpression( scope );
		
		return new SortBy( (VariableReference) aggregate, indexvar, valuevar, expr );
	}

	private ForEachLoop parseForeach( final Type functionType, final BasicScope parentScope )
	{
		// foreach key [, key ... ] in aggregate { scope }

		if ( this.currentToken() == null )
		{
			return null;
		}

		if ( !this.currentToken().equalsIgnoreCase( "foreach" ) )
		{
			return null;
		}

		this.readToken(); // foreach

		ArrayList names = new ArrayList();

		while ( true )
		{
			String name = this.currentToken();

			if ( !this.parseIdentifier( name ) )
			{
				throw this.parseException( "Key variable name expected" );
			}

			if ( parentScope.findVariable( name ) != null )
			{
				throw this.parseException( "Key variable '" + name + "' is already defined" );
			}

			names.add( name );
			this.readToken(); // name

			if ( this.currentToken() != null )
			{
				if ( this.currentToken().equals( "," ) )
				{
					this.readToken(); // ,
					continue;
				}

				if ( this.currentToken().equalsIgnoreCase( "in" ) )
				{
					this.readToken(); // in
					break;
				}
			}

			throw this.parseException( "in", this.currentToken() );
		}

		// Get an aggregate reference
		Value aggregate = this.parseValue( parentScope );

		if ( aggregate == null || !( aggregate.getType().getBaseType() instanceof AggregateType ) )
		{
			throw this.parseException( "Aggregate reference expected" );
		}

		// Define key variables of appropriate type
		VariableList varList = new VariableList();
		VariableReferenceList variableReferences = new VariableReferenceList();
		Type type = aggregate.getType().getBaseType();

		for ( int i = 0; i < names.size(); ++i )
		{
			Type itype;
			if ( type == null )
			{
				throw this.parseException( "Too many key variables specified" );
			}
			else if ( !( type instanceof AggregateType ) )
			{	// Variable after all key vars holds the value instead
				itype = type;
				type = null;
			}
			else
			{
				itype = ( (AggregateType) type ).getIndexType();
				type = ( (AggregateType) type ).getDataType();
			}

			Variable keyvar = new Variable( (String) names.get( i ), itype );
			varList.add( keyvar );
			variableReferences.add( new VariableReference( keyvar ) );
		}

		// Parse the scope with the list of keyVars
		Scope scope = this.parseLoopScope( functionType, varList, parentScope );

		// Add the foreach node with the list of varRefs
		return new ForEachLoop( scope, variableReferences, aggregate );
	}

	private ForLoop parseFor( final Type functionType, final BasicScope parentScope )
	{
		// foreach key in aggregate {scope }

		if ( this.currentToken() == null )
		{
			return null;
		}

		if ( !this.currentToken().equalsIgnoreCase( "for" ) )
		{
			return null;
		}

		String name = this.nextToken();

		if ( !this.parseIdentifier( name ) )
		{
			return null;
		}

		if ( parentScope.findVariable( name ) != null )
		{
			throw this.parseException( "Index variable '" + name + "' is already defined" );
		}

		this.readToken(); // for
		this.readToken(); // name

		if ( !this.currentToken().equalsIgnoreCase( "from" ) )
		{
			throw this.parseException( "from", this.currentToken() );
		}

		this.readToken(); // from

		Value initial = this.parseExpression( parentScope );

		int direction = 0;

		if ( this.currentToken().equalsIgnoreCase( "upto" ) )
		{
			direction = 1;
		}
		else if ( this.currentToken().equalsIgnoreCase( "downto" ) )
		{
			direction = -1;
		}
		else if ( this.currentToken().equalsIgnoreCase( "to" ) )
		{
			direction = 0;
		}
		else
		{
			throw this.parseException( "to, upto, or downto", this.currentToken() );
		}

		this.readToken(); // upto/downto

		Value last = this.parseExpression( parentScope );

		Value increment = DataTypes.ONE_VALUE;
		if ( this.currentToken().equalsIgnoreCase( "by" ) )
		{
			this.readToken(); // by
			increment = this.parseExpression( parentScope );
		}

		// Create integer index variable
		Variable indexvar = new Variable( name, DataTypes.INT_TYPE );

		// Put index variable onto a list
		VariableList varList = new VariableList();
		varList.add( indexvar );

		Scope scope = this.parseLoopScope( functionType, varList, parentScope );

		return new ForLoop( scope, new VariableReference( indexvar ), initial, last, increment, direction, this );
	}

	private Scope parseLoopScope( final Type functionType, final VariableList varList, final BasicScope parentScope )
	{
		Scope scope;

		if ( this.currentToken() != null && this.currentToken().equals( "{" ) )
		{
			// Scope is a block

			this.readToken(); // {

			scope = this.parseScope( null, functionType, varList, parentScope, true, true );
			if ( this.currentToken() == null || !this.currentToken().equals( "}" ) )
			{
				throw this.parseException( "}", this.currentToken() );
			}

			this.readToken(); // }
		}
		else
		{
			// Scope is a single command
			scope = new Scope( varList, parentScope );
			scope.addCommand( this.parseCommand( functionType, scope, false, true, true ) );
		}

		return scope;
	}

	private Value parseNewRecord( final BasicScope scope )
	{
		if ( !this.parseIdentifier( this.currentToken() ) )
		{
			return null;
		}

		String name = this.currentToken();
		Type type = scope.findType( name );

		if ( type == null || !( type instanceof RecordType ) )
		{
			throw this.parseException( "'" + name + "' is not a record type" );
		}

		RecordType target = (RecordType) type;

		this.readToken(); //name

		ValueList params = new ValueList();
		String [] names = target.getFieldNames();
		Type [] types = target.getFieldTypes();
		int param = 0;

		if ( this.currentToken() != null && this.currentToken().equals( "(" ) )
		{
			this.readToken(); //(

			while ( this.currentToken() != null && !this.currentToken().equals( ")" ) )
			{
				Value val;

				if ( this.currentToken().equals( "," ) )
				{
					this.readToken(); // ,
					val = DataTypes.VOID_VALUE;
				}
				else
				{
					val = this.parseExpression( scope );
				}

				if ( val == null )
				{
					throw this.parseException( "Expression expected for field #" + ( param + 1 ) + " (" + names[param] + ")" );
				}

				if ( val != DataTypes.VOID_VALUE )
				{
					Type expected = types[param];
					Type given = val.getType();
					if ( expected != given )
					{
						throw this.parseException( given + " found when " + expected + " expected for field #" + ( param + 1 ) + " (" + names[param] + ")" );
					}
				}

				params.add( val );
				param++;

				if ( this.currentToken().equals( "," ) )
				{
					if ( param == names.length )
					{
						throw this.parseException( "Too many field initializer for record " + name );
					}

					this.readToken(); // ,
				}
			}

			if ( this.currentToken() == null )
			{
				throw this.parseException( ")", this.currentToken() );
			}

			this.readToken(); // )
		}

		return target.initialValueExpression( params );
	}

	private Value parseCall( final BasicScope scope )
	{
		return this.parseCall( scope, null );
	}

	private Value parseCall( final BasicScope scope, final Value firstParam )
	{
		if ( this.nextToken() == null || !this.nextToken().equals( "(" ) )
		{
			return null;
		}

		if ( !this.parseIdentifier( this.currentToken() ) )
		{
			return null;
		}

		String name = this.currentToken();
		this.readToken(); //name

		ValueList params = parseParameters( scope, firstParam );
		Function target = this.findFunction( scope, name, params );

		if ( target == null )
		{
			throw this.parseException( "Undefined reference to function '" + name + "'" );
		}

		FunctionCall call = new FunctionCall( target, params, this );

		return parsePostCall( scope, call );
	}

	private ValueList parseParameters( final BasicScope scope, final Value firstParam )
	{
		if ( !this.currentToken().equals( "(" ) )
		{
			return null;
		}

		this.readToken(); //(

		ValueList params = new ValueList();
		if ( firstParam != null )
		{
			params.add( firstParam );
		}

		while ( this.currentToken() != null && !this.currentToken().equals( ")" ) )
		{
			Value val = this.parseExpression( scope );
			if ( val != null )
			{
				params.add( val );
			}

			if ( !this.currentToken().equals( "," ) )
			{
				if ( !this.currentToken().equals( ")" ) )
				{
					throw this.parseException( ")", this.currentToken() );
				}
			}
			else
			{
				this.readToken();
				if ( this.currentToken().equals( ")" ) )
				{
					throw this.parseException( "parameter", this.currentToken() );
				}
			}
		}

		if ( !this.currentToken().equals( ")" ) )
		{
			throw this.parseException( ")", this.currentToken() );
		}

		this.readToken(); // )

		return params;
	}

	private Value parsePostCall( final BasicScope scope, FunctionCall call )
	{
		Value result = call;
		while ( result != null && this.currentToken() != null && this.currentToken().equals( "." ) )
		{
			Variable current = new Variable( result.getType() );
			current.setExpression( result );

			result = this.parseVariableReference( scope, current );
		}

		return result;
	}

	private Value parseInvoke( final BasicScope scope )
	{
		if ( this.currentToken() == null || !this.currentToken().equalsIgnoreCase( "call" ) )
		{
			return null;
		}

		this.readToken(); // call

		Type type = this.parseType( scope, true, false );

		// You can omit the type, but then this function invocation
		// cannot be used in an expression

		if ( type == null )
		{
			type = DataTypes.VOID_TYPE;
		}

		String current = this.currentToken();
		Value name = null;

		if ( current.equals( "(" ) )
		{
			name = this.parseExpression( scope );
			if ( name == null || !name.getType().equals( DataTypes.STRING_TYPE ) )
			{
				throw this.parseException( "String expression expected for function name" );
			}
		}
		else
		{
			if ( !this.parseIdentifier( current ) )
			{
				throw this.parseException( "Variable reference expected for function name" );
			}

			name = this.parseVariableReference( scope );

			if ( name == null || !( name instanceof VariableReference ) )
			{
				throw this.parseException( "Variable reference expected for function name" );
			}
		}

		ValueList params = parseParameters( scope, null );

		FunctionInvocation call = new FunctionInvocation( scope, type, name, params, this );

		return parsePostCall( scope, call );
	}

        private final Function findFunction( final BasicScope scope, final String name, final ValueList params )
	{
                Function result = this.findFunction( scope, scope.getFunctionList(), name, params, true );

                if ( result == null )
                {
                        result = this.findFunction( scope, RuntimeLibrary.functions, name, params, true );
                }
                if ( result == null )
                {
                        result = this.findFunction( scope, scope.getFunctionList(), name, params, false );
                }
                if ( result == null )
                {
                        result = this.findFunction( scope, RuntimeLibrary.functions, name, params, false );
                }

                // Just in case there's some people who don't want to edit
                // their scripts to use the new function format, check for
                // the old versions as well.

                if ( result == null )
                {
                        if ( name.endsWith( "to_string" ) )
                        {
                                return this.findFunction( scope, "to_string", params );
                        }
                        if ( name.endsWith( "to_boolean" ) )
                        {
                                return this.findFunction( scope, "to_boolean", params );
                        }
                        if ( name.endsWith( "to_int" ) )
                        {
                                return this.findFunction( scope, "to_int", params );
                        }
                        if ( name.endsWith( "to_float" ) )
                        {
                                return this.findFunction( scope, "to_float", params );
                        }
                        if ( name.endsWith( "to_item" ) )
                        {
                                return this.findFunction( scope, "to_item", params );
                        }
                        if ( name.endsWith( "to_class" ) )
                        {
                                return this.findFunction( scope, "to_class", params );
                        }
                        if ( name.endsWith( "to_stat" ) )
                        {
                                return this.findFunction( scope, "to_stat", params );
                        }
                        if ( name.endsWith( "to_skill" ) )
                        {
                                return this.findFunction( scope, "to_skill", params );
                        }
                        if ( name.endsWith( "to_effect" ) )
                        {
                                return this.findFunction( scope, "to_effect", params );
                        }
                        if ( name.endsWith( "to_location" ) )
                        {
                                return this.findFunction( scope, "to_location", params );
                        }
                        if ( name.endsWith( "to_familiar" ) )
                        {
                                return this.findFunction( scope, "to_familiar", params );
                        }
                        if ( name.endsWith( "to_monster" ) )
                        {
                                return this.findFunction( scope, "to_monster", params );
                        }
                        if ( name.endsWith( "to_slot" ) )
                        {
                                return this.findFunction( scope, "to_slot", params );
                        }
                        if ( name.endsWith( "to_url" ) )
                        {
                                return this.findFunction( scope, "to_url", params );
                        }
                }

		return result;
        }

	private final Function findFunction( final BasicScope scope, final FunctionList source,
					     final String name, final ValueList params,
					     boolean isExactMatch )
	{
		String errorMessage = null;

		Function[] functions = source.findFunctions( name );

		// First, try to find an exact match on parameter types.
		// This allows strict matches to take precedence.

		for ( int i = 0; i < functions.length; ++i )
		{
			errorMessage = null;

			if ( params == null )
			{
				return functions[ i ];
			}

			Iterator refIterator = functions[ i ].getReferences();
			Iterator valIterator = params.iterator();

			VariableReference currentParam;
			Value currentValue;
			int paramIndex = 1;

			while ( errorMessage == null && refIterator.hasNext() && valIterator.hasNext() )
			{
				currentParam = (VariableReference) refIterator.next();
				currentValue = (Value) valIterator.next();

				if ( isExactMatch )
				{
					if ( currentParam.getType() != currentValue.getType() )
					{
						errorMessage =
							"Illegal parameter #" + paramIndex + " for function " + name + ". Got " + currentValue.getType() + ", need " + currentParam.getType();
					}
				}
				else if ( !Parser.validCoercion( currentParam.getType(), currentValue.getType(), "parameter" ) )
				{
					errorMessage =
						"Illegal parameter #" + paramIndex + " for function " + name + ". Got " + currentValue.getType() + ", need " + currentParam.getType();
				}

				++paramIndex;
			}

			if ( errorMessage == null && ( refIterator.hasNext() || valIterator.hasNext() ) )
			{
				errorMessage =
					"Illegal amount of parameters for function " + name + ". Got " + params.size() + ", expected " + functions[ i ].getVariableReferences().size();
			}

			if ( errorMessage == null )
			{
				return functions[ i ];
			}
		}

		if ( !isExactMatch && scope.getParentScope() != null )
		{
			return findFunction( scope.getParentScope(), name, params );
		}

		if ( !isExactMatch && source == RuntimeLibrary.functions && errorMessage != null )
		{
			throw this.parseException( errorMessage );
		}

		return null;
	}

	private ParseTreeNode parseAssignment( final BasicScope scope )
	{
		if ( this.nextToken() == null )
		{
			return null;
		}

		if ( !this.nextToken().equals( "=" ) && !this.nextToken().equals( "[" ) && !this.nextToken().equals( "." ) )
		{
			return null;
		}

		if ( !this.parseIdentifier( this.currentToken() ) )
		{
			return null;
		}

		Value lhs = this.parseVariableReference( scope );
		if ( lhs instanceof FunctionCall )
		{
			return lhs;
		}

		if ( lhs == null || !( lhs instanceof VariableReference ) )
		{
			throw this.parseException( "Variable reference expected" );
		}

		if ( !this.currentToken().equals( "=" ) )
		{
			return null;
		}

		this.readToken(); //=

		Value rhs = this.parseExpression( scope );

		if ( rhs == null )
		{
			throw this.parseException( "Internal error" );
		}

		if ( !Parser.validCoercion( lhs.getType(), rhs.getType(), "assign" ) )
		{
			throw this.parseException(
				"Cannot store " + rhs.getType() + " in " + lhs + " of type " + lhs.getType() );
		}

		return new Assignment( (VariableReference) lhs, rhs );
	}

	private Value parseRemove( final BasicScope scope )
	{
		if ( this.currentToken() == null || !this.currentToken().equals( "remove" ) )
		{
			return null;
		}

		Value lhs = this.parseExpression( scope );

		if ( lhs == null )
		{
			throw this.parseException( "Bad 'remove' statement" );
		}

		return lhs;
	}

	private Value parseExpression( final BasicScope scope )
	{
		return this.parseExpression( scope, null );
	}

	private Value parseExpression( final BasicScope scope, final Operator previousOper )
	{
		if ( this.currentToken() == null )
		{
			return null;
		}

		Value lhs = null;
		Value rhs = null;
		Operator oper = null;

		if ( this.currentToken().equals( "!" ) )
		{
			String operator = this.currentToken();
			this.readToken(); // !
			if ( ( lhs = this.parseValue( scope ) ) == null )
			{
				throw this.parseException( "Value expected" );
			}

			lhs = new Expression( lhs, null, new Operator( operator, this ) );
			if ( lhs.getType() != DataTypes.BOOLEAN_TYPE )
			{
				throw this.parseException( "\"!\" operator requires a boolean value" );
			}
		}
		else if ( this.currentToken().equals( "-" ) )
		{
			// See if it's a negative numeric constant
			if ( ( lhs = this.parseValue( scope ) ) != null )
			{
				return lhs;
			}

			// Nope. Must be unary minus.
			String operator = this.currentToken();
			this.readToken(); // !
			if ( ( lhs = this.parseValue( scope ) ) == null )
			{
				throw this.parseException( "Value expected" );
			}

			lhs = new Expression( lhs, null, new Operator( operator, this ) );
		}
		else if ( this.currentToken().equals( "remove" ) )
		{
			String operator = this.currentToken();
			this.readToken(); // remove

			lhs = this.parseVariableReference( scope );
			if ( lhs == null || !( lhs instanceof CompositeReference ) )
			{
				throw this.parseException( "Aggregate reference expected" );
			}

			lhs = new Expression( lhs, null, new Operator( operator, this ) );
		}
		else if ( ( lhs = this.parseValue( scope ) ) == null )
		{
			return null;
		}

		do
		{
			oper = this.parseOperator( this.currentToken() );

			if ( oper == null )
			{
				return lhs;
			}

			if ( previousOper != null && !oper.precedes( previousOper ) )
			{
				return lhs;
			}

			this.readToken(); //operator

			if ( ( rhs = this.parseExpression( scope, oper ) ) == null )
			{
				throw this.parseException( "Value expected" );
			}

			if ( !Parser.validCoercion( lhs.getType(), rhs.getType(), oper.toString() ) )
			{
				throw this.parseException(
					"Cannot apply operator " + oper + " to " + lhs + " (" + lhs.getType() + ") and " + rhs + " (" + rhs.getType() + ")" );
			}

			lhs = new Expression( lhs, rhs, oper );
		}
		while ( true );
	}

	private Value parseValue( final BasicScope scope )
	{
		if ( this.currentToken() == null )
		{
			return null;
		}

		Value result = null;

		// Parse parenthesized expressions
		if ( this.currentToken().equals( "(" ) )
		{
			this.readToken(); // (

			result = this.parseExpression( scope );
			if ( this.currentToken() == null || !this.currentToken().equals( ")" ) )
			{
				throw this.parseException( ")", this.currentToken() );
			}

			this.readToken(); // )
		}

		// Parse constant values
		// true and false are reserved words

		else if ( this.currentToken().equalsIgnoreCase( "true" ) )
		{
			this.readToken();
			result = DataTypes.TRUE_VALUE;
		}

		else if ( this.currentToken().equalsIgnoreCase( "false" ) )
		{
			this.readToken();
			result = DataTypes.FALSE_VALUE;
		}

		// numbers
		else if ( ( result = this.parseNumber() ) != null )
		{
			;
		}

		else if ( this.currentToken().equals( "\"" ) || this.currentToken().equals( "\'" ) )
		{
			result = this.parseString( null );
		}

		else if ( this.currentToken().equals( "$" ) )
		{
			result = this.parseTypedConstant( scope );
		}

		else if ( this.currentToken().equalsIgnoreCase( "new" ) )
		{
			this.readToken();
			result = this.parseNewRecord( scope );
		}

		else if ( ( result = this.parseInvoke( scope ) ) != null )
		{
			;
		}

		else if ( ( result = this.parseCall( scope, result ) ) != null )
		{
			;
		}

		else if ( ( result = this.parseVariableReference( scope ) ) != null )
		{
			;
		}

		Variable current;
		while ( result != null && this.currentToken() != null && this.currentToken().equals( "." ) )
		{
			current = new Variable( result.getType() );
			current.setExpression( result );

			result = this.parseVariableReference( scope, current );
		}

		return result;
	}

	private Value parseNumber()
	{
		if ( this.currentToken() == null )
		{
			return null;
		}

		int sign = 1;

		if ( this.currentToken().equals( "-" ) )
		{
			String next = this.nextToken();

			if ( next == null )
			{
				return null;
			}

			if ( !next.equals( "." ) && !this.readIntegerToken( next ) )
			{
				// Unary minus
				return null;
			}

			sign = -1;
			this.readToken(); // Read -
		}

		if ( this.currentToken().equals( "." ) )
		{
			this.readToken();
			String fraction = this.currentToken();

			if ( !this.readIntegerToken( fraction ) )
			{
				throw this.parseException( "numeric value", fraction );
			}

			this.readToken(); // integer
			return new Value( sign * StringUtilities.parseFloat( "0." + fraction ) );
		}

		String integer = this.currentToken();
		if ( !this.readIntegerToken( integer ) )
		{
			return null;
		}

		this.readToken(); // integer

		if ( this.currentToken().equals( "." ) )
		{
			String fraction = this.nextToken();
			if ( !this.readIntegerToken( fraction ) )
			{
				return new Value( sign * StringUtilities.parseInt( integer ) );
			}

			this.readToken(); // .
			this.readToken(); // fraction

			return new Value( sign * StringUtilities.parseFloat( integer + "." + fraction ) );
		}

		return new Value( sign * StringUtilities.parseInt( integer ) );
	}

	private boolean readIntegerToken( final String token )
	{
		if ( token == null )
		{
			return false;
		}

		for ( int i = 0; i < token.length(); ++i )
		{
			if ( !Character.isDigit( token.charAt( i ) ) )
			{
				return false;
			}
		}

		return true;
	}

	private Value parseString( Type type )
	{
		// Directly work with currentLine - ignore any "tokens" you meet until
		// the string is closed

		StringBuffer resultString = new StringBuffer();
		char stopCharacter, ch;
		ArrayList list = null;
		if ( type == null )
		{	// Plain string constant
			stopCharacter = this.currentLine.charAt( 0 );
		}
		else
		{	// Typed plural constant - handled by same code as plain strings
			// so that they can share escape character processing
			stopCharacter = ']';
			list = new ArrayList();
		}

		for ( int i = 1; ; ++i )
		{
			if ( i == this.currentLine.length() )
			{
				if ( type == null )
				{	// Plain strings can't span lines
					throw this.parseException( "No closing \" found" );
				}
				this.currentLine = "";
				this.fixLines();
				i = 0;
				if ( this.currentLine == null )
				{
					throw this.parseException( "No closing ] found" );
				}
			}

			ch = this.currentLine.charAt( i );
			if ( ch == '\\' )
			{
				ch = this.currentLine.charAt( ++i );

				switch ( ch )
				{
				case 'n':
					resultString.append( '\n' );
					break;

				case 'r':
					resultString.append( '\r' );
					break;

				case 't':
					resultString.append( '\t' );
					break;

				case 'x':
					BigInteger hex08 = new BigInteger( this.currentLine.substring( i + 1, i + 3 ), 16 );
					resultString.append( (char) hex08.intValue() );
					i += 2;
					break;

				case 'u':
					BigInteger hex16 = new BigInteger( this.currentLine.substring( i + 1, i + 5 ), 16 );
					resultString.append( (char) hex16.intValue() );
					i += 4;
					break;

				default:
					if ( Character.isDigit( ch ) )
					{
						BigInteger octal = new BigInteger( this.currentLine.substring( i, i + 3 ), 8 );
						resultString.append( (char) octal.intValue() );
						i += 2;
						break;
					}
					resultString.append( ch );
				}
			}
			else if ( ch == stopCharacter ||
				( type != null && ch == ',' ) )
			{
				if ( type == null )
				{	// Plain string
					this.currentLine = this.currentLine.substring( i + 1 ); //+ 1 to get rid of '"' token
					return new Value( resultString.toString() );
				}
				String element = resultString.toString().trim();
				resultString.setLength( 0 );
				if ( element.length() != 0 )
				{
					Value value = DataTypes.parseValue( type, element, false );
					if ( value == null )
					{
						throw this.parseException( "Bad " + type.toString() + " value: \"" + element + "\"" );
					}
					list.add( value );
				}
				if ( ch == ']' )
				{
					this.currentLine = this.currentLine.substring( i + 1 );
					if ( list.size() == 0 )
					{	// Empty list - caller will interpret this specially
						return null;
					}
					return new PluralValue( type, list );
				}
			}
			else
			{
				resultString.append( this.currentLine.charAt( i ) );
			}
		}
	}

	private Value parseTypedConstant( final BasicScope scope )
	{
		this.readToken(); // read $

		String name = this.currentToken();
		Type type = this.parseType( scope, false, false );
		if ( type == null )
		{
			StringBuffer buf = new StringBuffer( this.currentLine );
			if ( name.endsWith( "s" ) )
			{
				buf.deleteCharAt( name.length() - 1 );
				this.currentLine = buf.toString();
				type = this.parseType( scope, false, false );
				if ( type == null && name.endsWith( "es" ) )
				{
					buf.deleteCharAt( name.length() - 2 );
					this.currentLine = buf.toString();
					type = this.parseType( scope, false, false );
				}
				if ( type == null )
				{
					throw this.parseException( "Unknown type " + name );
				}
				if ( !type.isPrimitive() )
				{
					throw this.parseException( "Non-primitive type " + name );
				}
				Value value = this.parseString( type );
				if ( value != null ) return value;	// explicit list of values
				value = type.allValues();
				if ( value != null ) return value;	// implicit enumeration
				throw this.parseException( "Can't enumerate all " + name );
			}
		}
		if ( !type.isPrimitive() )
		{
			throw this.parseException( "Non-primitive type " + name );
		}

		if ( !this.currentToken().equals( "[" ) )
		{
			throw this.parseException( "[", this.currentToken() );
		}

		StringBuffer resultString = new StringBuffer();

		for ( int i = 1;; ++i )
		{
			if ( i == this.currentLine.length() )
			{
				throw this.parseException( "No closing ] found" );
			}
			else if ( this.currentLine.charAt( i ) == '\\' )
			{
				resultString.append( this.currentLine.charAt( ++i ) );
			}
			else if ( this.currentLine.charAt( i ) == ']' )
			{
				this.currentLine = this.currentLine.substring( i + 1 ); //+1 to get rid of ']' token
				String input = resultString.toString().trim();
				Value value = DataTypes.parseValue( type, input, false );
				if ( value == null )
				{
					throw this.parseException( "Bad " + type.toString() + " value: \"" + input + "\"" );
				}
				return value;
			}
			else
			{
				resultString.append( this.currentLine.charAt( i ) );
			}
		}
	}

	private Operator parseOperator( final String oper )
	{
		if ( oper == null || !this.isOperator( oper ) )
		{
			return null;
		}

		return new Operator( oper, this );
	}

	private boolean isOperator( final String oper )
	{
		return oper.equals( "!" ) ||
			oper.equals( "*" ) ||
			oper.equals( "^" ) ||
			oper.equals( "/" ) ||
			oper.equals( "%" ) ||
			oper.equals( "+" ) ||
			oper.equals( "-" ) ||
			oper.equals( "<" ) ||
			oper.equals( ">" ) ||
			oper.equals( "<=" ) ||
			oper.equals( ">=" ) ||
			oper.equals( "==" ) ||
			oper.equals( "!=" ) ||
			oper.equals( "||" ) ||
			oper.equals( "&&" ) ||
			oper.equals( "contains" ) ||
			oper.equals( "remove" );
	}

	private Value parseVariableReference( final BasicScope scope )
	{
		if ( this.currentToken() == null || !this.parseIdentifier( this.currentToken() ) )
		{
			return null;
		}

		String name = this.currentToken();
		Variable var = scope.findVariable( name, true );

		if ( var == null )
		{
			throw this.parseException( "Unknown variable '" + name + "'" );
		}

		this.readToken(); // read name

		if ( this.currentToken() == null || !this.currentToken().equals( "[" ) && !this.currentToken().equals( "." ) )
		{
			return new VariableReference( var );
		}

		return this.parseVariableReference( scope, var );
	}

	private Value parseVariableReference( final BasicScope scope, final Variable var )
	{
		Type type = var.getType();
		ValueList indices = new ValueList();

		boolean parseAggregate = this.currentToken().equals( "[" );

		while ( this.currentToken() != null && ( this.currentToken().equals( "[" ) || this.currentToken().equals( "." ) || parseAggregate && this.currentToken().equals(
			"," ) ) )
		{
			Value index;

			type = type.getBaseType();

			if ( this.currentToken().equals( "[" ) || this.currentToken().equals( "," ) )
			{
				this.readToken(); // read [ or . or ,
				parseAggregate = true;

				if ( !( type instanceof AggregateType ) )
				{
					if ( indices.isEmpty() )
					{
						throw this.parseException( "Variable '" + var.getName() + "' cannot be indexed" );
					}
					else
					{
						throw this.parseException( "Too many keys for '" + var.getName() + "'" );
					}
				}

				AggregateType atype = (AggregateType) type;
				index = this.parseExpression( scope );
				if ( index == null )
				{
					throw this.parseException( "Index for '" + var.getName() + "' expected" );
				}

				if ( !index.getType().equals( atype.getIndexType() ) )
				{
					throw this.parseException(
						"Index for '" + var.getName() + "' has wrong data type " + "(expected " + atype.getIndexType() + ", got " + index.getType() + ")" );
				}

				type = atype.getDataType();
			}
			else
			{
				this.readToken(); // read [ or . or ,

				// Maybe it's a function call with an implied "this" parameter.

				if ( this.nextToken().equals( "(" ) )
				{
					return this.parseCall(
						scope, indices.isEmpty() ? new VariableReference( var ) : new CompositeReference( var, indices, this ) );
				}

				if ( !( type instanceof RecordType ) )
				{
					throw this.parseException( "Record expected" );
				}

				RecordType rtype = (RecordType) type;

				String field = this.currentToken();
				if ( field == null || !this.parseIdentifier( field ) )
				{
					throw this.parseException( "Field name expected" );
				}

				index = rtype.getFieldIndex( field );
				if ( index == null )
				{
					throw this.parseException( "Invalid field name '" + field + "'" );
				}
				this.readToken(); // read name
				type = rtype.getDataType( index );
			}

			indices.add( index );

			if ( parseAggregate && this.currentToken() != null )
			{
				if ( this.currentToken().equals( "]" ) )
				{
					this.readToken(); // read ]
					parseAggregate = false;
				}
			}
		}

		if ( parseAggregate )
		{
			throw this.parseException( this.currentToken(), "]" );
		}

		return new CompositeReference( var, indices, this );
	}

	private String parseDirective( final String directive )
	{
		if ( this.currentToken() == null || !this.currentToken().equalsIgnoreCase( directive ) )
		{
			return null;
		}

		this.readToken(); //directive

		if ( this.currentToken() == null )
		{
			throw this.parseException( "<", this.currentToken() );
		}

		int startIndex = this.currentLine.indexOf( "<" );
		int endIndex = this.currentLine.indexOf( ">" );

		if ( startIndex != -1 && endIndex == -1 )
		{
			throw this.parseException( "No closing > found" );
		}

		if ( startIndex == -1 )
		{
			startIndex = this.currentLine.indexOf( "\"" );
			endIndex = this.currentLine.indexOf( "\"", startIndex + 1 );

			if ( startIndex != -1 && endIndex == -1 )
			{
				throw this.parseException( "No closing \" found" );
			}
		}

		if ( startIndex == -1 )
		{
			startIndex = this.currentLine.indexOf( "\'" );
			endIndex = this.currentLine.indexOf( "\'", startIndex + 1 );

			if ( startIndex != -1 && endIndex == -1 )
			{
				throw this.parseException( "No closing \' found" );
			}
		}

		if ( endIndex == -1 )
		{
			endIndex = this.currentLine.indexOf( ";" );
			if ( endIndex == -1 )
			{
				endIndex = this.currentLine.length();
			}
		}

		String resultString = this.currentLine.substring( startIndex + 1, endIndex );
		this.currentLine = this.currentLine.substring( endIndex );

		if ( this.currentToken().equals( ">" ) || this.currentToken().equals( "\"" ) || this.currentToken().equals(
			"\'" ) )
		{
			this.readToken(); //get rid of '>' or '"' token
		}

		if ( this.currentToken().equals( ";" ) )
		{
			this.readToken(); //read ;
		}

		return resultString;
	}

	private void parseNotify()
	{
		String resultString = this.parseDirective( "notify" );
		if ( this.notifyRecipient == null )
		{
			this.notifyRecipient = resultString;
		}
	}

	private String parseImport()
	{
		return this.parseDirective( "import" );
	}

	public static final boolean validCoercion( Type lhs, Type rhs, final String oper )
	{
		// Resolve aliases

		lhs = lhs.getBaseType();
		rhs = rhs.getBaseType();

		// "oper" is either a standard operator or is a special name:
		//
		// "parameter" - value used as a function parameter
		//	lhs = parameter type, rhs = expression type
		//
		// "return" - value returned as function value
		//	lhs = function return type, rhs = expression type
		//
		// "assign" - value
		//	lhs = variable type, rhs = expression type

		// The "contains" operator requires an aggregate on the left
		// and the correct index type on the right.

		if ( oper.equals( "contains" ) )
		{
			return lhs.getType() == DataTypes.TYPE_AGGREGATE && ( (AggregateType) lhs ).getIndexType().equals(
				rhs );
		}

		// If the types are equal, no coercion is necessary
		if ( lhs.equals( rhs ) )
		{
			return true;
		}

		if ( lhs.equals( DataTypes.TYPE_ANY ) && rhs.getType() != DataTypes.TYPE_AGGREGATE )
		{
			return true;
		}

		// Anything coerces to a string
		if ( lhs.equals( DataTypes.TYPE_STRING ) )
		{
			return true;
		}

		// Anything coerces to a string for concatenation
		if ( oper.equals( "+" ) && rhs.equals( DataTypes.TYPE_STRING ) )
		{
			return true;
		}

		// Int coerces to float
		if ( lhs.equals( DataTypes.TYPE_INT ) && rhs.equals( DataTypes.TYPE_FLOAT ) )
		{
			return true;
		}

		if ( lhs.equals( DataTypes.TYPE_FLOAT ) && rhs.equals( DataTypes.TYPE_INT ) )
		{
			return true;
		}

		return false;
	}

	// **************** Tokenizer *****************

	private String getNextLine()
	{
		try
		{
			do
			{
				// Read a line from input, and break out of the
				// do-while loop when you've read a valid line

				this.fullLine = this.commandStream.readLine();

				// Return null at end of file
				if ( this.fullLine == null )
				{
					return null;
				}

				// Remove whitespace at front and end
				this.fullLine = this.fullLine.trim();
			}
			while ( this.fullLine.length() == 0 );

			// Found valid currentLine - return it

			return this.fullLine;
		}
		catch ( IOException e )
		{
			// This should not happen.  Therefore, print
			// a stack trace for debug purposes.

			StaticEntity.printStackTrace( e );
			return null;
		}
	}

	private String currentToken()
	{
		this.fixLines();
		if ( this.currentLine == null )
		{
			return null;
		}

		while ( this.currentLine.startsWith( "#" ) || this.currentLine.startsWith( "//" ) )
		{
			this.currentLine = "";

			this.fixLines();
			if ( this.currentLine == null )
			{
				return null;
			}
		}

		if ( !this.currentLine.trim().equals( "/*" ) )
		{
			return this.currentLine.substring( 0, this.tokenLength( this.currentLine ) );
		}

		while ( this.currentLine != null && !this.currentLine.trim().equals( "*/" ) )
		{
			this.currentLine = "";
			this.fixLines();
		}

		if ( this.currentLine == null )
		{
			return null;
		}

		this.currentLine = "";
		return this.currentToken();
	}

	private String nextToken()
	{
		this.fixLines();

		if ( this.currentLine == null )
		{
			return null;
		}

		if ( this.tokenLength( this.currentLine ) >= this.currentLine.length() )
		{
			if ( this.nextLine == null )
			{
				return null;
			}

			return this.nextLine.substring( 0, this.tokenLength( this.nextLine ) ).trim();
		}

		String result = this.currentLine.substring( this.tokenLength( this.currentLine ) ).trim();

		if ( result.equals( "" ) )
		{
			if ( this.nextLine == null )
			{
				return null;
			}

			return this.nextLine.substring( 0, this.tokenLength( this.nextLine ) );
		}

		return result.substring( 0, this.tokenLength( result ) );
	}

	private void readToken()
	{
		this.fixLines();

		if ( this.currentLine == null )
		{
			return;
		}

		this.currentLine = this.currentLine.substring( this.tokenLength( this.currentLine ) );
	}

	private int tokenLength( final String s )
	{
		int result;
		if ( s == null )
		{
			return 0;
		}

		for ( result = 0; result < s.length(); result++ )
		{
			if ( result + 1 < s.length() && this.tokenString( s.substring( result, result + 2 ) ) )
			{
				return result == 0 ? 2 : result;
			}

			if ( result < s.length() && this.tokenString( s.substring( result, result + 1 ) ) )
			{
				return result == 0 ? 1 : result;
			}
		}

		return result; //== s.length()
	}

	private void fixLines()
	{
		if ( this.currentLine == null )
		{
			return;
		}

		while ( this.currentLine.equals( "" ) )
		{
			this.currentLine = this.nextLine;
			this.lineNumber = this.commandStream.getLineNumber();
			this.nextLine = this.getNextLine();

			if ( this.currentLine == null )
			{
				return;
			}
		}

		this.currentLine = this.currentLine.trim();

		if ( this.nextLine == null )
		{
			return;
		}

		while ( this.nextLine.equals( "" ) )
		{
			this.nextLine = this.getNextLine();
			if ( this.nextLine == null )
			{
				return;
			}
		}

		this.nextLine = this.nextLine.trim();
	}

	private boolean tokenString( final String s )
	{
		if ( s.length() == 1 )
		{
			for ( int i = 0; i < Parser.tokenList.length; ++i )
			{
				if ( s.charAt( 0 ) == Parser.tokenList[ i ] )
				{
					return true;
				}
			}
			return false;
		}
		else
		{
			for ( int i = 0; i < Parser.multiCharTokenList.length; ++i )
			{
				if ( s.equalsIgnoreCase( Parser.multiCharTokenList[ i ] ) )
				{
					return true;
				}
			}

			return false;
		}
	}

	// **************** Parse errors *****************

	private final ScriptException parseException( final String expected, final String actual )
	{
		return this.parseException( "Expected " + expected + ", found " + actual );
	}

	private final ScriptException parseException( final String message )
	{
		return new ScriptException( message + " " + this.getLineAndFile() );
	}

	private final String getLineAndFile()
	{
		return Parser.getLineAndFile( this.shortFileName, this.lineNumber );
	}

	public static final String getLineAndFile( final String fileName, final int lineNumber )
	{
		if ( fileName == null )
		{
			return "(" + Preferences.getString( "commandLineNamespace" ) + ")";
		}

		return "(" + fileName + ", line " + lineNumber + ")";
	}

	public static void printIndices( final ValueList indices, final PrintStream stream, final int indent )
	{
		if ( indices == null )
		{
			return;
		}

		Iterator it = indices.iterator();
		while ( it.hasNext() )
		{
			Value current = (Value) it.next();
			Interpreter.indentLine( stream, indent );
			stream.println( "<KEY>" );
			current.print( stream, indent + 1 );
		}
	}
}
