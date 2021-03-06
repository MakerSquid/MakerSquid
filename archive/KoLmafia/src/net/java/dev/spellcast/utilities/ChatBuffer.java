/**
 * Copyright (c) 2003, Spellcast development team
 * http://spellcast.dev.java.net/
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
 *  [3] Neither the name "Spellcast development team" nor the names of
 *      its contributors may be used to endorse or promote products
 *      derived from this software without specific prior written
 *      permission.
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
 *		notice, this list of conditions and the following disclaimer.
 *  [2] Redistributions in binary form must reproduce the above copyright
 *		notice, this list of conditions and the following disclaimer in
 *		the documentation and/or other materials provided with the
 *		distribution.
 *  [3] Neither the name "KoLmafia" nor the names of its contributors may
 *      be used to endorse or promote products derived from this software
 *		without specific prior written permission.
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

package net.java.dev.spellcast.utilities;

import java.io.File;
import java.io.PrintWriter;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;

import javax.swing.JEditorPane;
import javax.swing.JScrollPane;
import javax.swing.ScrollPaneConstants;
import javax.swing.SwingUtilities;
import javax.swing.text.Element;
import javax.swing.text.html.HTMLDocument;

/**
 * A multi-purpose message buffer which stores all sorts of the messages that can either be displayed or serialized in
 * HTML form. In essence, this shifts the functionality of processing a chat message from the <code>ChatPanel</code>
 * to an object external to it, which allows more object-oriented design and less complications.
 */

public class ChatBuffer
{
	private boolean shouldReset = false;
	private final DisplayQueueHandler HANDLER = new DisplayQueueHandler();

	private static HashMap activeLogFiles = new HashMap();
	private final ArrayList contentQueue = new ArrayList();

	private final String title;
	private final String header;
	private String filename;
	private final boolean autoScroll;

	protected ArrayList scrollBars;
	protected ArrayList displayPanes;

	protected PrintWriter activeLogWriter;
	protected StringBuffer displayBuffer;

	protected static final String EMPTY_STRING = "";
	protected static final String NEW_LINE = System.getProperty( "line.separator" );
	protected static String BUFFER_STYLE = "body { font-family: sans-serif; }";

	/**
	 * Constructs a new <code>ChatBuffer</code>. However, note that this does not automatically translate into the
	 * messages being displayed; until a chat display is set, this buffer merely stores the message content to be
	 * displayed.
	 */

	public ChatBuffer( final String title, final boolean autoScroll )
	{
		this.displayBuffer = new StringBuffer();
		this.title = title;

		this.autoScroll = autoScroll;
		this.header = "<html><head>" + ChatBuffer.NEW_LINE + "<title>" + title + "</title>" + ChatBuffer.NEW_LINE;

		this.scrollBars = new ArrayList();
		this.displayPanes = new ArrayList();

		this.HANDLER.queueClear();
		this.shouldReset = false;
	}

	/**
	 * Method used for clearing the buffer so it can start fresh. This is used whenever you want to clear the editor
	 * pane from being too full (in the event that it ever happens).
	 */

	public void clearBuffer()
	{
		this.HANDLER.queueClear();
	}

	/**
	 * Method used to get the current content of the buffer as a string
	 */

	public String getBuffer()
	{
		return this.displayBuffer.toString();
	}

	public boolean hasChatDisplay()
	{
		return !this.displayPanes.isEmpty();
	}

	/**
	 * Sets the chat display used to display the chat messages currently being stored in the buffer. Note that whenever
	 * modifications are made to the buffer, the display will also be modified to reflect these changes.
	 *
	 * @param display The chat display to be used to display incoming messages.
	 */

	public JScrollPane setChatDisplay( final JEditorPane display )
	{
		if ( display == null )
		{
			return null;
		}

		display.setContentType( "text/html" );
		display.setEditable( false );

		JScrollPane scroller =
			new JScrollPane(
				display, ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS, ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER );

		this.scrollBars.add( new WeakReference( scroller.getVerticalScrollBar() ) );
		this.displayPanes.add( new WeakReference( display ) );

		display.setText( this.header + "<style>" + ChatBuffer.BUFFER_STYLE + "</style></head><body>" + this.displayBuffer.toString() + "</body></html>" );

		return scroller;
	}

