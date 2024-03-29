/*************************************************************************
$Id: irc.c 188 2005-11-05 00:43:35Z terminal $

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

BServerWindow *server_head = 0;
BUserCommand *ucmd_head = 0;
BUserCommand *scmd_head = 0;

#define QMT BERSTAG

char *quitMessages[] = {
	"\002Bersirc 2.2\002: Looks, feels and sounds (?!) different!" QMT,
	"Wow! What a great client! \002Bersirc 2.2\002" QMT,
	"What?! Open source isn't good enough for you? \002Bersirc 2.2\002" QMT,
	"\002Bersirc 2.2\002: All the original sexiness of Bersirc, open to the world." QMT,
	"Get out of that boring IRC client! It's no good for you. \002Bersirc 2.2\002 is your answer!" QMT,
	"\"Help! I've been g:lined from my mIRC!!\" \002Bersirc 2.2\002: less n00bs" QMT,
// back once it's x-platform ;)	"Think cross platform IRC client's never look nice? Think again! \002Bersirc 2.2\002" QMT,
	"I don't like you. But \002Bersirc 2.2\002 does. Try it out now." QMT,
	"Quick! Kill your client! \002Bersirc 2.2\002 is here!" QMT,
	"Think your current client is sexy? Check out \002Bersirc 2.2\002!" QMT,
	"The Bersirc are coming! The Bersirc are coming!" QMT,
	"Yummy, like ircing on a cake!" QMT,
	"\002Bersirc 2.2\002, for external use only." QMT,
	0,
};

#define TXTSZ 17

BServerWindow *b_find_server_by_widget( CWidget *w )
{
	BServerWindow *win, *next;
	
	for ( win = server_head; win != 0; win = next )
	{
		if ( win->window == w || win->content->w == w || win->input == w || win->conmenu.menu == w )
		{
			return win;
		}
		next = win->next;
	}
	
	return NULL;
}

BServerWindow *b_find_server_by_sname( char *data, int connected )
{
	BServerWindow *win;
	
	for ( win = server_head; win != 0; win = win->next )
	{
		if ( !strcasecmp( win->servername, data ) )
		{
			if ( connected == 1 && win->connected == 0 )
				continue;
			
			return win;
		}
	}
	
	return NULL;
}

BServerWindow *b_find_server_by_conn( int connected )
{
	BServerWindow *win;
	
	for ( win = server_head; win != 0; win = win->next )
	{
		if ( win->connected == connected )
			return win;
	}
	
	return NULL;
}

BChatWindow *b_find_chat_by_widget( CWidget *w )
{
	BServerWindow *win, *next;
	BChatWindow *cwin, *cnext;
	
	for ( win = server_head; win != 0; win = next )
	{
		for ( cwin = win->chat_head; cwin != 0; cwin = cnext )
		{
			if ( cwin->window == w || cwin->content->w == w || cwin->input == w || cwin->conmenu.menu == w )
			{
				return cwin;
			}
			cnext = cwin->next;
		}
		
		
		next = win->next;
	}
	
	return NULL;
}

BChatWindow *b_find_chat_by_dest( BServerWindow *win, char *dest )
{
	BChatWindow *cwin, *cnext;

	for ( cwin = win->chat_head; cwin != 0; cwin = cnext )
	{
		if ( !strcasecmp( dest, cwin->dest ) )
		{
			return cwin;
		}
		cnext = cwin->next;
	}
	
	return NULL;
}

void b_server_content_focus( CEvent *e, void *data )
{
	BServerWindow *sw = b_find_server_by_widget( e->caller );
	
	if ( sw == 0 )
		return;
	
	c_widget_focus( sw->input );
	
	b_taskbar_redraw( );
}

char *b_get_quit_message( )
{
	char *qmsg = "";
	int a, b;
	
	qmsg = b_get_option_string( xidentity, "general", "opt_misc_quit_message" );
	
	if ( qmsg == NULL || !strcmp( qmsg, "" ) )
	{
		for ( a = 0; quitMessages[a] != 0; a++ )
			;
		
		srand( time( NULL ) );
		b = rand( ) % a;
		
		return quitMessages[b];
	}
	
	return qmsg;
}

void b_server_win_destroy( CEvent *e, void *data )
{
	BServerWindow *sw = b_find_server_by_widget( e->caller );
	BChatWindow *curr, *next;
	
	if ( sw == 0 )
		return;
	
	b_server_printf( sw, "QUIT :%s", b_get_quit_message( ) );
	c_socket_close( sw->sock );
	
	// FIXME: FLUSH
	
	for ( curr = sw->chat_head; curr != 0; curr = next )
	{
		next = curr->next;
		curr->server = 0;
		c_close_widget( curr->window );
	}
	
	// patch head
	if ( sw == server_head )
		server_head = sw->next;
	
	// patch next
	if ( sw->next != 0 )
		sw->next->prev = sw->prev;
	
	// patch prev
	if ( sw->prev != 0 )
		sw->prev->next = sw->next;
	
	// patched over!
	
	// finally, get rid of the structure
	free( sw );
	
	b_taskbar_redraw( );
}

void b_chat_content_focus( CEvent *e, void *data )
{
	BChatWindow *cw = b_find_chat_by_widget( e->caller );
	
	if ( cw == 0 )
		return;
	
	c_widget_focus( cw->input );
	
	b_taskbar_redraw( );
}

void b_input_key_press( CEvent *e, int *in_keycode )
{
	int key = *in_keycode;
	BServerWindow *win;
	BTextRecall *tmp, *rpl=0;
	BTextView *content;
	
	if ( ( win = b_find_server_by_widget( e->caller->parent->parent ) ) == NULL )
	{
		if ( ( win = (BServerWindow *)b_find_chat_by_widget( e->caller->parent->parent ) ) == NULL )
			return;
		else
			content = ((BChatWindow *)win)->content;
	} else
		content = win->content;
	
	if ( key == CK_UP )
	{
		if ( win->recall_shown != 0 )
			rpl = win->recall_shown->next;
		else
			rpl = win->recall_newest;
	}
	else if ( key == CK_DOWN )
	{
		if ( win->recall_shown != 0 )
			rpl = win->recall_shown->prev;
		else
			rpl = 0;
	}
	else if ( key == CK_PAGEUP )
	{
		c_scroll_page( content->w, C_SCROLLING_VERT, -1 );
		return;
	}
	else if ( key == CK_PAGEDOWN )
	{
		c_scroll_page( content->w, C_SCROLLING_VERT, 1 );
		return;
	}
	else
		return; // we don't care
	
	// if the replacement was 0, there's nothing we can do!
	if ( rpl == 0 )
		return;
	
	// set the event to "handled", so the OS doesn't do things with the keypress
	e->proc_cancel = 1;
	
	// if we're not in recall mode, save this line as the newest TR record
	if ( win->recall_mode == 0 )
	{
		tmp = (BTextRecall *)malloc( sizeof( BTextRecall ) );
		
		tmp->input = strdup( ((CTextBoxWidgetInfo *)e->caller->info)->text );
		
		tmp->next = win->recall_newest;
		tmp->prev = 0;
		
		if ( win->recall_newest != 0 )
			win->recall_newest->prev = tmp;
		
		win->recall_newest = tmp;
		
		win->recall_mode = 1;
	}
	
	// replace input text with replacement
	c_text_settext( e->caller, rpl->input );
	c_text_setsel( e->caller, strlen( rpl->input ), strlen( rpl->input ) );
	
	// remember where we are
	win->recall_shown = rpl;
	
	if ( rpl == win->recall_newest )
	{
		// re've moved back to the beginning. exit recall mode!
		tmp = rpl->next;
		free( rpl->input );
		free( rpl );
		tmp->prev = 0;
		
		win->recall_newest = tmp;
		
		win->recall_mode = 0;
		win->recall_shown = 0;
	}
}

void b_handle_enter_recall( CWidget *input, BServerWindow *win )
{
	BTextRecall *tr;
	
	if ( win->recall_mode == 1 )
	{
		// we are in recall mode, so re-use the saved input TR record instead
		tr = win->recall_newest;
		
		// free old text
		free( tr->input );
	}
	else
	{
		tr = (BTextRecall *)malloc( sizeof( BTextRecall ) );
		
		tr->next = win->recall_newest;
		tr->prev = 0;
		
		if ( win->recall_newest != 0 )
			win->recall_newest->prev = tr;
		
		win->recall_newest = tr;
	}
	
	// get out of recall mode
	win->recall_mode = 0;
	win->recall_shown = 0;
	
	tr->input = strdup( ((CTextBoxWidgetInfo *)input->info)->text );
}

void b_server_enter_press( CEvent *e, void *data )
{
	BServerWindow *win;
	
	e->proc_cancel = 1;
	
	if ( !strcmp( ((CTextBoxWidgetInfo *)e->caller->info)->text, "" ) )
		return;
	
	if ( ( win = b_find_server_by_widget( e->caller->parent->parent ) ) == NULL )
		return;
	
	//c_btv_addline( win->content, ((CTextBoxWidgetInfo *)e->caller->info)->text, 0, BTV_ClientWelcome );
	
	if ( b_user_command( win, ((CTextBoxWidgetInfo *)e->caller->info)->text, 0 ) <= 0 )
		return;
	
	b_handle_enter_recall( e->caller, win );
	
	c_text_settext( e->caller, "" );
	//c_send_event( win->content->w, C_EVENT_PREDRAW, 0 );
}

void b_chat_enter_press( CEvent *e, void *data )
{
	BChatWindow *win;
	
	e->proc_cancel = 1;
	
	if ( !strcmp( ((CTextBoxWidgetInfo *)e->caller->info)->text, "" ) )
		return;
	
	if ( ( win = b_find_chat_by_widget( e->caller->parent->parent ) ) == NULL )
		return;
	
	//c_btv_addline( win->content, ((CTextBoxWidgetInfo *)e->caller->info)->text, 0, BTV_ClientWelcome );
	
	if ( b_user_command( win, ((CTextBoxWidgetInfo *)e->caller->info)->text, 1 ) <= 0 )
		return;
	
	b_handle_enter_recall( e->caller, (BServerWindow *)win );
	
	c_text_settext( e->caller, "" );
	//c_send_event( win->content->w, C_EVENT_PREDRAW, 0 );
}

void b_chat_win_destroy( CEvent *e, void *data )
{
	BChatWindow /**cwin, *cnext, */*deadwin;
	BServerWindow *server;
	
	deadwin = b_find_chat_by_widget( e->caller );
	
	if ( deadwin == 0 )
		return;

	// find server
	server = (BServerWindow *)deadwin->server;

	// remove from list?
	if ( server != 0 )
	{
		// patch head
		if ( deadwin == server->chat_head )
			server->chat_head = deadwin->next;
		
		// patch next
		if ( deadwin->next != 0 )
			deadwin->next->prev = deadwin->prev;
		
		// patch prev
		if ( deadwin->prev != 0 )
			deadwin->prev->next = deadwin->next;
		
		// patched over!
	
		// are we a channel?
		if ( deadwin->type == B_CMD_WINDOW_CHANNEL )
		{
			// are we already parted?
			if ( deadwin->parted == 0 )
			{
				// part
				b_server_printf( server, "PART %s", deadwin->dest );
			}
		}
	}
	
	// finally, get rid of the structure
	free( deadwin );
	
	b_taskbar_redraw( );
}

