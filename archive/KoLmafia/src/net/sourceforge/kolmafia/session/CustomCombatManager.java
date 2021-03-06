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
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

package net.sourceforge.kolmafia.session;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;

import java.nio.channels.FileChannel;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.TreeMap;

import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreeNode;

import net.java.dev.spellcast.utilities.DataUtilities;
import net.java.dev.spellcast.utilities.LockableListModel;
import net.sourceforge.kolmafia.KoLConstants;
import net.sourceforge.kolmafia.KoLmafia;
import net.sourceforge.kolmafia.KoLmafiaCLI;
import net.sourceforge.kolmafia.LogStream;
import net.sourceforge.kolmafia.RequestLogger;
import net.sourceforge.kolmafia.RequestThread;
import net.sourceforge.kolmafia.StaticEntity;
import net.sourceforge.kolmafia.objectpool.ItemPool;
import net.sourceforge.kolmafia.persistence.ItemDatabase;
import net.sourceforge.kolmafia.persistence.Preferences;
import net.sourceforge.kolmafia.persistence.SkillDatabase;
import net.sourceforge.kolmafia.request.GenericRequest;
import net.sourceforge.kolmafia.session.InventoryManager;
import net.sourceforge.kolmafia.utilities.FileUtilities;
import net.sourceforge.kolmafia.utilities.StringUtilities;

public abstract class CustomCombatManager
{
	private static final GenericRequest AUTO_ATTACKER = new GenericRequest( "account.php?action=autoattack" );

	private static String[] keys = new String[ 0 ];
	private static File settingsFile = null;

	private static final LockableListModel availableScripts = new LockableListModel();
	private static final TreeMap reference = new TreeMap();
	private static final CombatSettingNode root = new CombatSettingNode();

	public static final LockableListModel getAvailableScripts()
	{
		CustomCombatManager.availableScripts.clear();

		String[] list = DataUtilities.list( KoLConstants.CCS_LOCATION );

		for ( int i = 0; i < list.length; ++i )
		{
			if ( list[ i ].endsWith( ".ccs" ) )
			{
				String name = list[ i ].substring( 0, list[ i ].length() - 4 );
				CustomCombatManager.availableScripts.add( name );
			}
		}

		if ( !CustomCombatManager.availableScripts.contains( "default" ) )
		{
			CustomCombatManager.availableScripts.add( "default" );
		}

		return CustomCombatManager.availableScripts;
	}

	public static void setScript()
	{
		CustomCombatManager.setScript( CustomCombatManager.settingName() );
	}

	public static void setScript( String name )
	{
		if ( name == null || name.equals( "" ) )
		{
			name = "default";
		}

		name = StringUtilities.globalStringDelete( name.toLowerCase().trim(), " " );

		if ( name.endsWith( ".ccs" ) )
		{
			name = name.substring( 0, name.length() - 4 );
		}

		if ( !CustomCombatManager.availableScripts.contains( name ) )
		{
			CustomCombatManager.availableScripts.add( name );
		}

                CustomCombatManager.availableScripts.setSelectedItem( name );

		name = name + ".ccs";

		CustomCombatManager.loadSettings( name );
		Preferences.setString( "customCombatScript", name );
	}

	public static final String settingName()
	{
		String script = Preferences.getString( "customCombatScript" );
		return script.endsWith( ".ccs" ) ? script.substring( 0, script.length() - 4 ) : "default";
	}

	public static final String settingsFileName()
	{
		return CustomCombatManager.settingName() + ".ccs";
	}

	public static final String settingsFileName( String name )
	{
		if ( name.endsWith( ".ccs" ) )
			return name;
		return name + ".ccs";
	}

	public static final TreeNode getRoot()
	{
		return CustomCombatManager.root;
	}

	public static final void copySettings( String name )
	{
		if ( name == null || name.equals( "" ) )
		{
			return;
		}

		File source = new File( KoLConstants.CCS_LOCATION, CustomCombatManager.settingsFileName() );
		File destination = new File( KoLConstants.CCS_LOCATION, CustomCombatManager.settingsFileName( name ) );

		FileUtilities.copyFile( source, destination );
	}

	public static final String getSettingsFileLocation()
	{
		if ( CustomCombatManager.settingsFile == null )
		{
			return "unknown";
		}

		return CustomCombatManager.settingsFile.getAbsolutePath();
	}

