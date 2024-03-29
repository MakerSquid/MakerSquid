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

import com.sun.java.forums.CloseableTabbedPane;

import java.awt.Component;
import java.awt.BorderLayout;
import java.awt.Frame;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.awt.event.MouseEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import java.util.ArrayList;

import javax.swing.Box;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JTabbedPane;
import javax.swing.JToolBar;
import javax.swing.SwingConstants;
import javax.swing.SwingUtilities;

import net.sourceforge.kolmafia.persistence.Preferences;
import net.sourceforge.kolmafia.swingui.AdventureFrame;
import net.sourceforge.kolmafia.swingui.ChatFrame;
import net.sourceforge.kolmafia.swingui.FlowerHunterFrame;
import net.sourceforge.kolmafia.swingui.GenericFrame;
import net.sourceforge.kolmafia.swingui.MailboxFrame;
import net.sourceforge.kolmafia.swingui.SendMessageFrame;
import net.sourceforge.kolmafia.swingui.button.DisplayFrameButton;
import net.sourceforge.kolmafia.swingui.button.LoadScriptButton;
import net.sourceforge.kolmafia.swingui.button.InvocationButton;
import net.sourceforge.kolmafia.swingui.menu.GlobalMenuBar;
import net.sourceforge.kolmafia.utilities.PauseObject;

import tab.CloseListener;
import tab.CloseTabPaneUI;
import tab.CloseTabbedPane;