void b_register_command( char *command, void *function, int flags )
{
	BUserCommand *cmd;
	
	cmd = (BUserCommand *)malloc( sizeof( BUserCommand ) );
	
	memset( cmd, 0, sizeof( BUserCommand ) );
	
	cmd->prev = 0;
	cmd->next = ucmd_head;
	
	if ( ucmd_head != 0 )
		ucmd_head->prev = cmd;
	
	ucmd_head = cmd;
	
	strncpy( cmd->command, command, 256 );
	cmd->function = function;
	cmd->flags = flags;
}

void b_register_message( char *command, void *function, int flags )
{
	BUserCommand *cmd;
	
	cmd = (BUserCommand *)malloc( sizeof( BUserCommand ) );
	
	memset( cmd, 0, sizeof( BUserCommand ) );
	
	cmd->prev = 0;
	cmd->next = scmd_head;
	
	if ( scmd_head != 0 )
		scmd_head->prev = cmd;
	
	scmd_head = cmd;
	
	strncpy( cmd->command, command, 256 );
	cmd->function = function;
	cmd->flags = flags;
}

void b_run_command( BServerWindow *server, char *origcmd, char *command, char **params, int pcount, int flags, void *window )
{
	BUserCommand *cmd;
	int a = 0, b;
	char *c;
	char *ca;
	
	for ( cmd = ucmd_head; cmd != 0; cmd = cmd->next )
	{
		if ( server == 0 && !( cmd->flags & B_CMD_WINDOW_NONE ) )
			continue;
		
		if ( ( server == 0 || server->connected == 0 ) && !( cmd->flags & B_CMD_CLIENTONLY ) )
			continue; // Command requires server connection!
		
		if ( !strcasecmp( command, cmd->command ) )
		{
			if ( ( b = ((*cmd->function)( server, origcmd, command, params, pcount, flags, window )) ) == 1 )
				return;
			
			if ( b < 0 )
			{
				if ( b == -1 )
					c = lang_phrase_quick( "command_insparms" );
				else if ( b == -2 )
					c = lang_phrase_quick( "command_fewparms" );
				else if ( b == -3 )
					c = lang_phrase_quick( "command_invparmc" );
				else
					c = lang_phrase_quick( "command_invparms" );
				
				ca = (char *)malloc( strlen( c ) + strlen( command ) + 5 );
				
				if ( server != 0 )
				{
					sprintf( ca, "/%s: %s", command, c );
					c_btv_addline( server->content, ca, 0, BTV_Error );
				}
				
				free( ca );
			}
			
			a++;
		}
	}

	if ( a == 0 && server != 0 )
	{
		// no such command
		//c_btv_addline( server->content, "No such command", 0, BTV_Error );
		if ( server->connected == 0 )
		{
			b_window_printf( window, BTV_Info, lang_phrase_quick( "bad_command" ) );
		}
		else
			b_cmd_default( server, origcmd, command, params, pcount, flags, window );
	}
}

void b_run_message( BServerWindow *server, char *origcmd, char *command, char **params, int pcount, int flags, void *window )
{
	BUserCommand *cmd;
	int a = 0, b;
/*	char *c;
	char *ca;*/
	char *tmp;
	
	for ( cmd = scmd_head; cmd != 0; cmd = cmd->next )
	{
		if ( !strcasecmp( command, cmd->command ) )
		{
			if ( ( b = ((*cmd->function)( server, origcmd, command, params, pcount, flags, window )) ) == 1 )
				return;
			
			if ( b == 0 )
				a++;
		}
	}

	if ( a == 0 )
	{
		// We don't understand this message! No commands could make sense of it!
		b = strlen( origcmd ) + strlen( command ) + 64;
		
		tmp = (char *)malloc( b );
		
		sprintf( tmp, "[DEBUG] Unhandled message: %s \002[\002 %s \002]\002", command, origcmd );
		
		c_btv_addline( server->content, tmp, 0, BTV_Error );
		
		free( tmp );
	}
}