	/**
	 * Loads the settings located in the given file into this object. Note that all settings are overridden; if the
	 * given file does not exist, the current global settings will also be rewritten into the appropriate file.
	 *
	 * @param source The file that contains (or will contain) the character data
	 */

	public static final void loadSettings()
	{
		CustomCombatManager.loadSettings( CustomCombatManager.settingsFileName() );
	}

	private static final void loadSettings( final String filename )
	{
		CustomCombatManager.root.removeAllChildren();
		CustomCombatManager.reference.clear();

		CustomCombatManager.settingsFile = new File( KoLConstants.CCS_LOCATION, filename );

		// First guarantee that a settings file exists with
		// the appropriate Properties data.

		CustomCombatManager.readSettings();

		if ( CustomCombatManager.reference.size() == 0 )
		{
			PrintStream ostream = LogStream.openStream( CustomCombatManager.settingsFile, true );
			ostream.println( "[ default ]" );
			ostream.println( "1: special action" );
			ostream.println( "2: attack with weapon" );
			ostream.close();

			CustomCombatManager.readSettings();
		}
	}

	private static final void readSettings()
	{
		try
		{
			BufferedReader reader = FileUtilities.getReader( CustomCombatManager.settingsFile );
			String line;
			CombatSettingNode currentList = CustomCombatManager.root;

			while ( ( line = reader.readLine() ) != null )
			{
				line = line.trim();
				if ( line.startsWith( "[" ) )
				{
					if ( currentList != CustomCombatManager.root && currentList.getChildCount() == 0 )
					{
						currentList.add( new CombatActionNode( 1, "attack with weapon" ) );
					}

					String currentKey = CustomCombatManager.encounterKey( line.substring( 1, line.length() - 1 ) );
					currentList = new CombatSettingNode( currentKey );

					CustomCombatManager.reference.put( currentKey, currentList );
					CustomCombatManager.root.add( currentList );
					continue;
				}

				if ( line.length() == 0 )
				{
					continue;
				}

				int desiredIndex = currentList.getChildCount() + 1;

				// If it looks like this is a KoLmafia-created settings file,
				// then parse it accordingly.

				if ( Character.isDigit( line.charAt( 0 ) ) )
				{
					int colonIndex = line.indexOf( ":" );
					if ( colonIndex != -1 )
					{
						desiredIndex = StringUtilities.parseInt( line.substring( 0, colonIndex ) );
						line = line.substring( colonIndex + 1 );
					}
				}

				if ( desiredIndex >= currentList.getChildCount() )
				{
					String action =
						currentList.getChildCount() > 0 ? ( (CombatActionNode) currentList.getLastChild() ).action : "attack with weapon";

					while ( currentList.getChildCount() < desiredIndex - 1 )
					{
						currentList.add( new CombatActionNode( currentList.getChildCount() + 1, action ) );
					}

					currentList.add( new CombatActionNode( desiredIndex, line ) );
				}
			}

			if ( currentList != CustomCombatManager.root && currentList.getChildCount() == 0 )
			{
				currentList.add( new CombatActionNode( 1, "delevel and plink" ) );
			}

			reader.close();
			reader = null;

			CustomCombatManager.keys = new String[ CustomCombatManager.reference.size() ];
			CustomCombatManager.reference.keySet().toArray( CustomCombatManager.keys );
		}
		catch ( IOException e1 )
		{
			// This should not happen.  Therefore, print
			// a stack trace for debug purposes.

			StaticEntity.printStackTrace( e1 );
		}
	}

	public static final String encounterKey( final String line )
	{
		return CustomCombatManager.encounterKey( line, true );
	}

	public static final String encounterKey( String line, final boolean changeCase )
	{
		line = StringUtilities.globalStringReplace( line.trim(), "  ", " " );
		String key = StringUtilities.getCanonicalName( line );

		if ( key.startsWith( "a " ) )
		{
			key = key.substring( 2 );
			line = line.substring( 2 );
		}
		else if ( key.startsWith( "an " ) )
		{
			key = key.substring( 3 );
			line = line.substring( 3 );
		}
		else if ( key.startsWith( "the " ) )
		{
			// It really is "The Man" or "The Astronomer"
		}
		else if ( key.startsWith( "some " ) )
		{
			key = key.substring( 5 );
			line = line.substring( 5 );
		}

		return changeCase ? key : line;
	}