	/**
	 * Sets the log file used to actively record messages that are being stored in the buffer. Note that whenever
	 * modifications are made to the buffer, the file will also be modified to reflect these changes.
	 */

	public void setActiveLogFile( final File f )
	{
		if ( f == null || this.title == null )
		{
			return;
		}

		String filename = f.getPath();

		if ( filename == null || this.title == null )
		{
			return;
		}

		if ( this.filename != null && this.filename.equals( filename ) )
		{
			return;
		}

		try
		{
			if ( ChatBuffer.activeLogFiles.containsKey( filename ) )
			{
				this.filename = filename;
				this.activeLogWriter = (PrintWriter) ChatBuffer.activeLogFiles.get( filename );
			}
			else
			{
				boolean shouldAppend = f.exists();
				this.activeLogWriter = new PrintWriter( DataUtilities.getOutputStream( f, shouldAppend ), true );

				this.filename = filename;
				ChatBuffer.activeLogFiles.put( filename, this.activeLogWriter );

				if ( !shouldAppend )
				{
					this.updateLogFile( this.header );
					this.updateLogFile( "<style>" + ChatBuffer.BUFFER_STYLE + "</style>" );
					this.updateLogFile( "<body>" );
				}
			}

			this.updateLogFile( this.displayBuffer.toString() );
		}
		catch ( Exception e )
		{
			throw new RuntimeException( "The file <" + filename + "> could not be opened for writing" );
		}
	}

	/**
	 * Closes the log file used to actively record messages that are being stored in the buffer. This formally closes
	 * the file and sets the log file currently being used to null so that no future updates are attempted.
	 */

	public void closeActiveLogFile()
	{
		if ( this.activeLogWriter != null )
		{
			this.updateLogFile( ChatBuffer.NEW_LINE + ChatBuffer.NEW_LINE );
			this.updateLogFile( "</body></html>" );

			this.activeLogWriter.close();
			this.activeLogWriter = null;
		}
	}

	/**
	 * Appends the given <code>SpellcastMessage</code> to the chat buffer. Note that though the parameter allows for
	 * <i>any</i> <code>SpellcastMessage</code> to be appended to the buffer, the truth is, only pre-specified
	 * messages will actually be displayed while others will simply be ignored.
	 *
	 * @param message The message to be appended to this <code>ChatBuffer</code>
	 */

	public void append( final String message )
	{
		if ( message == null || message.trim().length() == 0 )
		{
			return;
		}

		this.fireBufferChanged( message );
	}

	public void fireBufferChanged()
	{
		this.fireBufferChanged( null );
	}

	/**
	 * An internal function used to indicate that something has changed with regards to the <code>ChatBuffer</code>.
	 * This includes any addition to the chat buffer itself and a change in state, such as changing the display window
	 * or the file to which the data is being logged.
	 */

	private void fireBufferChanged( final String newContents )
	{
		this.HANDLER.queueUpdate( newContents );
		if ( this.activeLogWriter != null && newContents != null )
		{
			this.updateLogFile( newContents );
		}
	}

	/**
	 * An internal module used to update the log file. This method basically appends the given string to the current
	 * logfile. However, because many things may wish to update a log file, it is useful to have an extra module whose
	 * job is merely to write data to the current log file.
	 *
	 * @param chatContent The content to be written to the file
	 */

	private void updateLogFile( final String chatContent )
	{
		if ( this.activeLogWriter != null )
		{
			this.activeLogWriter.println( chatContent );
			this.activeLogWriter.flush();
		}
	}