void b_init_commands( )
{
	/*** Commands ***/
	
	// I'm really lazy sometimes.. I created some shorter commands,
	// then started mistyping them, so I added the others too.
	b_register_command( "server", &b_cmd_server, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "nserver", &b_cmd_server, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "svr", &b_cmd_server, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "nsvr", &b_cmd_server, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "srv", &b_cmd_server, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "nsrv", &b_cmd_server, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	
	b_register_command( "raw", &b_cmd_raw, B_CMD_WINDOW_ALL );
	b_register_command( "quote", &b_cmd_raw, B_CMD_WINDOW_ALL );
	
	b_register_command( "ctcp", &b_cmd_ctcp, B_CMD_WINDOW_ALL );
	b_register_command( "dcc", &b_cmd_dcc, B_CMD_WINDOW_ALL );
	
	b_register_command( "dns", &b_cmd_dns, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	
	b_register_command( "quit", &b_cmd_quit, B_CMD_WINDOW_ALL );
	b_register_command( "join", &b_cmd_join, B_CMD_WINDOW_ALL );
	b_register_command( "j", &b_cmd_join, B_CMD_WINDOW_ALL );
	b_register_command( "part", &b_cmd_part, B_CMD_WINDOW_ALL );
	b_register_command( "p", &b_cmd_part, B_CMD_WINDOW_ALL );
	b_register_command( "nick", &b_cmd_nick, B_CMD_WINDOW_ALL );
	b_register_command( "msg", &b_cmd_privmsg, B_CMD_WINDOW_ALL );
	b_register_command( "action", &b_cmd_action, B_CMD_WINDOW_ALL );
	b_register_command( "me", &b_cmd_me, B_CMD_WINDOW_CHAT );
	
	
	b_register_command( "kick", &b_cmd_kick, B_CMD_WINDOW_CHANNEL );
	
	b_register_command( "op", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	b_register_command( "deop", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	b_register_command( "vop", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	b_register_command( "devop", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	b_register_command( "voice", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	b_register_command( "devoice", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	b_register_command( "hop", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	b_register_command( "dehop", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	b_register_command( "halfop", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	b_register_command( "dehalfop", &b_cmd_quickmode, B_CMD_WINDOW_ALL );
	
	b_register_command( "cycle", &b_cmd_cycle, B_CMD_WINDOW_CHANNEL );
	b_register_command( "chanstats", &b_cmd_chanstats, B_CMD_WINDOW_CHANNEL );
	
	b_register_command( "query", &b_cmd_query, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	
	b_register_command( "clear", &b_cmd_clear, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "close", &b_cmd_close, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	
	b_register_command( "topic", &b_cmd_topic, B_CMD_WINDOW_ALL );
	
	b_register_command( "about", &b_cmd_about, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "exit", &b_cmd_exit, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "newstatus", &b_cmd_newstatus, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "profile", &b_cmd_profile, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "netbrowse", &b_cmd_netbrowse, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "go", &b_cmd_go, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "gourl", &b_cmd_go, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "connectwin", &b_cmd_connectwin, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "joinwin", &b_cmd_joinwin, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "tile", &b_cmd_tile, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "casc", &b_cmd_casc, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "cascade", &b_cmd_casc, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "options", &b_cmd_options, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "comefg", &b_cmd_comefg, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "dccwin", &b_cmd_dccwin, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "savetext", &b_cmd_savetext, B_CMD_WINDOW_ALL | B_CMD_CLIENTONLY );
	b_register_command( "urlwin", &b_cmd_urlwin, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	b_register_command( "autowin", &b_cmd_autowin, B_CMD_WINDOW_ALL | B_CMD_WINDOW_NONE | B_CMD_CLIENTONLY );
	
	b_register_command( "operwall", &b_msg_operwall, B_CMD_WINDOW_ALL );
	
	/*** Messages ***/
	
	b_register_message( "ping", &b_msg_ping, 0 );
	b_register_message( "privmsg", &b_msg_privmsg, 0 );
	b_register_message( "notice", &b_msg_notice, 0 );
	b_register_message( "mode", &b_msg_mode, 0 );
	b_register_message( "join", &b_msg_join, 0 );
	b_register_message( "part", &b_msg_part, 0 );
	b_register_message( "quit", &b_msg_quit, 0 );
	b_register_message( "kick", &b_msg_kick, 0 );
	b_register_message( "nick", &b_msg_nick, 0 );
	b_register_message( "topic", &b_msg_topic_change, 0 );
	b_register_message( "error", &b_msg_error, 0 );
	
	b_register_message( "invite", &b_msg_invite, 0 );
	b_register_message( "wallops", &b_msg_wallops, 0 );
	
	// numerics
	b_register_message( "001", &b_msg_welcome, 0 );
	b_register_message( "001", &b_msg_connected, 0 );
	b_register_message( "002", &b_msg_welcome, 0 );
	b_register_message( "003", &b_msg_welcome, 0 );
	b_register_message( "004", &b_msg_welcome, 0 );
	b_register_message( "004", &b_msg_uphost, 0 );
	b_register_message( "005", &b_msg_checkprefix, 0 );
	b_register_message( "005", &b_msg_welcome, 0 );
	b_register_message( "006", &b_msg_welcome, 0 );
	b_register_message( "007", &b_msg_welcome, 0 );
	b_register_message( "008", &b_msg_welcome, 0 );
	
	// end of *
	b_register_message( "015", &b_msg_writeparm1, 0 );
	b_register_message( "017", &b_msg_writeparm1, 0 );
			
	// 200: RPL_TRACELINK "Link <version & debug level> <destination> <next server>"
	// 201: RPL_TRACECONNECTING "Try. <class> <server>"
	// 202: RPL_TRACEHANDSHAKE "H.S. <class> <server>"
	// 203: RPL_TRACEUNKNOWN "???? <class> [<client IP address in dot form>]"
	// 204: RPL_TRACEOPERATOR "Oper <class> <nick>"
	// 205: RPL_TRACEUSER "User <class> <nick>"
	// 206: RPL_TRACESERVER "Serv <class> <int>S <int>C <server> <nick!user|*!*>@<host|server>"
	// -
	// 208: RPL_TRACENEWTYPE "<newtype> 0 <client name>"
	// 209: RPL_TRACECLASS - RESERVED
	// -
	// 210: ??
	b_register_message( "210", &b_msg_writeparm1, 0 );
	// 211: RPL_STATSLINKINFO "<linkname> <sendq> <sent messages> <sent bytes> \ 
	//                         <received messages> <received bytes> <time open>"
	// 212: RPL_STATSCOMMANDS "<command> <count>"
	// 213: RPL_STATSCLINE "C <host> * <name> <port> <class>"
	// 214: RPL_STATSNLINE "N <host> * <name> <port> <class>"
	// 215: RPL_STATSILINE "I <host> * <host> <port> <class>"
	// 216: RPL_STATSKLINE "K <host> * <username> <port> <class>"
	// 217: RPL_STATSQLINE - RESERVED
	// -
	// 218: RPL_STATSYLINE "Y <class> <ping frequency> <connect frequency> <max sendq>"
	// 219: RPL_ENDOFSTATS "<stats letter> :End of /STATS report"
	b_register_message( "219", &b_msg_writeparm2, 0 );
	// -
	// 221: RPL_UMODEIS "<user mode string>"
	// -
	// 231: RPL_SERVICEINFO - RESERVED
	// 232: RPL_ENDOFSERVICES - RESERVED
	// 233: RPL_SERVICE - RESERVED
	// 234: RPL_SERVLIST - RESERVED
	// 235: RPL_SERVLISTEND - RESERVED
	// -
	// 241: RPL_STATSLLINE "L <hostmask> * <servername> <maxdepth>"
	// 242: RPL_STATSUPTIME ":Server Up %d days %d:%02d:%02d"
	b_register_message( "242", &b_msg_writeparm1, 0 );
	// 243: RPL_STATSOLINE "O <hostmask> * <name>"
	// 244: RPL_STATSHLINE "H <hostmask> * <servername>"
	// -
	// 250: ??
	b_register_message( "250", &b_msg_writeparm1, 0 );
	// 251: RPL_LUSERCLIENT ":There are <integer> users and <integer> invisible on <integer> servers"
	b_register_message( "251", &b_msg_welcome, 0 );
	// 252: RPL_LUSEROP "<integer> :operator(s) online"
	b_register_message( "252", &b_msg_welcome, 0 );
	// 253: RPL_LUSERUNKNOWN "<integer> :unknown connection(s)"
	// 254: RPL_LUSERCHANNELS "<integer> :channels formed"
	b_register_message( "254", &b_msg_welcome, 0 );
	// 255: RPL_LUSERME ":I have <integer> clients and <integer> servers"
	b_register_message( "255", &b_msg_welcome, 0 );
	// 256: RPL_ADMINME "<server> :Administrative info"
	// 257: RPL_ADMINLOC1 ":<admin info>"
	// 258: RPL_ADMINLOC2 ":<admin info>"
	// 259: RPL_ADMINEMAIL ":<admin info>"
	// -
	// 261: RPL_TRACELOG "File <logfile> <debug level>"
	// -
	// ??
	b_register_message( "265", &b_msg_welcome, 0 );
	// ??
	b_register_message( "266", &b_msg_welcome, 0 );
	// -
	// 290: ??
	b_register_message( "290", &b_msg_writeparm1, 0 );
	// -
	// 292: ??
	b_register_message( "292", &b_msg_writeparm1, 0 );
	// -
	// 294: ??
	b_register_message( "294", &b_msg_writeparm1, 0 );
	
	// ---
	
	// 300: Dummy reply number. Not used.
	// 301: RPL_AWAY
	b_register_message( "301", &b_msg_uaway, 0 );
	// 302: RPL_USERHOST
	b_register_message( "302", &b_msg_userhost, 0 );
	// 303: RPL_ISON
	// -
	// 305: You are no longer marked as being away
	b_register_message( "305", &b_msg_away, 0 ); // FIXME: language
	// 306: You have been marked as being away
	b_register_message( "306", &b_msg_away, 0 ); // FIXME: language
	// 307: ??
	b_register_message( "307", &b_msg_whois_is, 0 );
	// -
	// 310: ??
	b_register_message( "310", &b_msg_whois_is, 0 );
	// 311: RPL_WHOISUSER "<nick> <user> <host> * :<real name>"
	b_register_message( "311", &b_msg_whois_311, 0 );
	// 312: RPL_WHOISSERVER "<nick> <server> :<server info>"
	b_register_message( "312", &b_msg_whois_312, 0 );
	// 313: RPL_WHOISOPERATOR "<nick> :is an IRC operator"
	b_register_message( "313", &b_msg_whois_is, 0 );
	// 314: RPL_WHOWASUSER "<nick> <user> <host> * :<real name>"
	b_register_message( "314", &b_msg_whois_314, 0 );
	// -
	// 315: RPL_ENDOFWHO "<name> :End of /WHO list"
	// 316: RPL_WHOISCHANOP - RESERVED
	// 317: RPL_WHOISIDLE "<nick> <integer> :seconds idle"
	b_register_message( "317", &b_msg_whois_317, 0 );
	// 318: RPL_ENDOFWHOIS "<nick> :End of /WHOIS list"
	b_register_message( "318", &b_msg_null, 0 );
	// 319: RPL_WHOISCHANNELS "<nick> :{[@|+]<channel><space>}"
	b_register_message( "319", &b_msg_whois_319, 0 );
	// 320: ??
	b_register_message( "320", &b_msg_whois_is, 0 );
	// -
	// 321: RPL_LISTSTART "Channel :Users  Name"
	// 322: RPL_LIST "<channel> <# visible> :<topic>"
	// 323: RPL_LISTEND ":End of /LIST"
	// 324: RPL_CHANNELMODEIS "<channel> <mode> <mode params>"
	b_register_message( "324", &b_msg_chanmodeis, 0 );
	// -
	// 328: ??
	b_register_message( "328", &b_msg_chanurl, 0 );
	// 329: ??
	b_register_message( "329", &b_msg_createtime, 0 );
	// 330: ??
	b_register_message( "330", &b_msg_whois_330, 0 );
	// 331: RPL_NOTOPIC "<channel> :No topic is set"
	b_register_message( "331", &b_msg_notopic, 0 );
	// 332: RPL_TOPIC "<channel> :<topic>"
	b_register_message( "332", &b_msg_topic, 0 );
	// 333: ??
	b_register_message( "333", &b_msg_topicset, 0 );
	// -
	// 338: ??
	b_register_message( "338", &b_msg_whois_338, 0 );
	// -
	// 341: RPL_INVITING "<channel> <nick>"
	b_register_message( "341", &b_msg_invite_341, 0 );
	// 342: RPL_SUMMONING "<user> :Summoning user to IRC"
	// -
	// 351: RPL_VERSION "<version>.<debuglevel> <server> :<comments>"
	// 352: RPL_WHOREPLY "<channel> <user> <host> <server> <nick> <H|G>[*][@|+] :<hopcount> <real name>"
	// 353: RPL_NAMREPLY "<channel> :[[@|+]<nick> [[@|+]<nick> [...]]]"
	b_register_message( "353", &b_msg_channames, 0 );
	// -
	// 361: RPL_KILLDONE - RESERVED
	// 362: RPL_CLOSING - RESERVED
	// 363: RPL_CLOSEEND - RESERVED
	// 364: RPL_LINKS "<mask> <server> :<hopcount> <server info>"
	// 365: RPL_ENDOFLINKS "<mask> :End of /LINKS list"
	// 366: RPL_ENDOFNAMES "<channel> :End of /NAMES list"
	b_register_message( "366", &b_msg_channames_end, 0 );
	// 367: RPL_BANLIST "<channel> <banid>"
	// 368: RPL_ENDOFBANLIST "<channel> :End of channel ban list"
	// 369: RPL_ENDOFWHOWAS "<nick> :End of WHOWAS"
	b_register_message( "369", &b_msg_writeparm2, 0 );
	// 371: RPL_INFO ":<string>"
	// 372: RPL_MOTD ":- <text>"
	b_register_message( "372", &b_msg_motd, 0 );
	// 373: RPL_INFOSTART - RESERVED
	// 374: RPL_ENDOFINFO ":End of /INFO list"
	// 375: RPL_MOTDSTART ":- <server> Message of the day - "
	b_register_message( "375", &b_msg_motd, 0 );
	// 376: RPL_ENDOFMOTD ":End of /MOTD command"
	b_register_message( "376", &b_msg_motd, 0 );
	// -
	// 378: ??
	b_register_message( "378", &b_msg_whois_is, 0 );
	// 379: ??
	b_register_message( "379", &b_msg_whois_is, 0 );
	// -
	// 381: RPL_YOUREOPER ":You are now an IRC operator"
	b_register_message( "381", &b_msg_writeparm1, 0 );
	// 382: RPL_REHASHING "<config file> :Rehashing"
	// -
	// 384: RPL_MYPORTIS - RESERVED
	// -
	// 391: RPL_TIME "<server> :<string showing server's local time>"
	b_register_message( "391", &b_msg_time, 0 );
	// 392: RPL_USERSSTART ":UserID   Terminal  Host"
	// 393: RPL_USERS ":%-8s %-9s %-8s"
	// 394: RPL_ENDOFUSERS ":End of users"
	// 395: RPL_NOUSERS ":Nobody logged in"

	// ---

	// 401: no such nick
	b_register_message( "401", &b_msg_stderror, 0 );
	// 402: no such server
	b_register_message( "402", &b_msg_stderror, 0 );
	// 403: no such channel
	b_register_message( "403", &b_msg_stderror, 0 );
	// 404: cannot send to channel
	b_register_message( "404", &b_msg_stderror, 0 );
	// 405: too many channels
	b_register_message( "405", &b_msg_stderror, 0 );
	// 406: there was no such nickname
	b_register_message( "406", &b_msg_stderror, 0 );
	// 407: too many targets
	b_register_message( "407", &b_msg_stderror, 0 );
	// -
	// 409: No origin specified
	// -
	// 411: No recipient given (<command>)
	// 412: No text to send
	// 413: <mask> :No toplevel domain specified
	// 414: <mask> :Wildcard in toplevel domain
	// -
	// 421: <command> :Unknown command
	b_register_message( "421", &b_msg_unknowncmd, 0 );
	// 422: MOTD File is missing
	// 423: <server> :No administrative info available
	// 424: File error doing <file op> on <file>
	// -
	// 431: No nickname given
	b_register_message( "431", &b_msg_writeparm1, 0 ); // FIXME: language
	// 432: <nick> :Erroneus nickname
	// 433: <nick> :Nickname is already in use
	b_register_message( "433", &b_msg_nickused, 0 );
	// -
	// 436: <nick> :Nickname collision KILL
	// 437: ??
	b_register_message( "437", &b_msg_stderror, 0 );
	// -
	// 441: <nick> <channel> :They aren't on that channel
	// 442: <channel> :You're not on that channel
	b_register_message( "442", &b_msg_stderror, 0 );
	// 443: <user> <channel> :is already on channel
	// 444: <user> :User not logged in
	// 445: SUMMON has been disabled
	// 446: USERS has been disabled
	// -
	// 451: You have not registered
	// -
	// 461: <command> :Not enough parameters
	// 462: You may not reregister
	// 463: Your host isn't among the privileged
	// 464: Password incorrect
	// 465: You are banned from this server
	// 466: ERR_YOUWILLBEBANNED - RESERVED
	// 467: <channel> :Channel key already set
	// -
	// 471: <channel> :Cannot join channel (+l)
	b_register_message( "471", &b_msg_stderror, 0 );
	// 472: <char> :is unknown mode char to me
	// 473: <channel> :Cannot join channel (+i)
	b_register_message( "473", &b_msg_stderror, 0 );
	// 474: <channel> :Cannot join channel (+b)
	b_register_message( "474", &b_msg_stderror, 0 );
	// 475: <channel> :Cannot join channel (+k)
	b_register_message( "475", &b_msg_stderror, 0 );
	// 476: ERR_BADCHANMASK - RESERVED
	// -
	// 481: Permission Denied- You're not an IRC operator
	b_register_message( "481", &b_msg_writeparm1, 0 );
	// 482: <channel> :You're not channel operator
	b_register_message( "482", &b_msg_stderror, 0 );
	// 483: You cant kill a server!
	// -
	// 491: No O-lines for your host
	// 492: ERR_NOSERVICEHOST - RESERVED
	// -
	// 499: ??
	b_register_message( "499", &b_msg_writeparm2toactive, 0 );
	// -
	// 501: Unknown MODE flag
	// 502: Cant change mode for other users
}

void b_server_update_title( BServerWindow *server )
{
	char buf[1024];
	
	if ( server->connected == 0 )
		sprintf( buf, lang_phrase_quick( "status_title_idle" ) );
	else
		lang_phrase_parse( buf, 1024, "status_title_conn", "nick", server->nickname, "mode", server->umode, "server", server->servername, 0 );
	
	c_window_settitle( server->window, buf );
	b_taskbar_redraw( );
}

void b_chat_update_title( BChatWindow *cw )
{
	char buf[1024];
	int users = 0;
	char modes[256];
	char modev[256];
	char tmp[2];
	int a;
	ClaroTableCell *cell;
	
	strcpy( buf, cw->dest );
	
	if ( cw->type == B_CMD_WINDOW_CHANNEL )
	{
		users = cw->users_table->rows;
		
		strcpy( modes, "" );
		strcpy( modev, "" );
		
		for ( a = 0; a < cw->channel_modes->rows; a++ )
		{
			cell = c_tbl_get_cell( cw->channel_modes, a, 0 );
			strcat( modes, cell->data );
			
			cell = c_tbl_get_cell( cw->channel_modes, a, 1 );
			if ( cell->data != 0 && strcmp( cell->data, "" ) )
			{
				strcat( modev, " " );
				strcat( modev, cell->data );
			}
		}
		
		sprintf( buf, "%s [%d] [+%s%s]: %s", cw->dest, users, modes, modev, cw->topic );
	}
	
	c_window_settitle( cw->window, buf );
	b_taskbar_redraw( );
}

char b_find_user_prefix( BUserStore *st );
int b_find_table_row_position( ClaroTable *tbl, BUserStore *st );

void b_userstore_updated( BChatWindow *win, BUserStore *user, int relocate )
{
	char *data;
	int newpos;
	
	data = malloc( 1 + strlen( user->nickname ) + 1 );
		
	strcpy( data, "" );
		
	if ( b_find_user_prefix( user ) != 0 )
		sprintf( data, "%c", b_find_user_prefix( user ) );
		
	strcat( data, user->nickname );
	
	c_tbl_set_cell_data( win->users_table, user->row->pos, 0, data, 1 );
	
	if ( relocate == 1 )
	{
		newpos = b_find_table_row_position( win->users_table, user );
		c_tbl_move_row( win->users_table, user->row->pos, newpos );
	}
}

void b_chat_user_add( BChatWindow *win, BUserStore *user )
{
	BUserStore *nuser;
	ClaroTableRow *row;
	//ClaroTableCell *cell;
	
	if ( !( nuser = (BUserStore *)malloc( sizeof(BUserStore) ) ) )
		return;
	
	memcpy( nuser, user, sizeof(BUserStore) );
	
	nuser->next = nuser->prev = 0;
	
	if ( win->users == 0 )
	{
		win->users = nuser;
	}
	else
	{
		win->users->prev = nuser;
		nuser->next = win->users;
		win->users = nuser;
	}
	
	// add to users table
		
	row = c_tbl_insert_row( win->users_table, b_find_table_row_position( win->users_table, nuser ) );
	//cell = c_tbl_get_cell( win->users_table, row->pos, 0 );
	
	nuser->row = row;
	b_userstore_updated( win, nuser, 0 );
}

void b_chat_user_del( BChatWindow *win, char *nick )
{
	BUserStore *curr;
	
	for ( curr = win->users; curr != 0; curr = curr->next )
	{
		if ( !strcasecmp( nick, curr->nickname ) )
		{
			if ( curr == win->users )
			{
				win->users = curr->next;
			}
			else
			{
				curr->prev->next = curr->next;
			}
			
			if ( curr->next != 0 )
			{
				curr->next->prev = curr->prev;
			}
			
			c_tbl_delete_row( win->users_table, curr->row->pos );
			
			free( curr );
			return;
		}
	}
}

void b_chat_user_empty( BChatWindow *win )
{
	BUserStore *curr, *next;
	
	for ( curr = win->users; curr != 0; curr = next )
	{
		next = curr->next;
		
		free( curr );
	}
	
	win->users = 0;
	
	c_tbl_empty( win->users_table );
}

BUserStore *b_chat_user_find_nick( BChatWindow *win, char *nick )
{
	BUserStore *curr;
	
	for ( curr = win->users; curr != 0; curr = curr->next )
	{
		if ( !strcasecmp( nick, curr->nickname ) )
		{
			return curr;
		}
	}
	
	return 0;
}

int b_user_command( void *inwin, char *cmdi, int fromtype )
{
	char *cmd, *cmdo, *cmdb, *tmp;
	char *tok;
	char command[256];
	char **params = 0;
	int a, b;
	BServerWindow *win;
	BChatWindow *cwin;
	
	if ( fromtype == 0 )
	{
		cwin = (BChatWindow *)inwin;
		win = (BServerWindow *)inwin;
	}
	else if ( fromtype == 1 ) // chat window
	{
		cwin = (BChatWindow *)inwin;
		win = (BServerWindow *)cwin->server;
	}
	else
	{
		cwin = 0;
		win = 0;
	}
	
	cmdo = cmd = (char *)malloc( strlen( cmdi ) + 1 );
	strcpy( cmd, cmdi );
	cmdb = (char *)malloc( strlen( cmdi ) + 1 );
	strcpy( cmdb, cmdi );
	
	tok = strtok( cmd, " " );
	
	if ( tok != NULL )
	{
		if ( tok[0] == '/' && tok[1] != '/' )
		{
			tok++;
			
			// command
			strncpy( command, tok, 256 );
			
			a = 0;
			
			// parse params
			while ( ( tok = strtok( NULL, " " ) ) != NULL )
			{
				// increment number of pointers
				a++;
				
				params = (char **)realloc( params, sizeof( char * ) * a );
				
				params[a-1] = (char *)malloc( strlen( tok ) + 1 );
				strcpy( params[a-1], tok );
			}
			
			// run it
			b_run_command( win, cmdb, command, params, a, fromtype, cwin );
			
			// clear memory
			for ( b = 0; b < a; b++ )
			{
				free( params[b] );
			}
			
			if ( params != 0 )
				free( params );
		}
		else
		{
			if ( fromtype == 1 )
			{
				tmp = cmdb;
				
				if ( tok[0] == '/' && tok[1] == '/' )
					tmp++;
				
				if ( win->connected == 1 )
				{
					if ( cwin->parted == 1 )
					{
						b_chatwin_printf( cwin, BTV_Info, lang_phrase_quick( "not_in_channel" ) );
					}
					else
					{
						b_server_printf( win, "PRIVMSG %s :%s", cwin->dest, tmp );
						b_chatwin_printf( cwin, BTV_Message, "<%s> %s", win->nickname, tmp );
					}
				}
				else
				{
					b_chatwin_printf( cwin, BTV_Info, lang_phrase_quick( "not_connected" ) );
					free( cmdo );
					free( cmdb );
					return 1;
				}
			}
		}
	}
	
	free( cmdo );
	free( cmdb );
	
	return 1;
}

void b_server_message( BServerWindow *win, char *cmdi )
{
	char *cmd, *cmdo, *cmdb;
	char *tok, *tok2;
	char command[256];
	char **params = 0;
	char **paramsbak = 0;
	int a, b, c, d;
	BUserMask *sender;
	
	cmdo = cmd = (char *)malloc( strlen( cmdi ) + 1 );
	strcpy( cmd, cmdi );
	cmdb = (char *)malloc( strlen( cmdi ) + 1 );
	strcpy( cmdb, cmdi );
	
	tok = strtok( cmd, " " );
	
	c = 0;
	sender = 0;
	
	//printf( "%s\n", cmdb );
	
	if ( tok != NULL )
	{
		if ( tok[0] == ':' )
		{
			tok2 = strtok( NULL, " " );
			
			if ( tok2 != NULL )
			{
				c = 1;
				
				sender = (BUserMask *)malloc( sizeof( BUserMask ) );
				memset( sender, 0, sizeof( BUserMask ) );
				
				sscanf( tok + 1, "%[^!]!%[^@]@%s", sender->nickname, sender->username, sender->hostname );
				
				tok = tok2;
			}
		}
		
		// command
		strncpy( command, tok, 256 );
		
		a = 0;
		d = 0;
		
		// parse params
		while ( ( tok = strtok( NULL, " " ) ) != NULL )
		{
			if ( d == 0 )
			{
				if ( tok[0] == ':' )
				{
					d = 1;
					tok++;
				}
				
				// increment number of pointers
				a++;
				
				params = (char **)realloc( params, sizeof( char * ) * a );
				
				if ( d == 0 ) {
					params[a-1] = (char *)malloc( strlen( tok ) + 1 );
					strcpy( params[a-1], tok );
				} else {
					params[a-1] = (char *)malloc( strlen( cmdi + (tok-cmd) ) + 1 );
					strcpy( params[a-1], cmdi + (tok-cmd) );
					
					break; //end
				}
			}
		}
		
		paramsbak = (char **)malloc( sizeof( char * ) * a );
		memcpy( paramsbak, params, sizeof( char * ) * a );
		
		// run it
		b_run_message( win, cmdb, command, params, a, c << 12, sender );
		
		// clear memory
		if ( sender != 0 )
			free( sender );
		
		for ( b = 0; b < a; b++ )
		{
			free( paramsbak[b] );
		}
		
		if ( params != 0 )
			free( params );
		if ( paramsbak != 0 )
			free( paramsbak );
	}
	
	free( cmdo );
	free( cmdb );
}

void b_servers_run( )
{
	BServerWindow *win, *next;
	int a;
	char buf[1024];
	
	for ( win = server_head; win != 0; win = next )
	{
		next = win->next;
		
		if ( win->sock->status != C_SOCK_CONNECTED )
			continue;
		
		a = c_socket_numlines( win->sock );
	
		for ( ; a > 0; a-- )
		{
			c_socket_readline( win->sock, buf, 1024 );
			//c_btv_addline( win->content, buf, 0, BTV_ConnectionMsg );
			b_server_message( win, buf );
		}
	}
}

int b_server_printf( BServerWindow *server, char *fmt, ... )
{
	va_list args;
	char buf[16384];
	
	va_start( args, fmt );
	vsprintf( buf, fmt, args );
	va_end( args );
	
	c_socket_printf( server->sock, "%s\r\n", buf );
	
	return 1;
}

extern CWidget *mainwin;

int b_swindow_printf( BServerWindow *server, int colour, char *fmt, ... )
{
	va_list args;
	char buf[16384];
	int of;
	
	va_start( args, fmt );
	vsprintf( buf, fmt, args );
	va_end( args );
	
	c_btv_addline( server->content, buf, 0, colour );
	
	of = server->taskbar_flags;
	
	if ( colour == BTV_Message || colour == BTV_Action )
	{
		if ( b_get_option_bool( xidentity, "general", "opt_gen_flash_on_message" ) )
		{
			c_window_flash( mainwin, 0, b_get_option_int( xidentity, "general", "opt_gen_flash_times" ) );
		}
		
		server->taskbar_flags |= 4;
	}
	else
		server->taskbar_flags |= 2;
	
	if ( of != server->taskbar_flags )
		b_taskbar_redraw( );
	
	return 1;
}

int b_chatwin_printf( BChatWindow *cwin, int colour, char *fmt, ... )
{
	va_list args;
	char buf[16384];
	int of;
	
	va_start( args, fmt );
	vsprintf( buf, fmt, args );
	va_end( args );
	
	c_btv_addline( cwin->content, buf, 0, colour );
	
	
	of = cwin->taskbar_flags;
	
	if ( colour == BTV_Message || colour == BTV_Action )
	{
		if ( b_get_option_bool( xidentity, "general", "opt_gen_flash_on_message" ) )
		{
			c_window_flash( mainwin, 0, b_get_option_int( xidentity, "general", "opt_gen_flash_times" ) );
		}
		
		cwin->taskbar_flags |= 4;
	}
	else
		cwin->taskbar_flags |= 2;
	
	if ( of != cwin->taskbar_flags )
		b_taskbar_redraw( );
	
	return 1;
}

extern XMLItem *xidentity;

void b_identity_attrib( char *attrib, char *buf )
{
	char *txt;
	
	txt = c_xml_attrib_get( xidentity, attrib );
	
	if ( txt == 0 )
		return;
	
	strcpy( buf, txt );
}

void b_identity_getautonick( int num, char *buf )
{
	XMLItem *nicks;
	XMLItem *nick;
	char *nicktxt;
	char *first = "Unknown";
	int a;
	
	nicks = c_xml_find_child( xidentity, "nicks" );
	
	for ( nick = nicks->child_head, a = 0; nick != 0; nick = nick->next, a++ )
	{
		nicktxt = c_xml_attrib_get( nick, "name" );
		
		if ( a == num )
		{
			strcpy( buf, nicktxt );
			return;
		}
		
		if ( a == 0 )
			first = nicktxt;
	}
	
	sprintf( buf, "%s[%d]", first, num-a+1 );
}

/*
	c_socket_set_handler( server->sock, C_SOCK_LOOKUP, &b_handle_socket_lookup );
	c_socket_set_handler( server->sock, C_SOCK_LOOKUP_FAILED, &b_handle_socket_lookup_failed );
	c_socket_set_handler( server->sock, C_SOCK_CONNECTING, &b_handle_socket_connecting );
	c_socket_set_handler( server->sock, C_SOCK_CONNECTED, &b_handle_socket_connected );
	c_socket_set_handler( server->sock, C_SOCK_FAILED, &b_handle_socket_failed );
	c_socket_set_handler( server->sock, C_SOCK_DISCONNECTED, &b_handle_socket_disconnected );
*/

BServerWindow *b_find_server_by_sock( CSocket *sock )
{
	BServerWindow *curr;

	for ( curr = server_head; curr != 0; curr = curr->next )
	{
		if ( curr->sock == sock )
			return curr;
	}
	
	return NULL;
}

void b_handle_socket_lookup( CSocket *sock )
{
	BServerWindow *sw;
	
	if ( !( sw = b_find_server_by_sock( sock ) ) )
		return;
	
	b_swindow_printf( sw, BTV_ConnectionMsg, lang_phrase_quick( "connect_lookup" ) );
	
	sw->connected = 0;
}

void b_handle_socket_lookup_failed( CSocket *sock )
{
	BServerWindow *sw;
	
	if ( !( sw = b_find_server_by_sock( sock ) ) )
		return;
	
	b_swindow_printf( sw, BTV_ConnectionMsg, lang_phrase_quick( "connect_errorl" ) );
	
	sw->connected = 0;
}

void b_handle_socket_connecting( CSocket *sock )
{
	BServerWindow *sw;
	
	if ( !( sw = b_find_server_by_sock( sock ) ) )
		return;
	
	b_swindow_printf( sw, BTV_ConnectionMsg, lang_phrase_quick( "connect_connecting" ) );
	
	sw->connected = 0;
}

void b_handle_socket_connected( CSocket *sock )
{
	BServerWindow *sw;
	
	if ( !( sw = b_find_server_by_sock( sock ) ) )
		return;
	
	b_swindow_printf( sw, BTV_ConnectionMsg, lang_phrase_quick( "connect_connected_login" ) );
	
	sw->connected = 1;
}

void b_handle_socket_failed( CSocket *sock )
{
	BServerWindow *sw;
	
	if ( !( sw = b_find_server_by_sock( sock ) ) )
		return;
	
	b_swindow_printf( sw, BTV_ConnectionMsg, lang_phrase_quick( "connect_failed" ) );
	
	sw->connected = 0;
}

void b_handle_socket_disconnected( CSocket *sock )
{
	BServerWindow *sw;
	BChatWindow *cw;
	
	if ( !( sw = b_find_server_by_sock( sock ) ) )
		return;
	
	b_swindow_printf( sw, BTV_ConnectionMsg, lang_phrase_quick( "connect_disconnected" ) );
	
	sw->connected = 0;
	
	b_server_update_title( sw );
	
	// clear all channel userlists to be clean
	for ( cw = sw->chat_head; cw != 0; cw = cw->next )
	{
		if ( cw->type == B_CMD_WINDOW_CHANNEL )
		{
			cw->parted = 1;
			//c_listbox_clear( cw->userlist );
			c_tbl_empty( cw->users_table );
		}
	}
}

void b_server_connect( BServerWindow *server, char *hostname, int port )
{
	char username[64], realname[64];
	
	if ( server->sock->status != C_SOCK_DISCONNECTED )
		c_socket_close( server->sock );
	
	c_socket_connect( server->sock, hostname, port );
	
	strcpy( server->nickname, "" );
	
	if ( !strcasecmp( server->nickname, "" ) )
	{
		server->nickcount = 0;
		b_identity_getautonick( server->nickcount, server->nickname );
	}
	
	b_identity_attrib( "username", username );
	b_identity_attrib( "realname", realname );
	
	if ( strcmp( server->password, "" ) )
		b_server_printf( server, "PASS %s", server->password );
	b_server_printf( server, "USER %s %s %s :%s", username, "b", "c", realname );
	b_server_printf( server, "NICK %s", server->nickname );
	
	server->welcomed = 0;
	
}

void b_server_run_onconnect( BServerWindow *sw )
{
	char *item, *txt;
	BChatWindow *cw;
	
	if ( sw->welcomed == 1 )
		return;
	
	sw->welcomed = 1;
	
	b_server_printf( sw, "USERHOST :%s", sw->nickname );
	
	if ( sw->onconnect == 0 )
		return;
	
	txt = sw->onconnect;
	
	while ( ( item = strtok( txt, "," ) ) != NULL )
	{
		txt = NULL;
		
		cw = b_find_chat_by_dest( sw, item );
		
		if ( cw == 0 )
		{
			if ( item[0] == '#' || item[0] == '&' )
				b_server_printf( sw, "JOIN :%s", item );
			else
				cw = b_new_chat_window( sw, item, 0 );
		}
		
		if ( cw != 0 )
			c_widget_focus( cw->input );
	}
	
	free( sw->onconnect );
	sw->onconnect = 0;
	sw->onconnect_len = 0;
}

void b_server_onconnect_goto( BServerWindow *sw, char *place )
{
	char *prefix = "";
	int a;
	
	a = sw->onconnect_len;
	
	sw->onconnect_len += strlen( place );
	
	if ( a != 0 ) {
		sw->onconnect_len += strlen( place ) + 1;
		prefix = ",";
	}
	
	sw->onconnect = realloc( sw->onconnect, sw->onconnect_len + 1 );
	if ( a == 0 )
		strcpy( sw->onconnect, "" );
	strcat( sw->onconnect, prefix );
	strcat( sw->onconnect, place );
}

extern CWidget *workspace;

BServerWindow *b_server_find_active( )
{
	CWidget *w;
	BServerWindow *sw;
	BChatWindow *cw;
	
	w = c_workspace_get_active( workspace );
	
	if ( w == 0 )
	{
		return 0;
	}
	
	sw = b_find_server_by_widget( w );
	
	if ( sw != 0 )
		return sw;
	
	cw = b_find_chat_by_widget( w );
	
	if ( cw != 0 )
		return cw->server;
	
	return 0;
}

void b_draw_line_canvas( CEvent *e, void *data )
{
	// FIXME: Colour should be configurable, same time as everything else is :)
	c_canvas_paint_clear( e->caller, c_make_color_hex( "#D4D0C8" ) );
}

int b_fontd_by_loc_from_xml( BFontDef *font, char *loc )
{
	XMLItem *fonts;
	char *xlocn;
	char *size, *face;
	
	strcpy( font->face, "Verdana" );
	font->size = 16;
	
	fonts = c_xml_find_child( xidentity, "fonts" );
	
	if ( fonts == 0 )
		return 0;
	
	for ( fonts = fonts->child_head; fonts; fonts = fonts->next )
	{
		if ( strcasecmp( fonts->name, "font" ) )
			continue;
		
		xlocn = 0;
		xlocn = c_xml_attrib_get( fonts, "location" );
		
		if ( xlocn == 0 )
			continue;
		
		if ( !strcasecmp( xlocn, loc ) )
		{
			// got it.. fill font def
			size = c_xml_attrib_get( fonts, "size" );
			if ( size == 0 )
				size = "16";
			
			face = c_xml_attrib_get( fonts, "face" );
			if ( face == 0 )
				face = "Verdana";
			
			strcpy( font->face, face );
			font->size = atoi( size );
			
			// need more here
			
			return 1;
		}
	}
	
	return 0;
}

void b_widget_set_font( CWidget *w, char *loc )
{
	BFontDef fontd;
	CFont *cfont;
	
	if ( b_fontd_by_loc_from_xml( &fontd, loc ) == 0 )
		return;
	
	if ( ( cfont = c_font_create( fontd.face, fontd.size ) ) == 0 )
		return;
	
	c_font_bind_widget( cfont, w );
}

BServerWindow *b_find_any_by_widget( CWidget *w )
{
	BServerWindow *sw;
	
	// find server or chat, we'll only be using the shared parts
	if ( ( sw = b_find_server_by_widget( w ) ) == NULL )
	{
		if ( ( sw = (BServerWindow *)b_find_chat_by_widget( w ) ) == NULL )
			return 0;
	}
	
	return sw;
}

void b_window_minimised( CEvent *e, void *data )
{
	BServerWindow *sw = b_find_any_by_widget( e->caller );
	
	// we're minimised
	sw->window_flags |= B_WINDOW_MINIMISE;
	
	c_widget_hide( e->caller );
}

void b_window_maximised( CEvent *e, void *data )
{
	BServerWindow *sw = b_find_any_by_widget( e->caller );
	
	// we're maximised
	sw->window_flags |= B_WINDOW_MAXIMISE;
}

void b_window_restored( CEvent *e, void *data )
{
	BServerWindow *sw = b_find_any_by_widget( e->caller );
	
	// turn them both off
	sw->window_flags |= B_WINDOW_MINIMISE | B_WINDOW_MAXIMISE;
	sw->window_flags -= B_WINDOW_MINIMISE | B_WINDOW_MAXIMISE;
}

void b_window_focus( CWidget *w )
{
	BServerWindow *sw = b_find_any_by_widget( w );
	
	c_widget_show( w );
	
	if ( sw->window_flags & B_WINDOW_MINIMISE )
	{
		// no longer minimised flag
		sw->window_flags -= B_WINDOW_MINIMISE;
		
		if ( sw->window_flags & B_WINDOW_MAXIMISE )
			c_widget_maximize( w );
		else
			c_widget_restore( w );
	}
	
	c_widget_focus( w );
}

extern XMLFile *xmenu;

void b_window_create_context_menu( BServerWindow *win )
{
	int type;
	
	type = win->type;
	
	win->conmenu.menu = c_new_menubar( win->window, C_MENU_POPUP );
	
	if ( type & B_CMD_WINDOW_STATUS )
		b_menu_from_xml( xmenu, win->conmenu.menu, "context-status", 0 );
	else if ( type & B_CMD_WINDOW_CHANNEL )
		b_menu_from_xml( xmenu, win->conmenu.menu, "context-channel", 0 );
	else if ( type & B_CMD_WINDOW_QUERY )
		b_menu_from_xml( xmenu, win->conmenu.menu, "context-query", 0 );
}

void c_btv_handle_mouse_wheel( CEvent *e, void *data );

BServerWindow *b_new_server_window( int flags )
{
	BServerWindow *server;
	CWidget *content, *aligner, *line;
	
	server = (BServerWindow *)malloc( sizeof( BServerWindow ) );
	
	memset( server, 0, sizeof( BServerWindow ) );
	
	server->type = B_CMD_WINDOW_STATUS;
	
	server->prev = 0;
	server->next = server_head;
	
	if ( server_head != 0 )
		server_head->prev = server;
	
	server_head = server;
	
	server->recall_newest = 0;
	server->recall_shown = 0;
	server->recall_mode = 0;
	
	strcpy( server->servername, "unknown" );
	strcpy( server->password, "" );
	
	server->window = c_new_window( workspace, "Status", 600, 400, C_MDICHILD | C_START_MAXIMISE );
	//c_new_event_handler( server->window, C_EVENT_RESIZE, b_server_win_resize );
	c_new_event_handler( server->window, C_EVENT_DESTROY, b_server_win_destroy );
	c_new_event_handler( server->window, C_EVENT_ONFOCUS, b_server_content_focus );
	c_new_event_handler( server->window, C_EVENT_MINIMIZED, b_window_minimised );
	c_new_event_handler( server->window, C_EVENT_MAXIMIZED, b_window_maximised );
	c_new_event_handler( server->window, C_EVENT_RESTORED, b_window_restored );
	
	aligner = c_new_aligner( server->window, C_ALIGNER_VERTICAL );
	
	c_window_set_icon( server->window, c_icon_from_xpm( "themes/default/icons/status_window.xpm" ) );
	
	content = c_btv( aligner, 0, 0, 600, 400, 0 );
	server->content = btv_by_widget( content );
	c_new_event_handler( content, C_EVENT_ONFOCUS, b_server_content_focus );
	
	line = c_new_canvas( aligner, 0, 0, 1, 1, C_SCROLLING_VERT | C_BORDER_NONE );
	c_new_event_handler( line, C_EVENT_DRAW, b_draw_line_canvas );
	
	server->input = c_new_text( aligner, "", -1, -1, -1, -1, C_BORDER_NONE | C_WANT_KEYPRESS );
	c_new_event_handler( server->input, C_EVENT_TEXT_ENTER, b_server_enter_press );
	c_new_event_handler( server->input, C_EVENT_KEY_PRESS, (void (*)( CEvent *, void * ))b_input_key_press );
	c_new_event_handler( server->input, C_EVENT_MOUSE_WHEEL, c_btv_handle_mouse_wheel );
	
	c_aligner_set_stretchable_child( aligner, content );
	
	/* config fonts */
	b_widget_set_font( content, "server-buffer" );
	b_widget_set_font( server->input, "server-input" );
	
	server->sock = c_socket_create( );
	c_socket_set_handler( server->sock, C_SOCK_LOOKUP, &b_handle_socket_lookup );
	c_socket_set_handler( server->sock, C_SOCK_LOOKUP_FAILED, &b_handle_socket_lookup_failed );
	c_socket_set_handler( server->sock, C_SOCK_CONNECTING, &b_handle_socket_connecting );
	c_socket_set_handler( server->sock, C_SOCK_CONNECTED, &b_handle_socket_connected );
	c_socket_set_handler( server->sock, C_SOCK_FAILED, &b_handle_socket_failed );
	c_socket_set_handler( server->sock, C_SOCK_DISCONNECTED, &b_handle_socket_disconnected );
	
	if ( flags == 1 )
	{
		lang_phrase_parse( lang_tmp_buf, 1024, "welcome_splash", "client", "\002Bersirc " BERSIRC_VERSION "\002", 0 );
		c_btv_addline( server->content, lang_tmp_buf, 0, BTV_ClientWelcome );
	}
	
	b_taskbar_redraw( );
	
	b_window_create_context_menu( server );
	
	return server;
}

BChatWindow *b_new_chat_window( BServerWindow *server, char *dest, int flags )
{
	BChatWindow *chat;
	CWidget *content, *aligner, *haligner, *line;
	char *icon;
	
	chat = (BChatWindow *)malloc( sizeof( BChatWindow ) );
	
	memset( chat, 0, sizeof( BChatWindow ) );
	
	chat->prev = 0;
	chat->next = server->chat_head;
	chat->server = server;
	
	strncpy( chat->dest, dest, 256 );
	
	if ( server->chat_head != 0 )
		server->chat_head->prev = chat;
	
	server->chat_head = chat;
	
	chat->recall_newest = 0;
	chat->recall_shown = 0;
	chat->recall_mode = 0;
	
	chat->users_table = 0;
	
	chat->window = c_new_window( workspace, dest, 600, 400, C_MDICHILD | C_START_MAXIMISE );
	//c_new_event_handler( chat->window, C_EVENT_RESIZE, b_chat_win_resize );
	c_new_event_handler( chat->window, C_EVENT_DESTROY, b_chat_win_destroy );
	c_new_event_handler( chat->window, C_EVENT_ONFOCUS, b_chat_content_focus );
	c_new_event_handler( chat->window, C_EVENT_MINIMIZED, b_window_minimised );
	c_new_event_handler( chat->window, C_EVENT_MAXIMIZED, b_window_maximised );
	c_new_event_handler( chat->window, C_EVENT_RESTORED, b_window_restored );
	
	aligner = c_new_aligner( chat->window, C_ALIGNER_VERTICAL );
	haligner = c_new_aligner( aligner, C_ALIGNER_HORIZONTAL );
	
	content = c_btv( haligner, 0, 0, 600, 400, 0 );
	chat->content = btv_by_widget( content );
	c_new_event_handler( content, C_EVENT_ONFOCUS, b_chat_content_focus );
	
	if ( flags & 1 )
	{
		icon = "themes/default/icons/channel_window.xpm";
		chat->userlist = c_new_listbox( haligner, 0, 0, 100, 100, C_BORDER_NONE );
		chat->type = B_CMD_WINDOW_CHANNEL;
		
		chat->users_table = c_tbl_create( 2 );
		c_listbox_attach_table( chat->userlist, chat->users_table, 0 );
		
		chat->channel_modes = c_tbl_create( 2 );
	}
	else
	{
		icon = "themes/default/icons/query_window.xpm";
		chat->userlist = 0;
		chat->type = B_CMD_WINDOW_QUERY;
	}
		
	c_window_set_icon( chat->window, c_icon_from_xpm( icon ) );
	
	line = c_new_canvas( aligner, 0, 0, 1, 1, C_SCROLLING_VERT | C_BORDER_NONE );
	c_new_event_handler( line, C_EVENT_DRAW, b_draw_line_canvas );
	
	chat->input = c_new_text( aligner, "", -1, -1, -1, -1, C_BORDER_NONE | C_WANT_KEYPRESS );
	c_new_event_handler( chat->input, C_EVENT_TEXT_ENTER, b_chat_enter_press );
	c_new_event_handler( chat->input, C_EVENT_KEY_PRESS, (void (*)( CEvent *, void * ))b_input_key_press );
	c_new_event_handler( chat->input, C_EVENT_MOUSE_WHEEL, c_btv_handle_mouse_wheel );
	
	/* config fonts */
	b_widget_set_font( content, "chat-buffer" );
	b_widget_set_font( chat->input, "chat-input" );
	
	c_aligner_set_stretchable_child( aligner, haligner );
	c_aligner_set_stretchable_child( haligner, content );
	
	b_taskbar_redraw( );
	
	b_window_create_context_menu( (BServerWindow *)chat );
	
	return chat;
}

//