	public static final void setAutoAttack( String attackName )
	{
		if ( attackName.equals( "" ) )
		{
			return;
		}

		int skillId;

		if ( attackName.indexOf( "disabled" ) != -1 )
		{
			skillId = 0;
		}
		else if ( attackName.indexOf( "attack" ) != -1 || attackName.indexOf( "default" ) != -1 )
		{
			skillId = 1;
		}
		else if ( !Character.isDigit( attackName.charAt( 0 ) ) )
		{
			List combatSkills = SkillDatabase.getSkillsByType( SkillDatabase.COMBAT );
			String skillName = KoLmafiaCLI.getSkillName( attackName, combatSkills );

			if ( skillName == null )
			{
				return;
			}

			skillId = SkillDatabase.getSkillId( skillName );
		}
		else
		{
			skillId = StringUtilities.parseInt( attackName );
		}

		CustomCombatManager.setAutoAttack( skillId );
	}

	public static final void setAutoAttack( int skillId )
	{
		if ( skillId != 1 && (skillId < 1000 || skillId > 7000) )
		{
			skillId = 0;
		}

		String skillName;
		switch ( skillId )
		{
		case 0:
			skillName = "disabled";
			break;
		case 1:
			skillName = "attack with weapon";
			break;
		default:
			skillName = SkillDatabase.getSkillName( skillId ).toLowerCase();
			break;
		}

		if ( Preferences.getInteger( "defaultAutoAttack" ) != skillId )
		{
			RequestLogger.printLine( "Changing auto-attack: " + skillName );
			Preferences.setInteger( "defaultAutoAttack", skillId );

			CustomCombatManager.AUTO_ATTACKER.addFormField( "whichattack", String.valueOf( skillId ) );
			RequestThread.postRequest( CustomCombatManager.AUTO_ATTACKER );

			Preferences.setBoolean( "setAutoAttack", skillId != 0 );
		}
	}

	public static final void setDefaultAction( final String actionList )
	{
		CombatSettingNode currentList = (CombatSettingNode) CustomCombatManager.reference.get( "default" );
		currentList.removeAllChildren();

		String[] rounds = actionList.split( "\\s*;\\s*" );
		for ( int i = 0; i < rounds.length; ++i )
		{
			currentList.add( new CombatActionNode( i + 1, rounds[ i ] ) );
		}
	}

	public static final List getDefaultAction()
	{
		ArrayList nodeList = new ArrayList();
		CombatSettingNode currentList = (CombatSettingNode) CustomCombatManager.reference.get( "default" );
		for ( int i = 0; i < currentList.getChildCount(); ++i )
		{
			nodeList.add( currentList.getChildAt( i ) );
		}

		return nodeList;
	}

	/**
	 * Ensures that the given property exists, and if it does not exist, initializes it to the given value.
	 */

	private static final void ensureProperty( final String key, final String defaultValue )
	{
		if ( !CustomCombatManager.reference.containsKey( key ) )
		{
			CombatSettingNode defaultList = new CombatSettingNode( key );
			String[] elements = defaultValue.split( "\\s*;\\s*" );
			for ( int i = 0; i < elements.length; ++i )
			{
				defaultList.add( new CombatActionNode( i + 1, elements[ i ] ) );
			}

			CustomCombatManager.reference.put( key, defaultList );
			CustomCombatManager.root.add( defaultList );
		}
	}

	/**
	 * Stores the settings maintained in this <code>KoLSettings</code> to the noted file. Note that this method ALWAYS
	 * overwrites the given file.
	 */

	public static final void saveSettings()
	{
		PrintStream writer = LogStream.openStream( CustomCombatManager.settingsFile, true );

		CombatSettingNode combatOptions;
		for ( int i = 0; i < CustomCombatManager.keys.length; ++i )
		{
			writer.println( "[ " + CustomCombatManager.keys[ i ] + " ]" );

			combatOptions = (CombatSettingNode) CustomCombatManager.reference.get( CustomCombatManager.keys[ i ] );
			String action = null, newAction = null;

			for ( int j = 0; j < combatOptions.getChildCount(); ++j )
			{
				if ( action == null )
				{
					action = ( (CombatActionNode) combatOptions.getChildAt( j ) ).getAction();
					writer.println( combatOptions.getChildAt( j ) );
				}
				else
				{
					newAction = ( (CombatActionNode) combatOptions.getChildAt( j ) ).getAction();
					if ( !action.equals( newAction ) )
					{
						action = newAction;
						writer.println( combatOptions.getChildAt( j ) );
					}
				}
			}

			writer.println();
		}

		writer.close();
	}

