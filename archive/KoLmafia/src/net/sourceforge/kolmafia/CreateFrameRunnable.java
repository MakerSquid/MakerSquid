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

package net.sourceforge.kolmafia;

import apple.dts.samplecode.osxadapter.OSXAdapter;
import java.lang.reflect.Constructor;

import java.awt.Frame;
import javax.swing.JFrame;
import javax.swing.SwingUtilities;

import net.sourceforge.kolmafia.persistence.Preferences;
import net.sourceforge.kolmafia.swingui.ChatFrame;
import net.sourceforge.kolmafia.swingui.GenericFrame;
import net.sourceforge.kolmafia.swingui.GenericPanelFrame;
import net.sourceforge.kolmafia.swingui.LoginFrame;
import net.sourceforge.kolmafia.swingui.SendMessageFrame;
import net.sourceforge.kolmafia.swingui.SkillBuffFrame;
import net.sourceforge.kolmafia.swingui.TabbedChatFrame;
import net.sourceforge.kolmafia.swingui.menu.GlobalMenuBar;

public class CreateFrameRunnable
	implements Runnable, KoLConstants
{
	private final Class creationType;
	private JFrame creation;
	private Constructor creator;
	private final Object[] parameters;

	public CreateFrameRunnable( final Class creationType )
	{
		this( creationType, new Object[ 0 ] );
	}

	public CreateFrameRunnable( final Class creationType, final Object[] parameters )
	{
		this.creationType = creationType;
		this.parameters = parameters;
		Class[] parameterTypes = new Class[ parameters.length ];
		for ( int i = 0; i < parameters.length; ++i )
		{
			parameterTypes[ i ] = parameters[ i ] == null ? null : parameters[ i ].getClass();
		}

		this.creator = null;
		boolean isValidConstructor;

		Class[] constructorParameterTypes;
		Constructor[] constructors = creationType.getConstructors();

		for ( int i = 0; i < constructors.length; ++i )
		{
			constructorParameterTypes = constructors[ i ].getParameterTypes();
			if ( constructorParameterTypes.length != parameters.length )
			{
				continue;
			}

			isValidConstructor = true;
			for ( int j = 0; j < constructorParameterTypes.length && isValidConstructor; ++j )
			{
				if ( parameterTypes[ j ] != null && !constructorParameterTypes[ j ].isAssignableFrom( parameterTypes[ j ] ) )
				{
					isValidConstructor = false;
				}
			}

			if ( isValidConstructor )
			{
				this.creator = constructors[ i ];
			}
		}
	}

	public void run()
	{
		if ( StaticEntity.isHeadless() )
		{
			return;
		}

		if ( this.creator == null )
		{
			KoLmafia.updateDisplay( KoLConstants.ERROR_STATE, this.creationType.getName() + " could not be loaded" );
			return;
		}

		if ( !SwingUtilities.isEventDispatchThread() )
		{
			try
			{
				SwingUtilities.invokeAndWait( this );
				return;
			}
			catch ( Exception e )
			{
				// This should not happen.  Therefore, print
				// a stack trace for debug purposes.

				StaticEntity.printStackTrace( e, this.creationType.getName() + " could not be loaded" );
				return;
			}
		}

		try
		{
			this.createFrame();
		}
		catch ( Exception e )
		{
			// This should not happen.  Therefore, print
			// a stack trace for debug purposes.

			StaticEntity.printStackTrace( e, this.creationType.getName() + " could not be loaded" );
			return;
		}
	}

	public void createFrame()
	{
		// If there is no creation creation, then return
		// from the method because there's nothing to do.

		String searchString = this.creationType.toString();
		searchString = searchString.substring( searchString.lastIndexOf( "." ) + 1 );

		boolean appearsInTab = GenericFrame.appearsInTab(
			searchString.endsWith( "ChatFrame" ) ? "ChatManager" : searchString );

		// Make the whole desktop the first time we create a tab
		if ( appearsInTab && !KoLDesktop.instanceExists() )
		{
			KoLDesktop.getInstance().initializeTabs();
		}

		// Make the frame for the first time
		if ( !this.loadPreviousFrame() )
		{
			this.runConstruction( appearsInTab );
		}

		// If previously made desktop has been cleared out, remake it.
		if ( appearsInTab && !KoLDesktop.containsTab( (GenericFrame) this.creation ) )
		{
			KoLDesktop.getInstance().initializeTabs();
		}

		if ( this.creation == null )
		{
			return;
		}

		// Some frames have a recipient parameter that
		// should be passed around.

		if ( this.creationType == SkillBuffFrame.class && this.parameters.length == 1 )
		{
			( (SkillBuffFrame) this.creation ).setRecipient( (String) this.parameters[ 0 ] );
		}
		if ( this.creationType == SendMessageFrame.class )
		{
			( (SendMessageFrame) this.creation ).setRecipient( this.parameters.length == 0 ? "" : (String) this.parameters[ 0 ] );
		}

		this.creation.pack();
		if ( !( this.creation instanceof GenericFrame ) )
		{
			this.creation.setLocationRelativeTo( null );
		}

		this.creation.setEnabled( true );

		// With the location set set on screen, make sure
		// to disable it (if necessary), ensure the frame's
		// visibility on screen and request focus.

		if ( appearsInTab )
		{
			KoLDesktop.addTab( (GenericFrame) this.creation );
			if ( !KoLDesktop.isInitializing() )
			{
				KoLDesktop.displayDesktop();
			}
			KoLDesktop.showComponent( (GenericFrame) this.creation );
		}
		else
		{
			this.creation.setVisible( true );
			this.creation.requestFocus();
		}

		this.creation = null;
	}

	private boolean loadPreviousFrame()
	{
		if ( this.creationType == ChatFrame.class )
		{
			return false;
		}

		Frame[] frames = Frame.getFrames();

		for ( int i = 0; i < frames.length; ++i )
		{
			Frame frame = frames[ i ];
			if ( frame.getClass() == this.creationType )
			{
				this.creation = (JFrame) frame;
				return true;
			}
		}

		return false;
	}

	private void runConstruction( boolean appearsInTab )
	{
		if ( Preferences.getBoolean( "guiUsesOneWindow" ) )
		{
			if ( this.creationType != LoginFrame.class && this.creationType != ChatFrame.class && this.creationType != TabbedChatFrame.class )
			{
				KoLDesktop.removeExtraTabs();
				appearsInTab = true;
			}
		}

		try
		{
			this.creation = (JFrame) this.creator.newInstance( this.parameters );
		}
		catch ( Exception e )
		{
			// This should not happen.  Therefore, print
			// a stack trace for debug purposes.

			StaticEntity.printStackTrace( e, this.creationType.getName() + " could not be loaded" );
			return;
		}

		if ( appearsInTab )
		{
			return;
		}

		// Load the KoL frame to the appropriate location
		// on the screen now that the frame has been packed
		// to the appropriate size.

		try
		{
			if ( this.creation instanceof GenericFrame )
			{
				if ( ( (GenericFrame) this.creation ).useSidePane() )
				{
					( (GenericFrame) this.creation ).addCompactPane();
				}
			}
			else
			{
				// Set a menu bar for anything that doesn't
				// extend the KoLmafia frame classes.

				this.creation.setJMenuBar( new GlobalMenuBar() );
			}

			// In the case of OSX, we'll also need a shutdown hook
			boolean isUsingMac = System.getProperty( "os.name" ).startsWith( "Mac" );

			if ( isUsingMac )
			{
				// Generate and register the OSXAdapter, passing it a hash of all the methods we wish to
				// use as delegates for various com.apple.eawt.ApplicationListener methods

				OSXAdapter.setQuitHandler(KoLmafia.class, KoLmafia.class.getDeclaredMethod("quit", (Class[])null));
				OSXAdapter.setAboutHandler(KoLmafia.class, KoLmafia.class.getDeclaredMethod("about", (Class[])null));
				OSXAdapter.setPreferencesHandler(KoLmafia.class, KoLmafia.class.getDeclaredMethod("preferences", (Class[])null));
			}
		}
		catch ( Exception e )
		{
			// This should not happen.  Therefore, print
			// a stack trace for debug purposes.

			StaticEntity.printStackTrace( e, this.creationType.getName() + " could not be loaded" );
		}
	}
}
