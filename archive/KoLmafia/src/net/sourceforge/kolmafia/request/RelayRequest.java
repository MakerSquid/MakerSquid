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

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.java.dev.spellcast.utilities.DataUtilities;
import net.sourceforge.kolmafia.AdventureResult;
import net.sourceforge.kolmafia.AreaCombatData;
import net.sourceforge.kolmafia.FamiliarData;
import net.sourceforge.kolmafia.KoLAdventure;
import net.sourceforge.kolmafia.KoLCharacter;
import net.sourceforge.kolmafia.KoLConstants;
import net.sourceforge.kolmafia.KoLmafia;
import net.sourceforge.kolmafia.KoLmafiaASH;
import net.sourceforge.kolmafia.KoLmafiaCLI;
import net.sourceforge.kolmafia.LocalRelayServer;
import net.sourceforge.kolmafia.NullStream;
import net.sourceforge.kolmafia.RequestEditorKit;
import net.sourceforge.kolmafia.RequestLogger;
import net.sourceforge.kolmafia.RequestThread;
import net.sourceforge.kolmafia.SpecialOutfit;
import net.sourceforge.kolmafia.StaticEntity;
import net.sourceforge.kolmafia.objectpool.ItemPool;
import net.sourceforge.kolmafia.persistence.AdventureDatabase;
import net.sourceforge.kolmafia.persistence.CustomItemDatabase;
import net.sourceforge.kolmafia.persistence.EffectDatabase;
import net.sourceforge.kolmafia.persistence.FamiliarDatabase;
import net.sourceforge.kolmafia.persistence.HolidayDatabase;
import net.sourceforge.kolmafia.persistence.ItemDatabase;
import net.sourceforge.kolmafia.persistence.NPCStoreDatabase;
import net.sourceforge.kolmafia.persistence.Preferences;
import net.sourceforge.kolmafia.persistence.SkillDatabase;
import net.sourceforge.kolmafia.session.ChatManager;
import net.sourceforge.kolmafia.session.EquipmentManager;
import net.sourceforge.kolmafia.session.InventoryManager;
import net.sourceforge.kolmafia.session.SorceressLairManager;
import net.sourceforge.kolmafia.session.TurnCounter;
import net.sourceforge.kolmafia.swingui.AdventureFrame;
import net.sourceforge.kolmafia.swingui.CommandDisplayFrame;
import net.sourceforge.kolmafia.swingui.widget.ShowDescriptionList;
import net.sourceforge.kolmafia.textui.DataTypes;
import net.sourceforge.kolmafia.utilities.FileUtilities;
import net.sourceforge.kolmafia.utilities.PauseObject;
import net.sourceforge.kolmafia.utilities.StringUtilities;
import net.sourceforge.kolmafia.webui.IslandDecorator;