	public static final String getSettingKey( final String encounter )
	{
		// Allow for longer matches (closer to exact matches)
		// by tracking the length of the match.

		int longestMatch = -1;
		int longestMatchLength = 0;

		if ( encounter != null && !encounter.equals( "" ) )
		{
			for ( int i = 0; i < CustomCombatManager.keys.length; ++i )
			{
				if ( encounter.indexOf( CustomCombatManager.keys[ i ] ) != -1 )
				{
					if ( CustomCombatManager.keys[ i ].length() > longestMatchLength )
					{
						longestMatch = i;
						longestMatchLength = CustomCombatManager.keys[ i ].length();
					}
				}
			}
		}

		if ( longestMatch != -1 )
		{
			return CustomCombatManager.keys[ longestMatch ];
		}

		String location = Preferences.getString( "lastAdventure" ).toLowerCase();

		// If no matches were found, then see if there is a match
		// against the adventure location.

		for ( int i = 0; i < CustomCombatManager.keys.length; ++i )
		{
			if ( location.indexOf( CustomCombatManager.keys[ i ] ) != -1 )
			{
				if ( CustomCombatManager.keys[ i ].length() > longestMatchLength )
				{
					longestMatch = i;
					longestMatchLength = CustomCombatManager.keys[ i ].length();
				}
			}
		}

		return longestMatch == -1 ? "default" : CustomCombatManager.keys[ longestMatch ];
	}

	public static final String getSetting( final String encounter, final int roundCount )
	{
		if ( roundCount < 0 || roundCount >= 100 )
		{	// prevent hang if the combat is somehow not progressing at all
			return "abort";
		}
		String action = Preferences.getString( "battleAction" );
		if ( !action.startsWith( "custom" ) )
		{
			switch ( roundCount )
			{
			case 0:
				return Preferences.getBoolean( "autoSteal" ) ?
					"try to steal an item" : "skip";
			case 1:
				return Preferences.getBoolean( "autoEntangle" ) ?
					"skill Entangling Noodles" : "skip";
			case 2:
				return "special action";
			default:
				return action;
			}
		}
		
		String settingKey = CustomCombatManager.getSettingKey( encounter );
		CombatSettingNode match = (CombatSettingNode) CustomCombatManager.reference.get( settingKey );
		HashSet seen = new HashSet();
		seen.add( settingKey );
		int index = roundCount;

		while ( true )
		{	
			if ( match == null || match.getChildCount() == 0 )
			{
				return "attack";
			}
	
			int origIndex = index;
			index = Math.min( index, match.getChildCount() - 1 );
			CombatActionNode setting = (CombatActionNode) match.getChildAt( index );
			action = setting == null ? "attack" : setting.getAction();
			
			// Check for section redirects
			if ( action.equals( "default" ) )
			{
				settingKey = action;
			}
			else if ( action.startsWith( "section " ) )
			{
				settingKey = CustomCombatManager.getSettingKey( 
					action.substring( 8 ).trim().toLowerCase() );
			}
			else
			{
				settingKey = null;
			}
			
			if ( settingKey != null )
			{
				if ( seen.contains( settingKey ) )
				{
					KoLmafia.abortAfter( "CCS aborted due to recursive section reference." );
					return "attack";
				}
				seen.add( settingKey );
				match = (CombatSettingNode) CustomCombatManager.reference.get( settingKey );
				index = origIndex - index;
				continue;
			}
			
			return action;
		}
	}

	private static class CombatSettingNode
		extends DefaultMutableTreeNode
	{
		private final String name;
		private boolean willDelevel = false;

		public CombatSettingNode()
		{
			this( "" );
		}

		public CombatSettingNode( final String name )
		{
			super( name, true );
			this.name = name;
		}

		public void add( final CombatActionNode node )
		{
			if ( this.willDelevel )
			{
				return;
			}

			this.willDelevel |= node.getAction().equalsIgnoreCase( "delevel" );
			super.add( node );
		}

		public String toString()
		{
			return this.name;
		}
	}

