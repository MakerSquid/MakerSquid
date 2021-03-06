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

package net.sourceforge.kolmafia.request;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sourceforge.kolmafia.KoLCharacter;
import net.sourceforge.kolmafia.KoLConstants;
import net.sourceforge.kolmafia.KoLmafia;

import net.sourceforge.kolmafia.persistence.HolidayDatabase;
import net.sourceforge.kolmafia.persistence.Preferences;
import net.sourceforge.kolmafia.utilities.StringUtilities;

public class MoonPhaseRequest
	extends GenericRequest
{
	private static final Pattern MOONS_PATTERN = Pattern.compile( "moon(.)[ab]?\\.gif.*moon(.)[ab]?\\.gif" );
	private static final Pattern MENU1_PATTERN = Pattern.compile( "<select name=\"loc\".*?</select>", Pattern.DOTALL );
	private static final Pattern MENU2_PATTERN = Pattern.compile( "<select name=location.*?</select>", Pattern.DOTALL );

	/**
	 * The phases of the moons can be retrieved from the top menu, which varies based on whether or not the player is
	 * using compact mode.
	 */

	public MoonPhaseRequest()
	{
		super( GenericRequest.isCompactMode ? "compactmenu.php" : "topmenu.php" );
	}

	protected boolean retryOnTimeout()
	{
		return true;
	}

	/**
	 * Runs the moon phase request, updating theas appropriate.
	 */

	public void run()
	{
		KoLmafia.updateDisplay( "Synchronizing moon data..." );
		super.run();
	}

	public void processResults()
	{
		String parseText = this.responseText;

		// Get current phase of Ronald and Grimace
		if ( parseText.indexOf( "minimoon" ) != -1 )
		{
			parseText = parseText.replaceAll( "minimoon", "" );
		}

		Matcher moonMatcher = MoonPhaseRequest.MOONS_PATTERN.matcher( parseText );
		if ( moonMatcher.find() )
		{
			HolidayDatabase.setMoonPhases(
				StringUtilities.parseInt( moonMatcher.group( 1 ) ) - 1,
				StringUtilities.parseInt( moonMatcher.group( 2 ) ) - 1 );
		}

		KoLCharacter.setClan( this.responseText.indexOf( "clan_hall.php" ) != -1 );
	}

	public static final void decorate( final StringBuffer buffer )
	{
		if ( GenericRequest.isCompactMode )
		{
			MoonPhaseRequest.adjustCompactMenu( buffer );
		}
	}

	public static final void adjustCompactMenu( final StringBuffer buffer )
	{
		// Mafiatize the function menu

		StringBuffer functionMenu = new StringBuffer();
		functionMenu.append( "<select name=\"loc\" onchange=\"goloc();\">" );
		functionMenu.append( "<option value=\"nothing\">- Select -</option>" );

		for ( int i = 0; i < KoLConstants.FUNCTION_MENU.length; ++i )
		{
			functionMenu.append( "<option value=\"" );
			functionMenu.append( KoLConstants.FUNCTION_MENU[ i ][ 1 ] );
			functionMenu.append( "\">" );
			functionMenu.append( KoLConstants.FUNCTION_MENU[ i ][ 0 ] );
			functionMenu.append( "</option>" );
		}

		functionMenu.append( "<option value=\"donatepopup.php?pid=" );
		functionMenu.append( KoLCharacter.getUserId() );
		functionMenu.append( "\">Donate</option>" );
		functionMenu.append( "</select>" );

		Matcher menuMatcher = MoonPhaseRequest.MENU1_PATTERN.matcher( buffer.toString() );
		if ( menuMatcher.find() )
		{
			StringUtilities.singleStringReplace( buffer, menuMatcher.group(), functionMenu.toString() );
		}

		// Mafiatize the goto menu

		StringBuffer gotoMenu = new StringBuffer();
		gotoMenu.append( "<select name=location onchange='move();'>" );

		gotoMenu.append( "<option value=\"nothing\">- Select -</option>" );
		for ( int i = 0; i < KoLConstants.GOTO_MENU.length; ++i )
		{
			gotoMenu.append( "<option value=\"" );
			gotoMenu.append( KoLConstants.GOTO_MENU[ i ][ 1 ] );
			gotoMenu.append( "\">" );
			gotoMenu.append( KoLConstants.GOTO_MENU[ i ][ 0 ] );
			gotoMenu.append( "</option>" );
		}

		String[] bookmarkData = Preferences.getString( "browserBookmarks" ).split( "\\|" );

		if ( bookmarkData.length > 1 )
		{
			gotoMenu.append( "<option value=\"nothing\"> </option>" );
			gotoMenu.append( "<option value=\"nothing\">- Select -</option>" );

			for ( int i = 0; i < bookmarkData.length; i += 3 )
			{
				gotoMenu.append( "<option value=\"" );
				gotoMenu.append( bookmarkData[ i + 1 ] );
				gotoMenu.append( "\">" );
				gotoMenu.append( bookmarkData[ i ] );
				gotoMenu.append( "</option>" );
			}
		}

		gotoMenu.append( "</select>" );

		menuMatcher = MoonPhaseRequest.MENU2_PATTERN.matcher( buffer.toString() );
		if ( menuMatcher.find() )
		{
			StringUtilities.singleStringReplace( buffer, menuMatcher.group(), gotoMenu.toString() );
		}

		// Now kill off the weird focusing problems inherent in
		// the Javascript.

		StringUtilities.globalStringReplace(
			buffer, "selectedIndex=0;", "selectedIndex=0; if ( parent && parent.mainpane ) parent.mainpane.focus();" );

		if ( Preferences.getBoolean( "relayAddsQuickScripts" ) )
		{
			StringBuffer selectBuffer = new StringBuffer();
			selectBuffer.append( "<td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td><form name=\"gcli\">" );
			selectBuffer.append( "<select id=\"scriptbar\">" );

			String[] scriptList = Preferences.getString( "scriptList" ).split( " \\| " );
			for ( int i = 0; i < scriptList.length; ++i )
			{
				selectBuffer.append( "<option value=\"" );
				selectBuffer.append( scriptList[ i ] );
				selectBuffer.append( "\">" );
				selectBuffer.append( i + 1 );
				selectBuffer.append( ": " );
				selectBuffer.append( scriptList[ i ] );
				selectBuffer.append( "</option>" );
			}

			selectBuffer.append( "</select></td><td>&nbsp;</td><td>" );
			selectBuffer.append( "<input type=\"button\" class=\"button\" value=\"exec\" onClick=\"" );

			selectBuffer.append( "var script = document.getElementById( 'scriptbar' ).value; " );
			selectBuffer.append( "parent.charpane.location = '/KoLmafia/sideCommand?cmd=' + escape(script) + '&pwd=" );
			selectBuffer.append( GenericRequest.passwordHash );
			selectBuffer.append( "'; void(0);" );
			selectBuffer.append( "\">" );
			selectBuffer.append( "</form></td>" );

			int lastRowIndex = buffer.lastIndexOf( "</tr>" );
			if ( lastRowIndex != -1 )
			{
				buffer.insert( lastRowIndex, selectBuffer.toString() );
			}
		}
	}
}