public class RelayRequest
	extends PasswordHashRequest
{
	private final PauseObject pauser = new PauseObject();

	private static final HashMap overrideMap = new HashMap();

	private static final Pattern WHITESPACE_PATTERN = Pattern.compile( "['\\s-]" );
	private static final Pattern EMAIL_PATTERN =
		Pattern.compile( "<table style='border: 1px solid black;' cellpadding=10>.*?</table>", Pattern.DOTALL );
	private static final Pattern STORE_PATTERN =
		Pattern.compile( "<tr><td><input name=whichitem type=radio value=(\\d+).*?</tr>", Pattern.DOTALL );

	private static final String RELAY_PATH = KoLConstants.RELAY_LOCATION.getAbsolutePath();

	private static String mainpane = "";
	private static KoLAdventure lastSafety = null;

	private final boolean allowOverride;
	public List headers = new ArrayList();
	public byte[] rawByteBuffer = null;
	public String contentType = null;
	public String statusLine = "HTTP/1.1 302 Found";

	public RelayRequest( final boolean allowOverride )
	{
		super( "" );
		this.allowOverride = allowOverride && Preferences.getBoolean( "relayAllowsOverrides" );
	}

	public GenericRequest constructURLString( final String newURLString )
	{
		return this.constructURLString( newURLString, true );
	}

	public GenericRequest constructURLString( final String newURLString, final boolean usePostMethod )
	{
		super.constructURLString( newURLString, usePostMethod );

		this.rawByteBuffer = null;
		this.headers.clear();

		String path = this.getBasePath();

		if ( path.endsWith( ".css" ) )
		{
			this.contentType = "text/css";
		}
		else if ( path.endsWith( ".js" ) )
		{
			this.contentType = "text/javascript";
		}
		else if ( path.endsWith( ".gif" ) )
		{
			this.contentType = "image/gif";
		}
		else if ( path.endsWith( ".png" ) )
		{
			this.contentType = "image/png";
		}
		else if ( path.endsWith( ".jpg" ) || path.endsWith( ".jpeg" ) )
		{
			this.contentType = "image/jpeg";
		}
		else if ( path.endsWith( ".ico" ) )
		{
			this.contentType = "image/x-icon";
		}
		else if ( path.endsWith( ".php" ) || path.endsWith( ".html" ) || path.endsWith( ".ash" ) )
		{
			this.contentType = "text/html";
		}
		else
		{
			this.contentType = "text/plain";
		}

		return this;
	}

	private static final boolean isJunkItem( final int itemId, final int price )
	{
		if ( !Preferences.getBoolean( "relayHidesJunkMallItems" ) )
		{
			return false;
		}

		if ( price > KoLCharacter.getAvailableMeat() )
		{
			return true;
		}

		if ( NPCStoreDatabase.contains( ItemDatabase.getItemName( itemId ) ) )
		{
			if ( price == 100 || price > Math.abs( ItemDatabase.getPriceById( itemId ) ) * 2 )
			{
				return true;
			}
		}

		for ( int i = 0; i < KoLConstants.junkList.size(); ++i )
		{
			if ( ( (AdventureResult) KoLConstants.junkList.get( i ) ).getItemId() == itemId )
			{
				return true;
			}
		}

		return false;
	}

	protected boolean retryOnTimeout()
	{
		return false;
	}

	public void processResults()
	{
		if ( !this.hasNoResult() && !this.getPath().startsWith( "fight.php" ) )
		{
			StaticEntity.externalUpdate( this.getURLString(), this.responseText );
		}
	}

	public void formatResponse()
	{
		this.statusLine = "HTTP/1.1 200 OK";
		String path = this.getBasePath();
		StringBuffer responseBuffer = new StringBuffer( this.responseText );

		// Fix KoLmafia getting outdated by events happening
		// in the browser by using the sidepane.

		if ( path.equals( "charpane.php" ) )
		{
			CharPaneRequest.processCharacterPane( this.responseText, this.date );
		}
		else if ( path.equals( "chatlaunch.php" ) )
		{
			if ( Preferences.getBoolean( "relayAddsGraphicalCLI" ) )
			{
				int linkIndex = responseBuffer.indexOf( "<a href" );
				if ( linkIndex != -1 )
				{
					responseBuffer.insert(
						linkIndex,
						"<a href=\"cli.html\"><b>KoLmafia gCLI</b></a></center><p>Type KoLmafia scripting commands in your browser!</p><center>" );
				}
			}

			if ( Preferences.getBoolean( "relayAddsKoLSimulator" ) )
			{
				int linkIndex = responseBuffer.indexOf( "<a href" );
				if ( linkIndex != -1 )
				{
					responseBuffer.insert(
						linkIndex,
						"<a href=\"simulator/index.html\" target=\"_blank\"><b>KoL Simulator</b></a></center><p>See what might happen before it happens!</p><center>" );
				}
			}
		}

		// Fix it a little more by making sure that familiar
		// changes and equipment changes are remembered.

		else if ( path.equals( "main.php" ) )
		{
			Matcher emailMatcher = RelayRequest.EMAIL_PATTERN.matcher( this.responseText );
			if ( emailMatcher.find() )
			{
				responseBuffer = new StringBuffer( emailMatcher.replaceAll( "" ) );
			}
		}

		// If this is a store, you can opt to remove all the min-priced
		// items from view along with all the items which are priced
		// above affordable levels.

		else if ( path.startsWith( "mallstore.php" ) )
		{
			int searchItemId = -1;
			int searchPrice = -1;

			searchItemId = StringUtilities.parseInt( this.getFormField( "searchitem" ) );
			searchPrice = StringUtilities.parseInt( this.getFormField( "searchprice" ) );

			Matcher itemMatcher = RelayRequest.STORE_PATTERN.matcher( this.responseText );

			while ( itemMatcher.find() )
			{
				String itemData = itemMatcher.group( 1 );

				int itemId = StringUtilities.parseInt( itemData.substring( 0, itemData.length() - 9 ) );
				int price = StringUtilities.parseInt( itemData.substring( itemData.length() - 9 ) );

				if ( itemId != searchItemId && RelayRequest.isJunkItem( itemId, price ) )
				{
					StringUtilities.singleStringDelete( responseBuffer, itemMatcher.group() );
				}
			}

			// Also make sure the item that the person selected
			// when coming into the store is pre-selected.

			if ( searchItemId != -1 )
			{
				String searchString = MallPurchaseRequest.getStoreString( searchItemId, searchPrice );
				StringUtilities.singleStringReplace(
					responseBuffer, "value=" + searchString, "checked value=" + searchString );
			}
		}
		else if ( path.startsWith( "fight.php" ) )
		{
			String action = this.getFormField( "action" );
			if ( action != null && action.equals( "skill" ) )
			{
				String skillId = this.getFormField( "whichskill" );
				if ( skillId != null && !skillId.equals( "none" ) && !skillId.equals( "3004" ) )
				{
					String testAction;
					int maximumIndex = KoLConstants.STATIONARY_BUTTON_COUNT + 1;
					int insertIndex = maximumIndex;

					for ( int i = 1; i <= KoLConstants.STATIONARY_BUTTON_COUNT && insertIndex == maximumIndex; ++i )
					{
						testAction = Preferences.getString( "stationaryButton" + i );
						if ( testAction.equals( "" ) || testAction.equals( "none" ) || testAction.equals( skillId ) )
						{
							insertIndex = i;
						}
					}

					if ( insertIndex == maximumIndex )
					{
						insertIndex = KoLConstants.STATIONARY_BUTTON_COUNT;
						for ( int i = 2; i <= KoLConstants.STATIONARY_BUTTON_COUNT; ++i )
						{
							Preferences.setString(
								"stationaryButton" + ( i - 1 ), Preferences.getString( "stationaryButton" + i ) );
						}
					}

					Preferences.setString( "stationaryButton" + insertIndex, skillId );
				}
			}
		}

		try
		{
			RequestEditorKit.getFeatureRichHTML( this.getURLString(), responseBuffer, true );
		}
		catch ( Exception e )
		{
			StaticEntity.printStackTrace( e );
		}

		// Load image files locally to reduce bandwidth
		// and improve mini-browser performance.

		if ( Preferences.getBoolean( "relayUsesCachedImages" ) )
		{
			StringUtilities.globalStringReplace( responseBuffer, "http://images.kingdomofloathing.com", "/images" );
		}
		else
		{
			StringUtilities.globalStringReplace(
				responseBuffer, "http://images.kingdomofloathing.com/scripts", "/images/scripts" );
		}

		// Download and link to any Players of Loathing
		// picture pages locally.

		StringUtilities.globalStringReplace( responseBuffer, "http://pics.communityofloathing.com/albums", "/images" );

		// Remove the default frame busting script so that
		// we can detach user interface elements.

		StringUtilities.singleStringReplace( responseBuffer, "frames.length == 0", "frames.length == -1" );
		StringUtilities.globalStringReplace( responseBuffer, " name=adv ", " name=snarfblat " );

		this.responseText = responseBuffer.toString();

		CustomItemDatabase.linkCustomItem( this );
	}

	public void printHeaders( final PrintStream ostream )
	{
		if ( !this.headers.isEmpty() )
		{
			for ( int i = 0; i < this.headers.size(); ++i )
			{
				ostream.println( this.headers.get( i ) );
			}
		}
		else
		{
			String header;

			for ( int i = 0; ( header = this.formConnection.getHeaderFieldKey( i ) ) != null; ++i )
			{
				if ( header.startsWith( "Content" ) || header.startsWith( "Cache" ) || header.equals( "Pragma" ) || header.equals( "Set-Cookie" ) )
				{
					continue;
				}

				ostream.print( header );
				ostream.print( ": " );
				ostream.println( this.formConnection.getHeaderField( i ) );
			}

			if ( this.responseCode == 200 && this.rawByteBuffer != null )
			{
				ostream.print( "Content-Type: " );
				ostream.print( this.contentType );

				if ( this.contentType.startsWith( "text" ) )
				{
					ostream.print( "; charset=UTF-8" );
				}

				ostream.println();

				ostream.print( "Content-Length: " );
				ostream.print( this.rawByteBuffer.length );
				ostream.println();

				ostream.println( "Cache-Control: no-cache, must-revalidate" );
				ostream.println( "Pragma: no-cache" );
			}
		}
	}

	public void pseudoResponse( final String status, final String responseText )
	{
		this.statusLine = status;

		this.headers.add( "Date: " + new Date() );
		this.headers.add( "Server: " + KoLConstants.VERSION_NAME );

		if ( status.indexOf( "302" ) != -1 )
		{
			this.headers.add( "Location: " + responseText );

			this.responseCode = 302;
			this.responseText = "";
		}
		else if ( status.indexOf( "200" ) != -1 )
		{
			this.responseCode = 200;

			if ( responseText.length() == 0 )
			{
				this.responseText = " ";
			}
			else
			{
				this.rawByteBuffer = null;
				this.responseText = responseText;
			}

			if ( this.contentType.equals( "text/html" ) )
			{
				this.headers.add( "Content-Type: text/html; charset=UTF-8" );
				this.headers.add( "Cache-Control: no-cache, must-revalidate" );
				this.headers.add( "Pragma: no-cache" );
			}
			else
			{
				this.headers.add( "Content-Type: " + this.contentType );
			}
		}
		else
		{
			this.responseText = " ";
		}

		this.headers.add( "Connection: close" );
	}

	private StringBuffer readContents( final BufferedReader reader )
	{
		String line = null;
		StringBuffer contentBuffer = new StringBuffer();

		try
		{
			if ( reader == null )
			{
				return contentBuffer;
			}

			while ( ( line = reader.readLine() ) != null )
			{
				contentBuffer.append( line );
				contentBuffer.append( KoLConstants.LINE_BREAK );
			}

			reader.close();
		}
		catch ( IOException e )
		{
		}

		return contentBuffer;
	}

	private void sendLocalImage( final String filename )
	{
		URL imageURL = FileUtilities.downloadImage(
			"http://images.kingdomofloathing.com" + filename.substring( 6 ) );

		if ( imageURL == null )
		{
			this.sendNotFound();
			return;
		}

		InputStream istream;

		try
		{
			istream = imageURL.openConnection().getInputStream();
		}
		catch ( IOException e )
		{
			this.sendNotFound();
			return;
		}

		ByteArrayOutputStream outbytes = new ByteArrayOutputStream( 4096 );

		BufferedInputStream bufferedIstream = new BufferedInputStream( istream );

		try
		{
			byte[] buffer = new byte[ 4096 ];

			int offset;
			while ( ( offset = bufferedIstream.read( buffer ) ) > 0 )
			{
				outbytes.write( buffer, 0, offset );
			}
		}
		catch ( IOException e )
		{
		}

		try
		{
			bufferedIstream.close();
		}
		catch ( IOException e )
		{
		}

		try
		{
			outbytes.flush();
		}
		catch ( IOException e )
		{
		}

		this.rawByteBuffer = outbytes.toByteArray();
		this.pseudoResponse( "HTTP/1.1 200 OK", "" );
	}

	public static final void setNextMain( final String mainpane )
	{
		RelayRequest.mainpane = mainpane;
	}

	private void handleMain()
	{
		if ( this.responseText == null )
		{
			super.run();
		}

		if ( RelayRequest.mainpane.equals( "" ) )
		{
			return;
		}

		// If it's a relay browser request based on a
		// menu item, then change the middle panel.

		this.responseText =
			RelayRequest.MAINPANE_PATTERN.matcher( this.responseText ).replaceFirst(
				"name=mainpane src=\"" + RelayRequest.mainpane + "\"" );

		RelayRequest.mainpane = "";
	}

	private static final Pattern MAINPANE_PATTERN = Pattern.compile( "name=mainpane src=\"(.*?)\"", Pattern.DOTALL );

	private void sendLocalFile( final String filename )
	{
		StringBuffer replyBuffer = new StringBuffer();

		if ( !RelayRequest.overrideMap.containsKey( filename ) )
		{
			RelayRequest.overrideMap.put( filename, new File( KoLConstants.RELAY_LOCATION, filename ) );
		}

		File override = (File) RelayRequest.overrideMap.get( filename );

		if ( !override.getAbsolutePath().startsWith( RELAY_PATH ) )
		{
			this.sendNotFound();
			return;
		}

		if ( !override.exists() )
		{
			if ( filename.equals( "main.html" ) || filename.equals( "main_c.html" ) )
			{
				this.handleMain();
				return;
			}

			if ( !filename.startsWith( "simulator/" ) )
			{
				this.sendNotFound();
				return;
			}

			this.downloadSimulatorFile( filename.substring( filename.lastIndexOf( "/" ) + 1 ) );
		}

		replyBuffer = this.readContents( DataUtilities.getReader( override ) );

		// Add Javascript to the KoL simulator pages so that
		// everything loads correctly the first time.

		if ( filename.endsWith( "simulator/index.html" ) )
		{
			this.handleSimulatorIndex( replyBuffer );
		}

		if ( filename.equals( "chat.html" ) )
		{
			StringUtilities.singleStringReplace(
				replyBuffer, "CHATAUTH", "playerid=" + KoLCharacter.getPlayerId() + "&pwd=" + GenericRequest.passwordHash );
		}

		StringUtilities.globalStringReplace( replyBuffer, "MAFIAHIT", "pwd=" + GenericRequest.passwordHash );

		// Make sure to print the reply buffer to the
		// response buffer for the local relay server.

		if ( this.isChatRequest )
		{
			StringUtilities.globalStringReplace( replyBuffer, "<br>", "</font><br>" );
		}

		if ( filename.endsWith( "chat.html" ) )
		{
			RequestEditorKit.addChatFeatures( replyBuffer );
		}

		this.pseudoResponse( "HTTP/1.1 200 OK", replyBuffer.toString() );

		if ( filename.equals( "main.html" ) || filename.equals( "main_c.html" ) )
		{
			this.handleMain();
			return;
		}
	}

	private static final String getSimulatorEffectName( final String effectName )
	{
		return RelayRequest.WHITESPACE_PATTERN.matcher( effectName ).replaceAll( "" ).toLowerCase();
	}

	private static final String getSimulatorEquipName( final int equipmentSlot )
	{
		AdventureResult item = EquipmentManager.getEquipment( equipmentSlot );

		if ( equipmentSlot == EquipmentManager.FAMILIAR && item.getName().equals(
			FamiliarDatabase.getFamiliarItem( KoLCharacter.getFamiliar().getId() ) ) )
		{
			return "familiar-specific +5 lbs.";
		}

		if ( item == EquipmentRequest.UNEQUIP )
		{
			return "(None)";
		}

		return item.getName();
	}

	private void handleSimulatorIndex( final StringBuffer replyBuffer )
	{
		StringBuffer scriptBuffer = new StringBuffer();
		scriptBuffer.append( KoLConstants.LINE_BREAK );

		scriptBuffer.append( "<script language=\"Javascript\">" );
		scriptBuffer.append( KoLConstants.LINE_BREAK );
		scriptBuffer.append( KoLConstants.LINE_BREAK );
		scriptBuffer.append( "LoadKingdomStateLong( { " );

		// This is the simple Javascript which can be added
		// arbitrarily to the end without having to modify
		// the underlying HTML.

		int classIndex = -1;
		for ( int i = 0; i < DataTypes.CLASSES.length; ++i )
		{
			if ( DataTypes.CLASSES[ i ].equalsIgnoreCase( KoLCharacter.getClassType() ) )
			{
				classIndex = i;
			}
		}

		// Player state

		scriptBuffer.append( "charclass: " );
		scriptBuffer.append( classIndex );
		scriptBuffer.append( ", mus: " );
		scriptBuffer.append( KoLCharacter.getBaseMuscle() );
		scriptBuffer.append( ", mys: " );
		scriptBuffer.append( KoLCharacter.getBaseMysticality() );
		scriptBuffer.append( ", mox: " );
		scriptBuffer.append( KoLCharacter.getBaseMoxie() );
		scriptBuffer.append( ", " );

		// Current equipment

		scriptBuffer.append( "hat: \"" );
		scriptBuffer.append( RelayRequest.getSimulatorEquipName( EquipmentManager.HAT ) );
		scriptBuffer.append( "\", weapon: \"" );
		scriptBuffer.append( RelayRequest.getSimulatorEquipName( EquipmentManager.WEAPON ) );
		scriptBuffer.append( "\", offhand: \"" );
		scriptBuffer.append( RelayRequest.getSimulatorEquipName( EquipmentManager.OFFHAND ) );
		scriptBuffer.append( "\", shirt: \"" );
		scriptBuffer.append( RelayRequest.getSimulatorEquipName( EquipmentManager.SHIRT ) );
		scriptBuffer.append( "\", pants: \"" );
		scriptBuffer.append( RelayRequest.getSimulatorEquipName( EquipmentManager.PANTS ) );
		scriptBuffer.append( "\", acc1: \"" );
		scriptBuffer.append( RelayRequest.getSimulatorEquipName( EquipmentManager.ACCESSORY1 ) );
		scriptBuffer.append( "\", acc2: \"" );
		scriptBuffer.append( RelayRequest.getSimulatorEquipName( EquipmentManager.ACCESSORY2 ) );
		scriptBuffer.append( "\", acc3: \"" );
		scriptBuffer.append( RelayRequest.getSimulatorEquipName( EquipmentManager.ACCESSORY3 ) );
		scriptBuffer.append( "\", " );

		// Current familiar

		scriptBuffer.append( "familiar: \"" );
		scriptBuffer.append( KoLCharacter.getFamiliar().getRace() );
		scriptBuffer.append( "\", weight: " );
		scriptBuffer.append( KoLCharacter.getFamiliar().getWeight() );
		scriptBuffer.append( ", fameq: \"" );

		String familiarEquipment = RelayRequest.getSimulatorEquipName( EquipmentManager.FAMILIAR );
		if ( FamiliarData.itemWeightModifier( ItemDatabase.getItemId( familiarEquipment ) ) == 5 )
		{
			scriptBuffer.append( "familiar-specific +5 lbs." );
		}
		else
		{
			scriptBuffer.append( familiarEquipment );
		}

		// Status effects

		scriptBuffer.append( "\", rockandroll: false, effects: [ " );
		int effectCount = 0;

		for ( int i = 0; i < KoLConstants.availableSkills.size(); ++i )
		{
			UseSkillRequest current = (UseSkillRequest) KoLConstants.availableSkills.get( i );
			int skillId = current.getSkillId();

			if ( SkillDatabase.getSkillType( skillId ) != SkillDatabase.PASSIVE )
			{
				continue;
			}

			if ( effectCount > 0 )
			{
				scriptBuffer.append( ',' );
			}

			++effectCount;
			scriptBuffer.append( '\"' );
			scriptBuffer.append( RelayRequest.getSimulatorEffectName( current.getSkillName() ) );
			scriptBuffer.append( '\"' );
		}

		for ( int i = 0; i < KoLConstants.activeEffects.size(); ++i )
		{
			AdventureResult current = (AdventureResult) KoLConstants.activeEffects.get( i );
			if ( effectCount > 0 )
			{
				scriptBuffer.append( ',' );
			}

			++effectCount;
			scriptBuffer.append( '\"' );
			scriptBuffer.append( RelayRequest.getSimulatorEffectName( current.getName() ) );
			scriptBuffer.append( '\"' );
		}

		scriptBuffer.append( " ], " );

		// Adventure modifiers

		scriptBuffer.append( "zone: \"" );
		scriptBuffer.append( Preferences.getString( "lastAdventure" ) );
		scriptBuffer.append( "\", monster: \"" );
		scriptBuffer.append( FightRequest.getCurrentKey() );
		scriptBuffer.append( "\", mcd: " );
		scriptBuffer.append( KoLCharacter.getMindControlLevel() );
		scriptBuffer.append( ", " );

		scriptBuffer.append( "moonphase: " );
		scriptBuffer.append( (int) ( ( HolidayDatabase.getGrimacePhase() - 1 ) * 2 + Math.round( ( HolidayDatabase.getRonaldPhase() - 1 ) / 2.0f - Math.floor( ( HolidayDatabase.getRonaldPhase() - 1 ) / 2.0f ) ) ) );

		scriptBuffer.append( ", moonminiphase: " );
		scriptBuffer.append( HolidayDatabase.getHamburglarPosition( new Date() ) );
		scriptBuffer.append( " } );" );

		scriptBuffer.append( KoLConstants.LINE_BREAK );
		scriptBuffer.append( KoLConstants.LINE_BREAK );
		scriptBuffer.append( "</script>" );

		this.insertAfterEnd( replyBuffer, scriptBuffer.toString() );
	}

	public void insertAfterEnd( final StringBuffer replyBuffer, final String contents )
	{
		int terminalIndex = replyBuffer.lastIndexOf( "</html>" );
		if ( terminalIndex == -1 )
		{
			replyBuffer.append( contents );
			replyBuffer.append( "</html>" );
		}
		else
		{
			replyBuffer.insert( terminalIndex, contents );
		}
	}

	public void sendNotFound()
	{
		this.pseudoResponse( "HTTP/1.1 404 Not Found", "" );
		this.responseCode = 404;
	}

	private boolean sendBattlefieldWarning( final String urlString, final KoLAdventure adventure )
	{
		// If user has already confirmed he wants to go there, accept it
		if ( this.getFormField( "confirm" ) != null )
		{
			return false;
		}

		// If visiting big island, see if trying to enter a camp
		if ( urlString.startsWith( "bigisland.php" ) )
		{
			return checkCampVisit( urlString );
		}

		if ( adventure == null )
		{
			return false;
		}

		String location = adventure.getAdventureId();

		// If he's not going on to the battlefield, no problem
		if ( !location.equals( "132" ) && !location.equals( "140" ) )
		{
			return false;
		}

		// You can't tell which uniform is being worn from the URL;
		// the player can adventure in one uniform, change uniform,
		// and click on the Last Adventure link

		SpecialOutfit outfit = EquipmentManager.currentOutfit();

		// If he's not in a uniform, no battle
		if ( outfit == null )
		{
			return false;
		}

		int outfitId = outfit.getOutfitId();
		switch ( outfitId )
		{
		case 32:
			// War Hippy Fatigues
		case 33:
			// Frat Warrior Fatigues
			return checkBattle( outfitId);
		}

		return false;
	}

	private boolean checkCampVisit( final String urlString )
	{
		String master = CoinMasterRequest.findCampMaster( urlString );

		// If he's not attempting to enter a camp, no problem.
		if ( master == null )
		{
			return false;
		}

		SpecialOutfit outfit = EquipmentManager.currentOutfit();

		// If he's not in a uniform, no visit
		if ( outfit == null )
		{
			return false;
		}

		switch ( outfit.getOutfitId() )
		{
		case 32:
			// War Hippy Fatigues
			if ( master == CoinMasterRequest.HIPPY )
			{
				return false;
			}
			break;

		case 33:
			// Frat Warrior Fatigues
			if ( master == CoinMasterRequest.FRATBOY )
			{
				return false;
			}
			break;

		default:
			return false;
		}

		// He is attempting to visit the opposing camp in uniform.
		// This will prompt the final confrontation.
		// Offer a chance to cash in dimes and quarters.

		this.sendCoinMasterWarning( master );
		return true;
	}

	private boolean checkBattle( final int outfitId )
	{
		int fratboysDefeated = IslandDecorator.fratboysDefeated();
		int hippiesDefeated = IslandDecorator.hippiesDefeated();

		if ( fratboysDefeated == 999 && hippiesDefeated == 999 )
		{
			this.sendCoinMasterWarning( null );
			return true;
		}

		if ( fratboysDefeated == 999 && outfitId == 32 )
		{
			// In hippy uniform and about to defeat last fratboy.
			int factor = IslandDecorator.hippiesDefeatedPerBattle();
			if ( hippiesDefeated < 999 && ( 999 - hippiesDefeated ) % factor == 0 )
			{
				this.sendWossnameWarning( CoinMasterRequest.FRATBOY );
				return true;
			}
		}

		if ( hippiesDefeated == 999 && outfitId == 33 )
		{
			// In fratboy uniform and about to defeat last hippy.
			int factor = IslandDecorator.fratboysDefeatedPerBattle();
			if ( fratboysDefeated < 999 && ( 999 - fratboysDefeated ) % factor == 0 )
			{
				this.sendWossnameWarning( CoinMasterRequest.HIPPY );
				return true;
			}
		}

		return false;
	}

	private void sendCoinMasterWarning( final String camp )
	{
		String message;

		if ( camp == null )
		{
			message = "You are about to enter the final confrontation with the two bosses.";
		}
		else
		{
			message = "You are about to enter the " + ( camp == CoinMasterRequest.HIPPY ? "hippy" : "fratboy" ) + " camp and confront the boss.";
		}

		message = message + " Before you do so, you might want to redeem war loot for dimes and quarters and buy equipment. Click on the image to enter battle, once you are ready.";

		this.sendGeneralWarning( "lucre.gif", message );
	}

	private void sendWossnameWarning( final String camp )
	{
		String message;

		message = "You are about to defeat the last " + ( camp == CoinMasterRequest.HIPPY ? "hippy" : "fratboy" ) + " and open the way to their camp. However, you have not yet finished with the " + ( camp == CoinMasterRequest.HIPPY ? "fratboys" : "hippies" ) + ". If you are sure you don't want the Order of the Silver Wossname, click on the image and proceed.";

		this.sendGeneralWarning( "wossname.gif", message );
	}

	public void sendBossWarning( final String name, final String image, final int mcd1, final String item1,
		final int mcd2, final String item2 )
	{
		int mcd0 = KoLCharacter.getMindControlLevel();

		StringBuffer warning = new StringBuffer();

		warning.append( "<html><head><script language=Javascript src=\"/basics.js\"></script>" );

		warning.append( "<script language=Javascript> " );
		warning.append( "var default0 = " + mcd0 + "; " );
		warning.append( "var default1 = " + mcd1 + "; " );
		warning.append( "var default2 = " + mcd2 + "; " );
		warning.append( "var current = " + mcd0 + "; " );
		warning.append( "function switchLinks( id ) { " );
		warning.append( "if ( id == \"mcd1\" ) { " );
		warning.append( "current = (current == default0) ? default1 : default0; " );
		warning.append( "} else { " );
		warning.append( "current = (current == default0) ? default2 : default0; " );
		warning.append( "} " );
		warning.append( "getObject(\"mcd1\").style.border = (current == default1) ? \"1px dashed blue\" : \"1px dashed white\"; " );
		warning.append( "getObject(\"mcd2\").style.border = (current == default2) ? \"1px dashed blue\" : \"1px dashed white\"; " );
		warning.append( "top.charpane.location.href = \"/KoLmafia/sideCommand?cmd=mcd+\" + current + \"&pwd=" );
		warning.append( GenericRequest.passwordHash );
		warning.append( "\"; } </script>" );

		warning.append( "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://images.kingdomofloathing.com/styles.css\"></head>" );
		warning.append( "<body><center><table width=95%	 cellspacing=0 cellpadding=0><tr><td style=\"color: white;\" align=center bgcolor=blue><b>Results:</b></td></tr><tr><td style=\"padding: 5px; border: 1px solid blue;\"><center><table><tr><td><center>" );

		warning.append( "<table><tr>" );

		warning.append( "<td align=center valign=center><div id=\"mcd1\" style=\"padding: 4px 4px 4px 4px" );

		if ( mcd0 == mcd1 )
		{
			warning.append( "; border: 1px dashed blue" );
		}

		warning.append( "\"><a id=\"link1\" style=\"text-decoration: none\" onClick=\"switchLinks('mcd1'); void(0);\" href=\"#\"><img src=\"http://images.kingdomofloathing.com/itemimages/" );
		warning.append( item1 );
		warning.append( "\" width=30 height=30><br /><font size=1>MCD " );
		warning.append( mcd1 );
		warning.append( "</font></a></div></td>" );

		warning.append( "<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>" );

		warning.append( "<td valign=center><a href=\"" );
		warning.append( this.getURLString() );
		warning.append( "&confirm=on" );
		warning.append( "\"><img src=\"http://images.kingdomofloathing.com/adventureimages/" );
		warning.append( image );
		warning.append( "\"></a></td>" );

		warning.append( "<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>" );

		warning.append( "<td align=center valign=center><div id=\"mcd2\" style=\"padding: 4px 4px 4px 4px" );

		if ( KoLCharacter.getMindControlLevel() == mcd2 )
		{
			warning.append( "; border: 1px dashed blue" );
		}

		warning.append( "\"><a id=\"link2\" style=\"text-decoration: none\" onClick=\"switchLinks('mcd2'); void(0);\" href=\"#\"><img src=\"http://images.kingdomofloathing.com/itemimages/" );
		warning.append( item2 );
		warning.append( "\" width=30 height=30><br /><font size=1>MCD " );
		warning.append( mcd2 );
		warning.append( "</font></a></div></td>" );

		warning.append( "</tr></table></center><blockquote>The " );
		warning.append( name );

		warning.append( " drops special rewards based on your mind-control level.  If you'd like a special reward, click on one of the items above to set your mind-control device appropriately.  Click on it again to reset the MCD back to your old setting.	 Click on the " );
		warning.append( name );

		warning.append( " once you've decided to proceed.</blockquote></td></tr></table></center></td></tr></table></center></body></html>" );

		this.pseudoResponse( "HTTP/1.1 200 OK", warning.toString() );
	}

	public void sendGeneralWarning( final String image, final String message )
	{
		StringBuffer warning = new StringBuffer();

		warning.append( "<html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"http://images.kingdomofloathing.com/styles.css\"><script language=\"Javascript\" src=\"/basics.js\"></script></head><body><center><table width=95%  cellspacing=0 cellpadding=0><tr><td style=\"color: white;\" align=center bgcolor=blue><b>Results:</b></td></tr><tr><td style=\"padding: 5px; border: 1px solid blue;\"><center><table><tr><td>" );

		if ( image != null && !image.equals( "" ) )
		{
			String url = this.getURLString();

			warning.append( "<center><a href=\"" );
			warning.append( url );
			warning.append( url.indexOf( "?" ) == -1 ? "?" : "&" );
			warning.append( "confirm=on\"><img id=\"warningImage\" src=\"http://images.kingdomofloathing.com/itemimages/" );
			warning.append( image );
			warning.append( "\" width=30 height=30></a><br></center>" );
		}

		warning.append( "<blockquote>" );
		warning.append( message );
		warning.append( "</blockquote></td></tr></table></center></td></tr></table></center></body></html>" );

		this.pseudoResponse( "HTTP/1.1 200 OK", warning.toString() );
	}

	public void sendCloverWarning()
	{
		StringBuffer warning = new StringBuffer();

		warning.append( "<html><head><script language=Javascript src=\"/basics.js\"></script>" );

		warning.append( "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://images.kingdomofloathing.com/styles.css\"></head>" );
		warning.append( "<body><center><table width=95%	 cellspacing=0 cellpadding=0><tr><td style=\"color: white;\" align=center bgcolor=blue><b>Results:</b></td></tr><tr><td style=\"padding: 5px; border: 1px solid blue;\"><center><table><tr><td><center>" );

		warning.append( "<table><tr>" );

		String url = this.getURLString();

		warning.append( "<td align=center valign=center><div id=\"lucky\" style=\"padding: 4px 4px 4px 4px\"><a style=\"text-decoration: none\" href=\"" );
		warning.append( url );
		warning.append( url.indexOf( "?" ) == -1 ? "?" : "&" );
		warning.append( "confirm=on\"><img src=\"http://images.kingdomofloathing.com/itemimages/clover.gif\" width=30 height=30 border=0>" );
		warning.append( "</a></div></td>" );

		warning.append( "<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>" );

		warning.append( "<td align=center valign=center><div id=\"unlucky\" style=\"padding: 4px 4px 4px 4px\"><a style=\"text-decoration: none\" href=\"#\" onClick=\"multiUse('multiuse.php', " );
		warning.append( ItemPool.TEN_LEAF_CLOVER );
		warning.append( ", " );
		warning.append( InventoryManager.getCount( ItemPool.TEN_LEAF_CLOVER ) );
		warning.append( "); void(0);\"><img src=\"http://images.kingdomofloathing.com/itemimages/disclover.gif\" width=30 height=30 border=0>" );
		warning.append( "</a></div></td>" );

		warning.append( "</tr></table></center><blockquote>KoLmafia has detected a ten-leaf clover in your inventory.  If you are sure you wish to use it, click on the assembled clover on the left.  If this was an accident, please click on the disassembled clover on the right to disassemble your clovers first.	 To disable this warning, please check your preferences and disable clover protection.</blockquote></td></tr></table></center></td></tr></table></center></body></html>" );

		this.pseudoResponse( "HTTP/1.1 200 OK", warning.toString() );
	}

	private void handleSafety()
	{
		if ( RelayRequest.lastSafety == null )
		{
			this.pseudoResponse( "HTTP/1.1 200 OK", "" );
			return;
		}

		AreaCombatData combat = RelayRequest.lastSafety.getAreaSummary();

		if ( combat == null )
		{
			this.pseudoResponse( "HTTP/1.1 200 OK", "" );
			return;
		}

		StringBuffer buffer = new StringBuffer();
		buffer.append( "<table width=\"100%\"><tr><td align=left valign=top><font size=3>" );
		buffer.append( RelayRequest.lastSafety.getAdventureName() );
		buffer.append( "</font></td><td align=right valign=top><font size=2>" );

		buffer.append( "<a style=\"text-decoration: none\" href=\"javascript: " );

		buffer.append( "var safety; if ( document.getElementById ) " );
		buffer.append( "safety = top.chatpane.document.getElementById( 'safety' ); " );
		buffer.append( "else if ( document.all ) " );
		buffer.append( "safety = top.chatpane.document.all[ 'safety' ]; " );

		buffer.append( "safety.closed = true;" );
		buffer.append( "safety.active = false;" );
		buffer.append( "safety.style.display = 'none'; " );
		buffer.append( "var nodes = top.chatpane.document.body.childNodes; " );
		buffer.append( "for ( var i = 0; i < nodes.length; ++i ) " );
		buffer.append( "if ( nodes[i].style && nodes[i].id != 'safety' ) " );
		buffer.append( "nodes[i].style.display = nodes[i].unsafety; " );

		buffer.append( "void(0);\">x</a></font></td></tr></table>" );
		buffer.append( "<br/><font size=2>" );

		String combatData = combat.toString( true );
		combatData = combatData.substring( 6, combatData.length() - 7 );
		buffer.append( combatData );

		buffer.append( "</font>" );
		this.pseudoResponse( "HTTP/1.1 200 OK", buffer.toString() );
	}

	private void handleCommand()
	{
		// None of the above checks wound up happening.	 So, do some
		// special handling, catching any exceptions that happen to
		// popup along the way.

		String path = this.getBasePath();
		if ( path.endsWith( "submitCommand" ) )
		{
			submitCommand( this.getFormField( "cmd" ) );
			this.pseudoResponse( "HTTP/1.1 200 OK", "" );
		}
		else if ( path.endsWith( "executeCommand" ) )
		{
			submitCommand( this.getFormField( "cmd" ) );
			this.pseudoResponse( "HTTP/1.1 200 OK", "" );
		}
		else if ( path.endsWith( "sideCommand" ) )
		{
			submitCommand( this.getFormField( "cmd" ), true );
			this.pseudoResponse( "HTTP/1.1 302 Found", "/charpane.php" );
		}
		else if ( path.endsWith( "logout" ) )
		{
			submitCommand( "logout" );
			this.pseudoResponse( "HTTP/1.1 302 Found", "/loggedout.php" );
		}
		else if ( path.endsWith( "messageUpdate" ) )
		{
			this.pseudoResponse( "HTTP/1.1 200 OK", LocalRelayServer.getNewStatusMessages() );
		}
		else if ( path.endsWith( "lookupLocation" ) )
		{
			RelayRequest.lastSafety =
				AdventureDatabase.getAdventureByURL( "adventure.php?snarfblat=" + this.getFormField( "snarfblat" ) );
			AdventureFrame.updateSelectedAdventure( RelayRequest.lastSafety );
			this.handleSafety();
		}
		else if ( path.endsWith( "updateLocation" ) )
		{
			this.handleSafety();
		}
		else
		{
			this.pseudoResponse( "HTTP/1.1 200 OK", "" );
		}
	}

	private void submitCommand( String command )
	{
		submitCommand( command, false );
	}

	private void submitCommand( String command, boolean suppressUpdate )
	{
		GenericRequest.suppressUpdate( suppressUpdate );
		CommandDisplayFrame.executeCommand( command );

		while ( CommandDisplayFrame.hasQueuedCommands() )
		{
			this.pauser.pause( 500 );
		}
		GenericRequest.suppressUpdate( false );
	}

	private void handleChat()
	{
		// If you are in chat, and the person submitted a command
		// via chat, check to see if it's a CLI command.  Otherwise,
		// run it as normal.

		String chatResponse = ChatRequest.executeChatCommand( this.getFormField( "graf" ) );
		if ( chatResponse != null )
		{
			this.pseudoResponse( "HTTP/1.1 200 OK", "<font color=\"olive\">" + chatResponse + "</font><br>" );
			return;
		}

		super.run();

		if ( !ChatManager.isRunning() || this.getPath().startsWith( "submitnewchat.php" ) )
		{
			ChatManager.updateChat( this.responseText );
		}

		if ( Preferences.getBoolean( "relayFormatsChatText" ) )
		{
			this.responseText = ChatManager.getNormalizedContent( this.responseText, false );
		}

	}

	public void handleSimple()
	{
		// If there is an attempt to view the error page, or if
		// there is an attempt to view the robots file, neither
		// are available on KoL, so return.

		String path = this.getBasePath();

		if ( path.equals( "missingimage.gif" ) || path.endsWith( "robots.txt" ) || path.endsWith( "favicon.ico" ) )
		{
			this.sendNotFound();
			return;
		}

		// If this is a command from the browser, handle it before
		// moving on to anything else.

		if ( path.startsWith( "KoLmafia/" ) )
		{
			this.handleCommand();
			return;
		}

		// Check to see if it's a request from the local images folder.
		// If it is, go ahead and send it.

		if ( path.startsWith( "images/playerpics/" ) )
		{
			FileUtilities.downloadImage( "http://pics.communityofloathing.com/albums/" + path.substring(
				path.indexOf( "playerpics" ) ) );

			this.sendLocalImage( path );
			return;
		}

		if ( path.startsWith( "images/" ) )
		{
			this.sendLocalImage( path );
			return;
		}

		// If it's an ASH override script, make sure to handle it
		// exactly as it should.

		if ( path.endsWith( ".ash" ) )
		{
			if ( !KoLmafiaASH.getClientHTML( this ) )
			{
				this.sendNotFound();
			}

			return;
		}

		// Local files never have form fields.	Remove them, because
		// they're probably just used for data tracking purposes
		// client-side.

		this.data.clear();
		this.sendLocalFile( path );
	}

	public void run()
	{
		String path = this.getBasePath();

		if ( path.startsWith( "http" ) )
		{
			super.run();
			return;
		}

		if ( !path.endsWith( ".php" ) )
		{
			this.handleSimple();
			return;
		}

		// If it's a chat request, handle it right away and return.
		// Otherwise, continue on.

		if ( this.isChatRequest )
		{
			this.handleChat();
			return;
		}

		// If it gets this far, consider firing a relay browser
		// override for it.

		if ( this.allowOverride && KoLmafiaASH.getClientHTML( this ) )
		{
			return;
		}

		if ( path.startsWith( "lchat.php" ) )
		{
			if ( Preferences.getBoolean( "relayUsesIntegratedChat" ) )
			{
				this.sendLocalFile( "chat.html" );
				return;
			}

			super.run();

			this.responseText = StringUtilities.globalStringReplace( this.responseText, "<p>", "<br><br>" );
			this.responseText = StringUtilities.globalStringReplace( this.responseText, "<P>", "<br><br>" );
			this.responseText = StringUtilities.singleStringDelete( this.responseText, "</span>" );

			return;
		}
		
		// Track use of "Recall ancient skills button" from the account menu
		// It doesn't set a flag in your preferences, we will figure
		// it by checking the account menu for buttons.
		if ( path.startsWith( "account.php" ) )
		{
			String action = this.getFormField( "action" );
			if ( action != null && action.equals( "recallskills" ) )
			{
				String field = this.getFormField( "confirm" );
				if ( field != null && field.equals( "on" ) )
				{
					KoLCharacter.setSkillsRecalled( true );
				}
			}
		}

		// Load custom items from OneTonTomato's script if they
		// are currently being requested.
		if ( path.startsWith( "desc_item.php" ) )
		{
			String item = this.getFormField( "whichitem" );
			if ( item != null && item.startsWith( "custom" ) )
			{
				this.pseudoResponse( "HTTP/1.1 200 OK", CustomItemDatabase.retrieveCustomItem( item.substring( 6 ) ) );
				return;
			}

			if ( showWikiLink( item ) )
			{
				String location = ShowDescriptionList.getWikiLocation( ItemDatabase.getItemName( item ) );
				if ( location != null )
				{
					this.pseudoResponse( "HTTP/1.1 302 Found", location );
					return;
				}
			}
		}

		TurnCounter expired = TurnCounter.getExpiredCounter( this );

		if ( expired != null )
		{
			int remain = expired.getTurnsRemaining();
			String message = null;

			if ( remain == 0 )
			{
				message = "The indicated counter has expired, so may wish to adventure somewhere else at this time.  If you are certain that this is where you'd like to adventure, click on the image to proceed.";
			}
			else if ( remain > 0 )
			{
				message = "The indicated counter will expire after " + 
					remain + " more turn" +
					((remain != 1) ? "s" : "") +
					", so may wish to adventure somewhere else at this time.  If you are certain that this is where you'd like to adventure, click on the image to proceed.";
			}

			if ( message != null )
			{
				if ( expired.getLabel().equals( "Fortune Cookie" ) )
				{
					message += "<br><br>" + UseItemRequest.lastSemirareMessage();
				}
				this.sendGeneralWarning( expired.getImage(), message );
				return;
			}
		}

		if ( path.startsWith( "desc_effect.php" ) && Preferences.getBoolean( "relayAddsWikiLinks" ) )
		{
			String effect = this.getFormField( "whicheffect" );
			String location =
				ShowDescriptionList.getWikiLocation( new AdventureResult(
					EffectDatabase.getEffectName( effect ), 1, true ) );

			if ( location != null )
			{
				this.pseudoResponse( "HTTP/1.1 302 Found", location );
				return;
			}
		}

		String urlString = this.getURLString();
		KoLAdventure adventure = AdventureDatabase.getAdventureByURL( urlString );

		// We want to do some checks for the battlefield:
		// - make sure player doesn't lose a Wossname by accident
		// - give player chance to cash in dimes and quarters

		if ( this.sendBattlefieldWarning( urlString, adventure ) )
		{
			return;
		}

		String adventureName = adventure != null ? adventure.getAdventureName() :
			AdventureDatabase.getUnknownName( urlString );

		if ( adventureName != null && this.getFormField( "confirm" ) == null )
		{
			// Wait until any restoration scripts finish running
			// before allowing an adventuring request to continue.

			while ( KoLmafia.isRunningBetweenBattleChecks() )
			{
				this.pauser.pause( 200 );
			}

			// Check for clovers as well so that people don't
			// accidentally use up a clover in the middle of a bad
			// moon run.

			if ( AdventureDatabase.isPotentialCloverAdventure( adventureName ) && Preferences.getBoolean( "cloverProtectActive" ) )
			{
				this.sendCloverWarning();
				return;
			}

			// Special handling of adventuring locations before it's
			// registered internally with KoLmafia.

			// Sometimes, people want the MCD rewards from various
			// boss monsters.  Let's help out.

			if ( path.startsWith( "adventure.php" ) )
			{
				String location = adventure == null ? null : adventure.getAdventureId();

				// This one's for the Boss Bat, who has special
				// items at 4 and 8.

				if ( location != null && location.equals( "34" ) && KoLCharacter.mcdAvailable() )
				{
					this.sendBossWarning( "Boss Bat", "bossbat.gif", 4, "batpants.gif", 8, "batbling.gif" );
					return;
				}
			}

			// More MCD rewards.  This one is for the Knob Goblin
			// King, who has special items at 3 and 7.

			else if ( path.startsWith( "knob.php" ) )
			{
				if ( this.getFormField( "king" ) != null && KoLCharacter.mcdAvailable() )
				{
					this.sendBossWarning( "Knob Goblin King", "goblinking.gif", 3, "glassballs.gif", 7, "batcape.gif" );
					return;
				}
			}

			// More MCD rewards.  This one is for the Bonerdagon,
			// who has special items at 5 and 10.

			else if ( path.startsWith( "cyrpt.php" ) )
			{
				if ( this.getFormField( "action" ) != null && KoLCharacter.mcdAvailable() )
				{
					this.sendBossWarning( "Bonerdagon", "bonedragon.gif", 5, "rib.gif", 10, "vertebra.gif" );
					return;
				}
			}

			// If the person is visiting the sorceress and they
			// forgot to make the Wand, remind them.

			else if ( path.startsWith( "lair6.php" ) )
			{
				// As of NS 13,they need not have it
				// equipped. In fact, there are far better
				// weapons to equip for the battle. But, just
				// in case, check current equipment as well as
				// inventory.

				String place = this.getFormField( "place" );
				if ( place != null && place.equals( "5" ) &&
				     !KoLCharacter.hasEquipped( SorceressLairManager.NAGAMAR ) &&
				     !InventoryManager.retrieveItem( SorceressLairManager.NAGAMAR ) )
				{
					this.sendGeneralWarning(
						"wand.gif", "It's possible there is something very important you're forgetting to do." );
					return;
				}
			}
		}

		else if ( path.startsWith( "ascend.php" ) )
		{
			if ( this.getFormField( "action" ) != null )
			{
				RequestThread.postRequest( new EquipmentRequest( SpecialOutfit.BIRTHDAY_SUIT ) );
				RequestThread.postRequest( new EquipmentRequest( EquipmentRequest.UNEQUIP, EquipmentManager.FAMILIAR ) );
			}
		}

		// If it gets this far, it's a normal file.  Go ahead and
		// process it accordingly.

		super.run();

		// The request might have printed to the status line, so enable
		// the GUI

		KoLmafia.enableDisplay();

		if ( this.responseCode == 302 )
		{
			this.pseudoResponse( "HTTP/1.1 302 Found", this.redirectLocation );
		}
		else if ( this.responseCode != 200 )
		{
			this.sendNotFound();
		}

		return;
	}

	private static boolean showWikiLink( final String item )
	{
		if ( !Preferences.getBoolean( "relayAddsWikiLinks" ) )
			return false;

		switch ( ItemDatabase.getItemIdFromDescription( item ) )
		{
		case 2271:	// dusty bottle of Merlot
		case 2272:	// dusty bottle of Port
		case 2273:	// dusty bottle of Pinot Noir
		case 2274:	// dusty bottle of Zinfandel
		case 2275:	// dusty bottle of Marsala
		case 2276:	// dusty bottle of Muscat
			return false;
		}
		return true;
	}

	private void downloadSimulatorFile( final String filename )
	{
		try
		{
			BufferedReader reader = DataUtilities.getReader( "", "http://sol.kolmafia.us/" + filename );

			String line;
			StringBuffer contents = new StringBuffer();

			while ( ( line = reader.readLine() ) != null )
			{
				contents.append( line );
				contents.append( KoLConstants.LINE_BREAK );
			}

			StringUtilities.globalStringReplace( contents, "images/", "http://sol.kolmafia.us/images/" );

			PrintStream writer = RequestLogger.openStream( "relay/simulator/" + filename, NullStream.INSTANCE, true );
			writer.println( contents.toString() );
			writer.close();
		}
		catch ( Exception e )
		{
			KoLmafia.updateDisplay( KoLConstants.ERROR_STATE, "Failed to create simulator file <" + filename + ">" );
		}
	}
}