	private static class CombatActionNode
		extends DefaultMutableTreeNode
	{
		private final int index;
		private final String action;

		public CombatActionNode( final int index, final String action )
		{
			super( action, false );

			this.index = index;
			this.action = CustomCombatManager.getLongCombatOptionName( action );
		}

		public boolean startsWith( final String prefix )
		{
			return this.action.startsWith( prefix );
		}

		public String getAction()
		{
			return this.action;
		}

		public String toString()
		{
			return this.index + ": " + this.action;
		}
	}

	public static final String getLongCombatOptionName( String action )
	{
		if ( action == null )
		{
			return "attack with weapon";
		}

		action = action.trim();

		if ( action.startsWith( "attack" ) || action.length() == 0 )
		{
			return "attack with weapon";
		}

		if ( action.indexOf( "steal" ) != -1 || action.indexOf( "pick" ) != -1 )
		{
			return "try to steal an item";
		}

		if ( action.equals( "default" ) )
		{
			return "default";
		}

		if ( action.startsWith( "section" ) )
		{
			return action;
		}

		if ( action.startsWith( "jiggle" ) )
		{
			return "jiggle chefstaff";
		}

		if ( action.startsWith( "special" ) )
		{
			return "special action";
		}

		if ( action.equals( "skip" ) )
		{
			return "skip";
		}

		if ( action.startsWith( "note" ) )
		{
			return action;
		}

		if ( action.startsWith( "summon" ) && action.endsWith( "ghost" ) )
		{
			return "summon pastamancer ghost";
		}

		if ( action.startsWith( "abort" ) )
		{
			if ( action.indexOf( "after" ) != -1 )
			{
				return "abort after this combat";
			}
			return "abort";
		}

		if ( action.startsWith( "consult" ) )
		{
			return action;
		}

		if ( action.startsWith( "custom" ) )
		{
			return "custom combat script";
		}

		if ( action.startsWith( "delevel" ) )
		{
			return "delevel and plink";
		}

		if ( action.startsWith( "twiddle" ) )
		{
			return "twiddle your thumbs";
		}

		if ( action.indexOf( "run" ) != -1 && action.indexOf( "away" ) != -1 )
		{
			int runaway = StringUtilities.parseInt( action );
			if ( runaway <= 0 ) return "try to run away";
			return "run away if " + runaway + "% chance of being free";
		}

		if ( action.startsWith( "item" ) )
		{
			String item = CustomCombatManager.getLongItemAction( action.substring( 4 ) );
			return item.startsWith( "attack" ) ? item : "item " + item;
		}

		if ( action.startsWith( "skill" ) )
		{
			String potentialSkill = KoLmafiaCLI.getCombatSkillName( action.substring( 5 ).trim() );
			if ( potentialSkill != null )
			{
				return "skill " + potentialSkill.toLowerCase();
			}
		}

		// Well, it's either a standard skill, or it's an item,
		// or it's something you need to lookup in the tables.

		String potentialSkill = KoLmafiaCLI.getCombatSkillName( action );
		if ( potentialSkill != null )
		{
			return "skill " + potentialSkill.toLowerCase();
		}

		String item = CustomCombatManager.getLongItemAction( action );
		return item.startsWith( "attack" ) ? item : "item " + item;
	}

	private static final String getLongItemAction( final String action )
	{
		int commaIndex = action.indexOf( "," );
		if ( commaIndex != -1 )
		{
			String first = CustomCombatManager.getLongItemAction( action.substring( 0, commaIndex ) );
			if ( first.startsWith( "attack" ) )
			{
				return CustomCombatManager.getLongItemAction( action.substring( commaIndex + 1 ).trim() );
			}

			String second = CustomCombatManager.getLongItemAction( action.substring( commaIndex + 1 ).trim() );
			if ( second.startsWith( "attack" ) )
			{
				return first;
			}

			return first + ", " + second;
		}

		if ( action.startsWith( "item" ) )
		{
			return CustomCombatManager.getLongItemAction( action.substring( 4 ).trim() );
		}

		int itemId = CustomCombatManager.getCombatItem( action );

		if ( itemId <= 0 )
		{
			return "attack with weapon";
		}

		return ItemDatabase.getItemName( itemId );
	}

