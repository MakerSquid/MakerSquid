/*************************************************************************
$Id$

Bersirc - A cross platform IRC client utilizing the Claro GUI Toolkit.
Copyright (C) 2004-2005 Theo P. Julienne and Nicholas S. Copeland

This application is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This application is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this application; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
**************************************************************************/

#include "includes.h"

CWidget *joinwin = 0, *btnjoin, *btncancel;
CWidget *join_lbl_channel, *join_txt_channel;
CWidget *join_lbl_key, *join_txt_key;

extern CWidget *mainwin;

void b_joinwin_killed( )
{
	joinwin = 0;
}

void b_joinwin_close( CEvent *e, void *data )
{
	c_widget_close( joinwin );
}

void b_joinwin_join( CEvent *e, void *data )
{
	BServerWindow *win;
	char *channel=0, *key=0, *cmd;

	win = b_server_find_active( );

	if ( !win )
		return;

	channel = ((CTextBoxWidgetInfo *)join_txt_channel->info)->text;
	key = ((CTextBoxWidgetInfo *)join_txt_key->info)->text;

	if ( strcmp ( channel, "" ) != 0 )
	{
		cmd = (char *)malloc ( 256 );
		if ( !cmd )
			return;

		strcpy( cmd, "/join " );
		strcat( cmd, channel );

		if ( strcmp( key, "") != 0 )
		{
			strcat( cmd, " " );			
			strcat( cmd, key );
		}

		b_user_command( win, cmd, 0 );
		free( cmd );
		c_widget_close( joinwin );
	}
}

void b_join_channel_txtchanged( CEvent *e, void *data )
{
	char *channel;

	channel = ((CTextBoxWidgetInfo *)join_txt_channel->info)->text;

	if ( strcmp( channel, "" ) )
		c_widget_enable( btnjoin );
	else
		c_widget_disable( btnjoin );
}

void b_join_channel_enterpressed( CEvent *e, void *data )
{
	char *channel;

	channel = ((CTextBoxWidgetInfo *)join_txt_channel->info)->text;;
	
	if ( channel == 0 )
		return;

	b_joinwin_join( e, 0 );
}

void b_open_joinwin( )
{
	if ( joinwin == 0 )
	{
		joinwin = c_new_window( mainwin, lang_phrase_quick( "join_channel" ), 350, 115, C_DIALOG | C_WINDOW_CENTER_TO_PARENT );
		c_window_set_icon( joinwin, b_icon( "channel_window" ) );
		c_window_maxsize( joinwin, 350, 115 );
		c_window_minsize( joinwin, 350, 115 );
		c_new_event_handler( joinwin, C_EVENT_DESTROY, b_joinwin_killed );

		join_lbl_channel = c_new_label( joinwin, lang_phrase_quick( "channel" ), 10, 20, 70, -1, 0 );
		join_txt_channel = c_new_text( joinwin, "", 95, 18, 245, -1, 0 );
		join_lbl_key = c_new_label( joinwin, lang_phrase_quick( "connectwin_password" ), 10, 50, 70, -1, 0 );
		join_txt_key = c_new_text( joinwin, "", 95, 48, 245, -1, C_TEXTBOX_PASSWORD );
		c_new_event_handler( join_txt_channel, C_EVENT_TEXT_ENTER, b_join_channel_enterpressed );
		c_new_event_handler( join_txt_key, C_EVENT_TEXT_ENTER, b_join_channel_enterpressed );
		c_new_event_handler( join_txt_channel, C_EVENT_TEXT_CHANGED, b_join_channel_txtchanged );
		c_widget_focus( join_txt_channel );
		
		btnjoin = c_new_pushbutton( joinwin, lang_phrase_quick( "join" ), 130, 85, 100, -1, 0 );
		c_new_event_handler( btnjoin, C_EVENT_BUTTON_PRESS, b_joinwin_join );
		c_widget_disable( btnjoin );
		btncancel = c_new_pushbutton( joinwin, lang_phrase_quick( "cancel" ), 240, 85, 100, -1, 0 );
		c_new_event_handler( btncancel, C_EVENT_BUTTON_PRESS, b_joinwin_close );
	}
	else
	{
		c_widget_focus( joinwin );
	}
}

//