public class KoLDesktop
	extends GenericFrame
	implements CloseListener
{
	private static final DisplayDesktopRunnable DISPLAYER = new DisplayDesktopRunnable();

	private static KoLDesktop INSTANCE = null;
	private static boolean isInitializing = false;

	private final ArrayList tabListing = new ArrayList();

	public JPanel compactPane;
	public JLabel levelLabel, roninLabel, mcdLabel;
	public JLabel musLabel, mysLabel, moxLabel, drunkLabel;
	public JLabel hpLabel, mpLabel, meatLabel, advLabel;
	public JLabel familiarLabel;

	public KoLDesktop()
	{
	}

	public KoLDesktop( final String title )
	{
		super( "Main Interface" );

		if ( StaticEntity.usesSystemTray() )
		{
			this.addWindowListener( new MinimizeListener() );
		}

		this.getContentPane().setLayout( new BorderLayout() );

		this.tabs.setTabPlacement( SwingConstants.TOP );
		this.getContentPane().add( this.tabs, BorderLayout.CENTER );
		this.addCompactPane();

		JToolBar toolbarPanel = this.getToolbar();
		this.setJMenuBar( new GlobalMenuBar() );

		int scriptButtons = Preferences.getInteger( "scriptButtonPosition" );

		if ( scriptButtons != 0 )
		{
			String[] scriptList = Preferences.getString( "scriptList" ).split( " \\| " );

			JToolBar scriptBar = null;

			if ( scriptButtons == 1 )
			{
				scriptBar = toolbarPanel;
				scriptBar.add( Box.createHorizontalStrut( 10 ) );
			}
			else
			{
				scriptBar = new JToolBar( SwingConstants.VERTICAL );
				scriptBar.setFloatable( false );
			}

			for ( int i = 0; i < scriptList.length; ++i )
			{
				scriptBar.add( new LoadScriptButton( i + 1, scriptList[ i ] ) );
			}

			if ( scriptButtons == 2 )
			{
				JPanel scriptBarHolder = new JPanel();
				scriptBarHolder.add( scriptBar );

				this.getContentPane().add( scriptBarHolder, BorderLayout.EAST );
			}
		}
	}

	public boolean showInWindowMenu()
	{
		return false;
	}

	public JTabbedPane getTabbedPane()
	{
		if ( Preferences.getBoolean( "useDecoratedTabs" ) )
		{
			JTabbedPane tabs = new CloseTabbedPane();

			if ( Preferences.getBoolean( "allowCloseableDesktopTabs" ) )
			{
				( (CloseTabbedPane) tabs ).setCloseIconStyle( CloseTabPaneUI.RED_CLOSE_ICON );
				( (CloseTabbedPane) tabs ).addCloseListener( this );
			}

			return tabs;
		}

		return Preferences.getBoolean( "allowCloseableDesktopTabs" ) ? new CloseableTabbedPane() : new JTabbedPane();
	}

	public void closeOperation( final MouseEvent e, final int overTabIndex )
	{
		if ( overTabIndex == -1 )
		{
			return;
		}

		this.tabListing.remove( overTabIndex );
		this.tabs.removeTabAt( overTabIndex );
	}

	public void initializeTabs()
	{
		if ( KoLDesktop.isInitializing )
		{
			return;
		}

		KoLDesktop.isInitializing = true;
		KoLmafiaGUI.checkFrameSettings();

		String interfaceSetting = Preferences.getString( "initialDesktop" );
		if ( !interfaceSetting.equals( "" ) )
		{
			String[] interfaceArray = interfaceSetting.split( "," );

			if ( !interfaceSetting.equals( "" ) )
			{
				for ( int i = 0; i < interfaceArray.length; ++i )
				{
					if ( interfaceArray[ i ].equals( "LocalRelayServer" ) )
					{
						StaticEntity.getClient().startRelayServer();
						continue;
					}

					KoLmafiaGUI.constructFrame( interfaceArray[ i ] );
				}
			}
		}

		KoLDesktop.isInitializing = false;
	}

	public static final boolean isInitializing()
	{
		return KoLDesktop.isInitializing;
	}

	public void dispose()
	{
		while ( !this.tabListing.isEmpty() )
		{
			this.tabs.removeTabAt( 0 );
			( (GenericFrame) this.tabListing.remove( 0 ) ).dispose();
		}

		super.dispose();
	}

	public static final boolean instanceExists()
	{
		return KoLDesktop.INSTANCE != null;
	}

	public static final KoLDesktop getInstance()
	{
		if ( KoLDesktop.INSTANCE == null )
		{
			KoLDesktop.INSTANCE = new KoLDesktop( KoLConstants.VERSION_NAME );
		}

		return KoLDesktop.INSTANCE;
	}

	public static final void addTab( final GenericFrame content )
	{
		if ( KoLDesktop.INSTANCE == null )
		{
			return;
		}

		int tabIndex = KoLDesktop.INSTANCE.tabListing.indexOf( content );
		if ( tabIndex == -1 )
		{
			KoLDesktop.INSTANCE.tabListing.add( content );

			content.getContentPane().addComponentListener( new TabbedComponentAdapter( content ) );

			KoLDesktop.INSTANCE.tabs.addTab( content.lastTitle, content.getContentPane() );

			if ( content.tabs != null && !KoLDesktop.isInversionExempt( content ) )
			{
				content.tabs.setTabPlacement( SwingConstants.BOTTOM );
			}

			KoLDesktop.INSTANCE.tabs.setSelectedIndex( 0 );
		}
		else
		{
			KoLDesktop.INSTANCE.tabs.setSelectedIndex( tabIndex );
		}
	}

	public static final boolean containsTab( final GenericFrame content )
	{
		if ( KoLDesktop.INSTANCE == null )
		{
			return false;
		}

		return KoLDesktop.INSTANCE.tabListing.indexOf( content ) != -1;
	}

	public static final void removeTab( final GenericFrame content )
	{
		if ( KoLDesktop.INSTANCE == null )
		{
			return;
		}

		int tabIndex = KoLDesktop.INSTANCE.tabListing.indexOf( content );
		if ( tabIndex != -1 )
		{
			KoLDesktop.INSTANCE.tabListing.remove( tabIndex );
			KoLDesktop.INSTANCE.tabs.removeTabAt( tabIndex );
		}
	}

	public static final boolean isInversionExempt( final GenericFrame content )
	{
		return content instanceof AdventureFrame || content instanceof FlowerHunterFrame || content instanceof MailboxFrame || content instanceof SendMessageFrame;
	}

	public static final void displayDesktop()
	{
		try
		{
			if ( SwingUtilities.isEventDispatchThread() )
			{
				KoLDesktop.DISPLAYER.run();
			}
			else
			{
				SwingUtilities.invokeAndWait( KoLDesktop.DISPLAYER );
			}
		}
		catch ( Exception e )
		{
			StaticEntity.printStackTrace( e );
		}
	}

	public void pack()
	{
		super.pack();
		if ( this.tabs.getTabCount() > 0 )
		{
			this.tabs.setSelectedIndex( 0 );
		}
	}

	public static final boolean showComponent( final GenericFrame content )
	{
		if ( KoLDesktop.INSTANCE == null )
		{
			return false;
		}

		int tabIndex = KoLDesktop.INSTANCE.tabListing.indexOf( content );
		if ( tabIndex == -1 )
		{
			return false;
		}

		KoLDesktop.INSTANCE.tabs.setSelectedIndex( tabIndex );
		return true;
	}

	public static final void setTitle( final GenericFrame content, final String newTitle )
	{
		if ( KoLDesktop.INSTANCE == null )
		{
			return;
		}

		int tabIndex = KoLDesktop.INSTANCE.tabListing.indexOf( content );
		if ( tabIndex != -1 )
		{
			KoLDesktop.INSTANCE.tabs.setTitleAt( tabIndex, newTitle );
		}
	}

	public static final void updateTitle()
	{
		if ( KoLDesktop.INSTANCE != null )
		{
			KoLDesktop.INSTANCE.setTitle( KoLDesktop.INSTANCE.lastTitle );
		}

		Frame[] frames = Frame.getFrames();
		for ( int i = 0; i < frames.length; ++i )
		{
			if ( frames[ i ] instanceof GenericFrame )
			{
				GenericFrame frame = (GenericFrame) frames[ i ];

				frame.setTitle( frame.lastTitle );
			}
		}
	}

	public JToolBar getToolbar()
	{
		JToolBar toolbarPanel = super.getToolbar();
		if ( toolbarPanel == null )
		{
			return null;
		}

		toolbarPanel.add( Box.createVerticalStrut( 50 ) );

		toolbarPanel.add( Box.createHorizontalStrut( 5 ) );

		toolbarPanel.add( new DisplayFrameButton( "Council", "council.gif", "CouncilFrame" ) );
		toolbarPanel.add( new InvocationButton(
			"Load in Web Browser", "browser.gif", StaticEntity.getClient(), "openRelayBrowser" ) );

		toolbarPanel.add( new DisplayFrameButton( "Graphical CLI", "command.gif", "CommandDisplayFrame" ) );

		toolbarPanel.add( Box.createHorizontalStrut( 10 ) );

		toolbarPanel.add( new DisplayFrameButton( "IcePenguin Express", "mail.gif", "MailboxFrame" ) );
		toolbarPanel.add( new DisplayFrameButton( "KoLmafia Chat", "chat.gif", "ChatManager" ) );
		toolbarPanel.add( new DisplayFrameButton( "Clan Manager", "clan.gif", "ClanManageFrame" ) );

		toolbarPanel.add( Box.createHorizontalStrut( 10 ) );

		toolbarPanel.add( new DisplayFrameButton( "Player Status", "hp.gif", "CharSheetFrame" ) );
		toolbarPanel.add( new DisplayFrameButton( "Item Manager", "inventory.gif", "ItemManageFrame" ) );
		toolbarPanel.add( new DisplayFrameButton( "Equipment Manager", "equipment.gif", "GearChangeFrame" ) );
		toolbarPanel.add( new DisplayFrameButton( "Store Manager", "mall.gif", "StoreManageFrame" ) );
		toolbarPanel.add( new DisplayFrameButton( "Coin Masters", "coin.gif", "CoinmastersFrame" ) );

		toolbarPanel.add( Box.createHorizontalStrut( 10 ) );

		toolbarPanel.add( new DisplayFrameButton( "Purchase Buffs", "buff.gif", "BuffRequestFrame" ) );
		toolbarPanel.add( new DisplayFrameButton( "Familiar Trainer", "arena.gif", "FamiliarTrainingFrame" ) );
		toolbarPanel.add( new DisplayFrameButton( "Player vs. Player", "flower.gif", "FlowerHunterFrame" ) );
		toolbarPanel.add( new DisplayFrameButton( "Mushroom Plot", "mushroom.gif", "MushroomFrame" ) );

		toolbarPanel.add( Box.createHorizontalStrut( 10 ) );

		toolbarPanel.add( new InvocationButton( "Radio KoL", "radsword.gif", StaticEntity.getClient(), "launchRadioKoL" ) );
		toolbarPanel.add( new DisplayFrameButton( "Farmer's Almanac", "calendar.gif", "CalendarFrame" ) );
		toolbarPanel.add( new DisplayFrameButton( "Preferences", "preferences.gif", "OptionsFrame" ) );

		toolbarPanel.add( Box.createHorizontalStrut( 10 ) );
		toolbarPanel.add( Box.createHorizontalGlue() );

		JProgressBar memoryLabel = new JProgressBar( JProgressBar.HORIZONTAL );
		memoryLabel.setStringPainted( true );

		new MemoryUsageMonitor( memoryLabel ).start();

		toolbarPanel.add( memoryLabel );
		toolbarPanel.add( Box.createHorizontalStrut( 10 ) );
		toolbarPanel.add( new InvocationButton( "Collect Garbage", "trashield.gif", StaticEntity.getClient(), "gc" ) );

		toolbarPanel.add( Box.createHorizontalStrut( 5 ) );

		return toolbarPanel;
	}

	public static final void removeExtraTabs()
	{
		if ( KoLDesktop.INSTANCE == null )
		{
			return;
		}

		String setting = Preferences.getString( "initialDesktop" );
		for ( int i = 0; i < KoLDesktop.INSTANCE.tabListing.size(); ++i )
		{
			GenericFrame frame = (GenericFrame) KoLDesktop.INSTANCE.tabListing.get( i );
			if ( !( frame instanceof ChatFrame ) && setting.indexOf( frame.getFrameName() ) == -1 )
			{
				frame.dispose();
			}
		}
	}

	private class MinimizeListener
		extends WindowAdapter
	{
		public void windowIconified( final WindowEvent e )
		{
			KoLDesktop.this.setVisible( false );
		}
	}

	private static class DisplayDesktopRunnable
		implements Runnable
	{
		public void run()
		{
			KoLDesktop.getInstance().pack();
			KoLDesktop.getInstance().setVisible( true );
			KoLDesktop.getInstance().requestFocus();
		}
	}

	private static class TabbedComponentAdapter
		extends ComponentAdapter
	{
		private GenericFrame frame;

		public TabbedComponentAdapter( final GenericFrame frame )
		{
			this.frame = frame;
		}

		public void componentShown( ComponentEvent e )
		{
			this.frame.requestFocusInWindow();
		}
	}

	private static class MemoryUsageMonitor
		extends Thread
	{
		private JProgressBar label;
		private PauseObject pauser;

		public MemoryUsageMonitor( final JProgressBar label )
		{
			this.label = label;
			this.pauser = new PauseObject();

			this.setDaemon( false );
		}

		public void run()
		{
			while ( true )
			{
				this.pauser.pause( 2000 );

				Runtime runtime = Runtime.getRuntime();

				int maxMemory = (int) ( runtime.maxMemory() >> 10 );
				int heapMemory = (int) ( runtime.totalMemory() >> 10 );
				int usedMemory = (int) ( heapMemory - ( runtime.freeMemory() >> 10 ) );

				this.label.setMaximum( maxMemory );
				this.label.setValue( usedMemory );

				this.label.setString( usedMemory + " KB / " + maxMemory + " KB" );
			}
		}
	}
}