	public static final String getShortCombatOptionName( String action )
	{
		if ( action == null )
		{
			return "attack";
		}

		if ( action.equals( "default" ) )
		{
			return "default";
		}

		action = action.trim();

		boolean isSkillNumber = true;
		for ( int i = 0; i < action.length(); ++i )
		{
			isSkillNumber &= Character.isDigit( action.charAt( i ) );
		}

		if ( isSkillNumber )
		{
			return action;
		}

		if ( action.startsWith( "attack" ) || action.length() == 0 )
		{
			return "attack";
		}

		if ( action.startsWith( "abort" ) )
		{
			if ( action.indexOf( "after" ) != -1 )
			{
				return "abort after";
			}
			return "abort";
		}

		if ( action.indexOf( "steal" ) != -1 || action.indexOf( "pick" ) != -1 )
		{
			return "steal";
		}

		if ( action.startsWith( "jiggle" ) )
		{
			return "jiggle";
		}

		if ( action.startsWith( "special" ) )
		{
			return "special";
		}

		if ( action.equals( "skip" ) || action.startsWith( "note" ) )
		{
			return "skip";
		}

		if ( action.startsWith( "summon" ) && action.endsWith( "ghost" ) )
		{
			return "summon ghost";
		}

		if ( action.startsWith( "consult" ) )
		{
			return action;
		}

		if ( action.startsWith( "custom" ) )
		{
			return "custom";
		}

		if ( action.startsWith( "delevel" ) )
		{
			return "delevel";
		}

		if ( action.startsWith( "twiddle" ) )
		{
			return "twiddle";
		}

		if ( action.indexOf( "run" ) != -1 && action.indexOf( "away" ) != -1 )
		{
			int runaway = StringUtilities.parseInt( action );
			return runaway <= 0 ? "runaway" : ("runaway" + runaway);
		}

		if ( action.startsWith( "item" ) )
		{
			return CustomCombatManager.getShortItemAction( action.substring( 4 ).trim() );
		}

		if ( action.startsWith( "skill" ) )
		{
			String name = KoLmafiaCLI.getCombatSkillName( action.substring( 5 ).trim() );
			return name == null ? "attack" : "skill" + SkillDatabase.getSkillId( name );
		}

		String potentialSkill = KoLmafiaCLI.getCombatSkillName( action );
		if ( potentialSkill != null )
		{
			return "skill" + SkillDatabase.getSkillId( potentialSkill );
		}

		return CustomCombatManager.getShortItemAction( action );
	}

	private static final String getShortItemAction( final String action )
	{
		int commaIndex = action.indexOf( "," );
		if ( commaIndex != -1 )
		{
			String first = CustomCombatManager.getShortItemAction( action.substring( 0, commaIndex ) );
			if ( first.startsWith( "attack" ) )
			{
				return CustomCombatManager.getShortItemAction( action.substring( commaIndex + 1 ).trim() );
			}

			String second = CustomCombatManager.getShortItemAction( action.substring( commaIndex + 1 ).trim() );
			if ( second.startsWith( "attack" ) )
			{
				return first;
			}

			return first + "," + second;
		}

		if ( action.startsWith( "item" ) )
		{
			return CustomCombatManager.getShortItemAction( action.substring( 4 ) );
		}

		int itemId = CustomCombatManager.getCombatItem( action );

		if ( itemId <= 0 )
		{
			return "attack";
		}

		if ( itemId == ItemPool.DICTIONARY && InventoryManager.getCount( ItemPool.DICTIONARY ) < 1 )
		{
			itemId = ItemPool.FACSIMILE_DICTIONARY;
		}

		if ( itemId == ItemPool.FACSIMILE_DICTIONARY && InventoryManager.getCount(  ItemPool.FACSIMILE_DICTIONARY ) < 1 )
		{
			itemId = ItemPool.DICTIONARY;
		}

		return String.valueOf( itemId );
	}

	public static final int getCombatItem( String action )
	{
		List matchingNames = ItemDatabase.getMatchingNames( action );
		int count = matchingNames.size();

		for ( int i = 0; i < count; ++i )
		{
			String name = (String) matchingNames.get( i );
			int id = ItemDatabase.getItemId( name );
			if ( ItemDatabase.getAttribute( id,
				ItemDatabase.ATTR_COMBAT | ItemDatabase.ATTR_COMBAT_REUSABLE ) )
			{
				return id;
			}
		}

		return -1;
	}
}