	private class DisplayQueueHandler
		implements Runnable
	{
		private String resetText;
		private Object newContents;

		public void run()
		{
			if ( ChatBuffer.this.displayPanes.isEmpty() )
			{
				ChatBuffer.this.contentQueue.clear();
				ChatBuffer.this.shouldReset = false;
				return;
			}

			while ( ChatBuffer.this.shouldReset || !ChatBuffer.this.contentQueue.isEmpty() )
			{
				if ( ChatBuffer.this.shouldReset )
				{
					ChatBuffer.this.contentQueue.clear();
					this.reset();
				}
				else
				{
					this.newContents = ChatBuffer.this.contentQueue.remove( 0 );
					this.append();
				}
			}

			this.scroll();
		}

		private void reset()
		{
			ChatBuffer.this.shouldReset = false;

			this.resetText =
				ChatBuffer.this.header + "<style>" + ChatBuffer.BUFFER_STYLE + "</style></head><body>" + ChatBuffer.this.displayBuffer.toString() + "</body></html>";

			for ( int i = 0; i < ChatBuffer.this.displayPanes.size(); ++i )
			{
				WeakReference display = (WeakReference) ChatBuffer.this.displayPanes.get( i );
				this.resetOnce( (JEditorPane) display.get() );
			}
		}

		private void resetOnce( final JEditorPane displayPane )
		{
			if ( displayPane == null )
			{
				return;
			}

			displayPane.setText( this.resetText );
		}

		private void append()
		{
			for ( int i = 0; i < ChatBuffer.this.displayPanes.size(); ++i )
			{
				WeakReference display = (WeakReference) ChatBuffer.this.displayPanes.get( i );
				this.appendOnce( (JEditorPane) display.get() );
			}
		}

		private void appendOnce( final JEditorPane displayPane )
		{
			if ( displayPane == null )
			{
				return;
			}

			HTMLDocument currentHTML = (HTMLDocument) displayPane.getDocument();
			Element parentElement = currentHTML.getDefaultRootElement();

			while ( !parentElement.isLeaf() )
			{
				parentElement = parentElement.getElement( parentElement.getElementCount() - 1 );
			}

			try
			{
				currentHTML.insertAfterEnd( parentElement, (String) this.newContents );
				currentHTML.putProperty( "multiByte", Boolean.FALSE );
			}
			catch ( Exception e )
			{
				// If there's an exception, continue onward so that you
				// still have an updated display.  But, print the stack
				// trace so you know what's going on.

				e.printStackTrace();
			}
		}

		private void scroll()
		{
			for ( int i = 0; i < ChatBuffer.this.displayPanes.size(); ++i )
			{
				WeakReference ref = (WeakReference) ChatBuffer.this.displayPanes.get( i );
				this.scrollOnce( (JEditorPane) ref.get() );
			}
		}

		private void scrollOnce( final JEditorPane displayPane )
		{
			if ( displayPane == null )
			{
				return;
			}

			int length = displayPane.getDocument().getLength();
			displayPane.setCaretPosition( ChatBuffer.this.autoScroll ? Math.max( length - 1, 0 ) : 0 );
		}

		public void queueClear()
		{
			ChatBuffer.this.displayBuffer.setLength( 0 );
			ChatBuffer.this.shouldReset = true;

			SwingUtilities.invokeLater( ChatBuffer.this.HANDLER );
		}

		public void queueUpdate( String newContents )
		{
			if ( newContents == null )
			{
				ChatBuffer.this.shouldReset = true;
			}
			else if ( newContents.indexOf( "<body" ) != -1 )
			{
				ChatBuffer.this.displayBuffer.setLength( 0 );
				ChatBuffer.this.displayBuffer.append( newContents.substring( newContents.indexOf( ">" ) + 1 ).trim() );
				ChatBuffer.this.shouldReset = true;
			}
			else
			{
				newContents = newContents.trim();
				ChatBuffer.this.displayBuffer.append( newContents );

				if ( !ChatBuffer.this.shouldReset )
				{
					ChatBuffer.this.contentQueue.add( newContents );
				}
			}

			SwingUtilities.invokeLater( ChatBuffer.this.HANDLER );
		}
	}
}
