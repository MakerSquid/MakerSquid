/*************************************************************************
$Id: irc_msg.c 189 2005-11-08 05:57:12Z terminal $

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

// These are the default modes/prefixes, used when a server doesn't tell us
// which modes it supports. Do not edit these. If a server leaves modes out,
// the b_irc_allsym string below should remove the prefix and the user will
// be shown as a normal (no-priv) user.
char b_irc_modes[16] = "ohv";
char b_irc_symbs[16] = "@%+";

// Any of these will be counted as a mode prefix, regardless of whether the
// server uses them as one or not. The IRC RFC specifies the first char of
// a nickname should be a letter, therefore we can assume that no nickname
// will ever start with any of these. If any IRC network uses another mode
// prefix not listed here, slap them around with a mIRC trout then add it.
//
// This is used only for stripping them off, stopping the client doing
// actions on users with their prefix included.
// 
// Any prefixes used on the server that are not in the sent PREFIX
// (or default set, above) will simply be discarded.
char b_irc_allsym[] = "!@#$%^&*()-=_+";

/** Commands returning '1' halt, '0' just continue, '-1'  invalid params **/

BERS_MESSAGE( b_msg_ping )
{
	char *reply = "Bersirc";
	
	if ( pcount >= 1 )
		reply = params[0];
	
	b_server_printf( server, "PONG :%s", reply );
	
	if ( b_get_option_bool( xidentity, "general", "opt_gen_show_ping_pong" ) == 1 )
		b_swindow_printf( server, BTV_PingPong, lang_phrase_quick( "ping_pong" ) );
	
	return 0;
}

BERS_MESSAGE( b_msg_nickused )
{
	if ( server->nickcount == -1 )
	{
		lang_phrase_parse( lang_tmp_buf, 1024, "nick_in_use", "nick", params[1], 0 );
		b_swindow_printf( server, BTV_Message, "%s", lang_tmp_buf );
		return 0;
	}
	
	server->nickcount++;
	b_identity_getautonick( server->nickcount, server->nickname );
	b_server_printf( server, "NICK %s", server->nickname );
	
	return 0;
}

int b_msg_check_ctcp( BServerWindow *server, BChatWindow *chatwin, BUserMask *user, char *msg )
{
	char *cmd, *params;
	char out[1024];
	int s = 0;
	
	if ( msg[0] == '\1' )
	{
		msg++;
		
		if ( msg[strlen(msg)-1] == '\1' )
			msg[strlen(msg)-1] = '\0';
		
		cmd = strtok( msg, " " );
		
		if ( cmd == NULL )
			return 1;
		
		params = strtok( NULL, "" );
		
		memset( out, 0, 1024 );
		if ( params == 0 )
			snprintf( out, 1023, "[%s %s]", user->nickname, cmd );
		else
			snprintf( out, 1023, "[%s %s %s]", user->nickname, cmd, params );
		
		if ( !strcasecmp( cmd, "VERSION" ) )
		{
			if ( params == 0 ) // wants ours
			{
				if ( !b_get_option_bool( xidentity, "general", "opt_misc_hide_version" ) ) // only display if we're not hiding it
					b_server_printf( server, "NOTICE %s :\1VERSION Bersirc v" BERSIRC_VERSION " on " BERSIRC_PLATFORM BERSTAG "\1", user->nickname );
			}
			else
			{
				lang_phrase_parse( out, 1024, "ctcp-reply", "user", user->nickname, "type", cmd, "response", params, 0 );
			}
			// otherwise just display the reply :)
		}
		
		if ( !strcasecmp( cmd, "DCC" ) )
		{
			params = strtok( params, " ");
			if ( !strcasecmp( params, "SEND" ) )
			{
				if ( ( params = strtok( NULL, " " ) ) != 0 )
				{
					CSocket *sock = c_socket_create( );
					sock->data = (struct DCCData*)malloc( sizeof( struct DCCData ) );
					((struct DCCData*)sock->data)->file = (char *)malloc( 256 );
					strcpy( ((struct DCCData*)sock->data)->file, params );
					((struct DCCData*)sock->data)->name = (char *)malloc( 256 );
					strcpy( ((struct DCCData*)sock->data)->name, user->nickname );
					
					if ( ( params = strtok( NULL, " " ) ) != 0 )
					{
						sscanf( params, "%lu", &((struct DCCData*)sock->data)->ip );
						((struct DCCData*)sock->data)->ip = ntohl( ((struct DCCData*)sock->data)->ip );
						
						if ( ( params = strtok( NULL, " " ) ) != 0 )
						{
							sscanf( params, "%lu", &((struct DCCData*)sock->data)->position );
							
							if ( ( params = strtok( NULL, " " ) ) != 0 )
							{
								sscanf( params, "%lu", &((struct DCCData*)sock->data)->fileSize );
								((struct DCCData*)sock->data)->state = 3;
								snprintf( out, 1023, "DCC: %s from %s", ((struct DCCData*)sock->data)->file, user->nickname );
							}
						}
					}
				}
			}
		}
								
		// if an action...
		if ( chatwin == 0 && !strcasecmp( cmd, "ACTION" ) && params != 0 )
		{
			// and we should open new windows on messages
			if ( b_get_option_bool( xidentity, "general", "opt_gen_open_new_query" ) == 1 )
				chatwin = b_new_chat_window( server, user->nickname, 0 ); // open a new one.
		}
		
		if ( chatwin != 0 )
		{
			if ( !strcasecmp( cmd, "ACTION" ) && params != 0 )
			{
				b_chatwin_printf( chatwin, BTV_Action, "* %s %s", user->nickname, params );
				s = 1;
			}
		}
		
		if ( s == 0 )
		{
			/*
			if ( chatwin == 0 )
				b_swindow_printf( server, BTV_CTCP, "%s", out );
			else
				b_chatwin_printf( chatwin, BTV_CTCP, "%s", out );
			*/
			
			b_window_printf( b_active_window( ), BTV_CTCP, "%s", out );
		}
		
		return 1;
	}
	
	return 0;
}

BERS_MESSAGE( b_msg_privmsg )
{
	char *sender = "NULL";
	BUserMask *from = (BUserMask *)window;
	BChatWindow *chatwin;
	
	sender = from->nickname;
	
	if ( pcount < 1 )
		return -1;
	
	chatwin = 0;
	
	// if the destination is ourself, don't try this.
	if ( strcasecmp( params[0], server->nickname ) )
		chatwin = b_find_chat_by_dest( server, params[0] );
	
	if ( chatwin == NULL )
	{
		chatwin = b_find_chat_by_dest( server, sender );
	}

	if ( b_msg_check_ctcp( server, chatwin, from, params[1] ) > 0 )
		return 0;

	if ( chatwin == 0 )
	{
		if ( b_get_option_bool( xidentity, "general", "opt_gen_open_new_query" ) == 1 )
			chatwin = b_new_chat_window( server, sender, 0 );
	}

	if ( chatwin != 0 )
	{
		b_chatwin_printf( chatwin, BTV_Message, "<%s> %s", sender, params[1] );
	}
	else
	{
		b_swindow_printf( server, BTV_Message, "<%s:%s> %s", sender, params[0], params[1] );
	}
	
	return 0;
}

BERS_MESSAGE( b_msg_topic_change )
{
	BChatWindow *chatwin;
	BUserMask *from = (BUserMask *)window;
	
	if ( pcount < 2 )
		return -1;
	
	chatwin = b_find_chat_by_dest( server, params[0] );
	
	if ( chatwin == NULL )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "topic_change", "nick", from->nickname, "topic", params[1], 0 );
	b_chatwin_printf( chatwin, BTV_Topic, "%s", lang_tmp_buf );
	
	strcpy( chatwin->topic, params[1] );
	b_chat_update_title( chatwin );
	
	return 0;
}

BERS_MESSAGE( b_msg_topic )
{
	BChatWindow *chatwin;
	
	if ( pcount < 2 )
		return -1;
	
	chatwin = b_find_chat_by_dest( server, params[1] );
	
	if ( chatwin == NULL )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "topic", "topic", params[2], 0 );
	b_chatwin_printf( chatwin, BTV_Topic, "%s", lang_tmp_buf );
	
	strcpy( chatwin->topic, params[2] );
	b_chat_update_title( chatwin );
	
	return 0;
}

BERS_MESSAGE( b_msg_topicset )
{
	BChatWindow *chatwin;
	char currtimes[256];
	time_t curtime;
	
	if ( pcount < 2 )
		return -1;
	
	chatwin = b_find_chat_by_dest( server, params[1] );
	
	if ( chatwin == NULL )
		return -1;
	
	curtime = atoi( params[3] );
	strftime( currtimes, 256, b_get_option_string( xidentity, "time", "opt_time_long_timestamp" ), localtime(&curtime) );
	
	lang_phrase_parse( lang_tmp_buf, 1024, "topic_set", "nick", params[2], "date", currtimes, 0 );
	b_chatwin_printf( chatwin, BTV_Topic, "%s", lang_tmp_buf );
	
	return 0;
}

int b_update_userlist_sortfunc( const void *a, const void *b )
{
	return strcasecmp( *((char **)a), *((char **)b) );
}

void b_update_userlist_mode( BChatWindow *chan, char **users, int num, char *prefix )
{
	char tmp[64];
	int a;
	
	qsort( users, num, sizeof(char *), &b_update_userlist_sortfunc );
	
	for ( a = 0; a < num; a++ )
	{
		sprintf( tmp, "%s%s", prefix, users[a] );
		
		c_listbox_additem( chan->userlist, tmp );
	}
}

void b_update_userlist( BChatWindow *chan )
{
	
}

char b_mode_p2m( char prefix )
{
	char *m_ptr, *p_ptr, *p_diff;
	
	m_ptr = (char *)&b_irc_modes;
	p_ptr = (char *)&b_irc_symbs;
		
	p_diff = strchr( p_ptr, prefix );
	
	if ( p_diff == NULL )
		return 0;
	
	return *( m_ptr + ( p_diff - p_ptr ) );
}

char b_mode_m2p( char prefix )
{
	char *m_ptr, *p_ptr, *p_diff;
	
	m_ptr = (char *)&b_irc_symbs;
	p_ptr = (char *)&b_irc_modes;
		
	p_diff = strchr( p_ptr, prefix );
	
	if ( p_diff == NULL )
		return 0;
	
	return *( m_ptr + ( p_diff - p_ptr ) );
}

BERS_MESSAGE( b_msg_channames )
{
	BChatWindow *chatwin;
	char *tmp, *cur, *a;
	BUserStore store;
	char mode, umode;
	//char *m_ptr, *p_ptr, *p_diff;
	
	memset( &store, 0, sizeof( BUserStore ) );
	
	if ( pcount < 2 )
		return -1;
	
	chatwin = b_find_chat_by_dest( server, params[2] );
	
	if ( chatwin == NULL )
		return -1;
	
	//b_chatwin_printf( chatwin, BTV_Topic, "* Users : %s", params[3] );
	
	if ( chatwin->synced == 1 )
	{
		chatwin->synced = 0;
		b_chat_user_empty( chatwin );
		
		c_tbl_empty( chatwin->users_table );
	}
	
	tmp = (char *)malloc( strlen( params[3] ) + 1 );
	
	strcpy( tmp, params[3] );
	
	a = tmp;
	
	while ( ( cur = strtok( a, " " ) ) != NULL )
	{
		mode = cur[0];
		
		if ( strchr( b_irc_allsym, mode ) != NULL )
			cur++;
		else
			mode = 0;
		
		strcpy( store.nickname, cur );
		strcpy( store.modes, "" );
		
		umode = b_mode_p2m( mode );
		
		if ( umode != 0 )
		{
			// Another note here, if we get a "q" or "a" mode, we add "o".
			// Although this may not be true, it's likely to be most of the time.
			
			sprintf( store.modes, "%c%s", umode, ( ( umode == 'q' || umode == 'a' ) ? "o" : "" ) );
		}
		
		b_chat_user_add( chatwin, &store );
		//b_insert_userlist_user( chatwin, &store );
		
	
		
		a = NULL;
	}
	
	return 0;
}

int b_nickcmp( char *a, char *b )
{
	// a < b   -1 (a,b)
	// a > b   +1 (b,a)
	// a = b   0
	
	char *ap = strchr( b_irc_symbs, a[0] );
	char *bp = strchr( b_irc_symbs, b[0] );
	
	if ( bp == NULL && ap != NULL )
		return -1; // a before b
	
	if ( ap == NULL && bp != NULL )
		return 1; // b before a
	
	if ( ap < bp )
		return -1; // a before b
	
	if ( ap > bp )
		return 1; // b before a
	
	if ( bp != NULL )
		b++;
	
	if ( ap != NULL )
		a++;
	
	return strcasecmp( a, b );
}

char b_find_user_prefix( BUserStore *st )
{
	int a;
	
	for ( a = 0; a < strlen( b_irc_modes ); a++ )
	{
		// highest mode first, break as soon as we hit one.
		if ( strchr( st->modes, b_irc_modes[a] ) )
			return b_irc_symbs[a];
	}
	
	return 0;
}

int b_find_table_row_position( ClaroTable *tbl, BUserStore *st )
{
	int a;
	char tuser[64];
	char prefix = b_find_user_prefix( st );
	ClaroTableCell *cell;
	
	strcpy( tuser, "" );
	
	if ( prefix != 0 )
		sprintf( tuser, "%c", prefix );
	
	strcat( tuser, st->nickname );
	
	for ( a = 0; a < tbl->rows; a++ )
	{
		cell = c_tbl_get_cell( tbl, a, 0 );
		
		if ( b_nickcmp( tuser, (char *)cell->data ) == -1 )
			return a;
	}
	
	return tbl->rows; // should go at the end
}

BERS_MESSAGE( b_msg_channames_end )
{
	BChatWindow *chatwin;
	
	if ( pcount < 2 )
		return -1;
	
	chatwin = b_find_chat_by_dest( server, params[1] );
	
	if ( chatwin == NULL )
		return -1;
	
	chatwin->synced = 1;
	
	//b_update_userlist( chatwin );
	
	b_user_command( chatwin, "/chanstats", 1 );
	
	return 0;
}

BERS_MESSAGE( b_msg_join )
{
	BChatWindow *cw;
	BUserMask *from = BERS_MESSAGE_FROM();
	BUserStore store;
	
	if ( pcount < 1 )
		return -1;
	
	cw = b_find_chat_by_dest( server, params[0] );
	
	if ( !strcasecmp( from->nickname, server->nickname ) )
	{
		if ( cw == 0 )
		{
			cw = b_new_chat_window( server, params[0], 1 );
			lang_phrase_parse( lang_tmp_buf, 1024, "nowtalking", "chan", params[0], 0 );
		}
		else
		{
			lang_phrase_parse( lang_tmp_buf, 1024, "rejoined", "chan", params[0], 0 );
		}
		c_btv_printf( cw->content, 0, BTV_WindowOpen, "%s", lang_tmp_buf );
		
		cw->parted = 0;
		
		b_server_printf( server, "MODE %s", params[0] );
	}
	else
	{
		lang_phrase_parse( lang_tmp_buf, 1024, "fmt_join", "nick", from->nickname, "user", from->username, "host", from->hostname, "chan", params[0], 0 );
		c_btv_printf( cw->content, 0, BTV_UserJoin, "%s", lang_tmp_buf );
		strcpy( store.nickname, from->nickname );
		strcpy( store.username, from->username );
		strcpy( store.hostname, from->hostname );
		strcpy( store.realname, "" );
		strcpy( store.modes, "" );
		
		b_chat_user_add( cw, &store );
		//b_insert_userlist_user( cw, &store );
		//b_update_userlist( cw );
	}
	
	return 0;
}

BERS_MESSAGE( b_msg_part )
{
	BChatWindow *cw;
	BUserMask *from = BERS_MESSAGE_FROM();
	
	if ( pcount < 1 )
		return -1;
	
	cw = b_find_chat_by_dest( server, params[0] );
	
	if ( cw == 0 )
		return 0; // nothing to see here..
	
	if ( !strcasecmp( from->nickname, server->nickname ) )
	{
		cw->parted = 1;
		if ( cw->partrequested == 1 && b_get_option_bool( xidentity, "general", "opt_gen_close_on_part" ) )
		{
			c_close_widget( cw->window );
		}
		else
		{
			lang_phrase_parse( lang_tmp_buf, 1024, "fmt_self_part", "chan", params[0], 0 );
			c_btv_printf( cw->content, 0, BTV_UserPart, "%s", lang_tmp_buf );
			
			b_chat_user_empty( cw );
			/*b_update_userlist( cw );*/
			
		}
	}
	else
	{
		lang_phrase_parse( lang_tmp_buf, 1024, "fmt_part", "nick", from->nickname, "user", from->username, "host", from->hostname, "chan", params[0], "reason", (pcount == 1 ? "No reason" : params[1]), 0 );
		c_btv_printf( cw->content, 0, BTV_UserPart, "%s", lang_tmp_buf );
		b_chat_user_del( cw, from->nickname );
		
		//b_update_userlist( cw );
	}
	
	return 0;
}

BERS_MESSAGE( b_msg_kick )
{
	BChatWindow *cw;
	BUserMask *from = BERS_MESSAGE_FROM();
	
	if ( pcount < 3 )
		return -1;

	cw = b_find_chat_by_dest( server, params[0] );
	
	if ( cw == 0 )
		return 0; // nothing to see here..
	
	if ( !strcasecmp( params[1], server->nickname ) )
	{
		cw->parted = 1;
		lang_phrase_parse( lang_tmp_buf, 1024, "youkicked", "nick", from->nickname, "chan", params[0], "reason", params[2], 0 );
		c_btv_printf( cw->content, 0, BTV_UserKick, "%s", lang_tmp_buf );
		
		b_chat_user_empty( cw );
		b_update_userlist( cw );
		if ( b_get_option_bool( xidentity, "general", "opt_gen_rejoin_on_kick" ) ) // rejoin on kick
		{
			if ( !strcmp( cw->key, "" ) )
				b_server_printf( server, "JOIN %s", cw->dest );
			else
				b_server_printf( server, "JOIN %s %s", cw->dest, cw->key );
		}
	}
	else
	{
		lang_phrase_parse( lang_tmp_buf, 1024, "userkicked", "nick", from->nickname, "victim", params[1], "chan", params[0], "reason", params[2], 0 );
		c_btv_printf( cw->content, 0, BTV_UserKick, "%s", lang_tmp_buf );
		b_chat_user_del( cw, params[1] );
		
		//b_update_userlist( cw );
	}
	
	return 0;
}

BERS_MESSAGE( b_msg_quit )
{
	BChatWindow *cw;
	BUserMask *from = BERS_MESSAGE_FROM();
	char quitmsg[1024];
	
	if ( pcount < 1 )
		return -1;
	
	lang_phrase_parse( quitmsg, 1024, "fmt_quit", "nick", from->nickname, "user", from->username, "host", from->hostname, "reason", params[0], 0 );
	//sprintf( quitmsg, "* %s (%s@%s) has quit IRC (%s)", from->nickname, from->username, from->hostname, params[0] );
	
	for ( cw = server->chat_head; cw != 0; cw = cw->next )
	{
		if ( cw->type == B_CMD_WINDOW_CHANNEL )
		{
			// channel window
			if ( b_chat_user_find_nick( cw, from->nickname ) != 0 )
			{
				c_btv_printf( cw->content, 0, BTV_UserQuit, "%s", quitmsg );
				b_chat_user_del( cw, from->nickname );
				//b_update_userlist( cw );
			}
		}
		else
		{
			// query window
			if ( !strcasecmp( cw->dest, from->nickname ) )
			{
				// query to this user
				
				if ( b_get_option_bool( xidentity, "general", "opt_misc_quit_in_query" ) )
				{
					// write it here too
					c_btv_printf( cw->content, 0, BTV_UserQuit, "%s", quitmsg );
				}
			}
		}
	}
	
	return 0;
}

BERS_MESSAGE( b_msg_error )
{
	b_swindow_printf( server, BTV_Error, "%s", params[0] );
	
	return 0;
}

BERS_MESSAGE( b_msg_notice )
{
	char *sender = "NULL";
	BUserMask *from = (BUserMask *)window;
	BChatWindow *chatwin;
	
	if ( flags & 4096 )
		sender = from->nickname;
	
	if ( pcount < 2 )
		return -1;
		
	chatwin = b_find_chat_by_dest( server, params[0] );
	
	if ( flags & 4096 && chatwin == NULL )
	{
		chatwin = b_find_chat_by_dest( server, sender );
	}
	
	if ( b_msg_check_ctcp( server, chatwin, from, params[1] ) > 0 )
		return 0;
	
	b_swindow_printf( server, BTV_Notice, "-%s- %s", sender, params[1] );
	
	return 0;
}

BERS_MESSAGE( b_msg_welcome )
{
	char *sender = "NULL";
	BUserMask *from = (BUserMask *)window;
	
	server->nickcount = -1;
	
	if ( flags & 4096 )
		sender = from->nickname;
	
	if ( pcount < 2 )
		return -1;
	
	strcpy( server->nickname, params[0] );
	
	if ( pcount == 2 )
		b_swindow_printf( server, BTV_Message, "%s", params[1] );
	else
		b_swindow_printf( server, BTV_Message, "%s %s", params[1], params[2] );
	
	return 0;
}

BERS_MESSAGE( b_msg_uphost )
{
	if ( pcount < 2 )
		return -1;
	
	memset( server->servername, 0, 256 );
	strncpy( server->servername, params[1], 255 );
	
	b_server_update_title( server );
	
	return 0;
}

BERS_MESSAGE( b_msg_connected )
{
	if ( pcount < 2 )
		return -1;
	
	b_server_run_onconnect( server );
	
	return 0;
}

BERS_MESSAGE( b_msg_userhost )
{
	char *txt;
	
	if ( pcount < 2 )
		return -1;
	
	b_swindow_printf( server, BTV_Message, "%s %s", params[0], params[1] );
	
	if ( !strcasecmp( params[0], server->nickname ) )
	{
		if ( ( txt = strrchr( params[1], '@' ) ) != NULL )
		{
			txt++;
			strcpy( server->user_hostname, txt );
			
			while ( 1 )
			{
				char c = server->user_hostname[strlen(server->user_hostname)-1];
				
				if ( c == '\r' || c == '\n' || c == ' ' || c == '\t' )
					server->user_hostname[strlen(server->user_hostname)-1] = '\0';
				else
					break;
			}
			
			//b_swindow_printf( server, BTV_ServerWelcome, "* You are connecting from %s", server->user_hostname );
		}
	}
	
	return 0;
}

BERS_MESSAGE( b_msg_motd )
{
	char *sender = "NULL";
	BUserMask *from = (BUserMask *)window;
	
	if ( flags & 4096 )
		sender = from->nickname;
	
	if ( pcount < 2 )
		return -1;
	
	b_swindow_printf( server, BTV_MOTD, "%s", params[1] );
	
	return 0;
}

int b_mode_handle_power( B_MODE_HANDLER_PARMS )
{
	BUserStore *user;
	char newmodes[16];
	int a, b;
	
	// BServerWindow *server, BChatWindow *chanwin, char dir, char mode, char *channel, char *victim
	
	if ( ( user = b_chat_user_find_nick( chanwin, victim ) ) == 0 )
		return 0;
	
	strcpy( newmodes, user->modes );
	
	if ( dir == '+' && strchr( user->modes, mode ) == 0 )
	{
		sprintf( newmodes, "%s%c", user->modes, mode );
	}
	else if ( dir == '-' )
	{
		memset( &newmodes, 0, 16 );
		for ( a = 0, b = 0; a < strlen( user->modes ); a++ )
		{
			if ( user->modes[a] != mode )
			{
				newmodes[b] = user->modes[a];
				b++;
			}
		}
	}
	
	// save. remember, the original will be used if nothing happened.
	strcpy( user->modes, newmodes );
	
	// FIXME: fix teh item here
	//b_update_userlist( chanwin );
	b_userstore_updated( chanwin, user, 1 );
	
	return 0;
}

int b_mode_handle_null( B_MODE_HANDLER_PARMS )
{
	return 0;
}

int b_mode_handle_key( B_MODE_HANDLER_PARMS )
{
	if ( dir == '-' )
		strcpy( chanwin->key, "" );
	else
		strcpy( chanwin->key, victim );
	
	return 0;
}

typedef struct
{
	char mode;
	int (*handler)( B_MODE_HANDLER_PARMS );
	short pnum;
	short reserved;
	short chmode;
} ChannelModeHandler;

ChannelModeHandler b_chan_mode_handlers[] = {
	// power, my friend
	{ 'q', b_mode_handle_power, 1, 0 },
	{ 'a', b_mode_handle_power, 1, 0 },
	{ 'o', b_mode_handle_power, 1, 0 },
	{ 'h', b_mode_handle_power, 1, 0 },
	{ 'v', b_mode_handle_power, 1, 0 },
	
	// the rest
	{ 'b', b_mode_handle_null, 1, 0 },
	{ 'e', b_mode_handle_null, 1, 0 },
	{ 'L', b_mode_handle_null, 1, 1 },
	{ 'l', b_mode_handle_null, 1, 1 },
	{ 'f', b_mode_handle_null, 1, 1 },
	{ 'k', b_mode_handle_key, 1, 1 },
	
	// and we need to define any singles we want remembered
	{ 'n', b_mode_handle_null, 0, 1 },
	{ 't', b_mode_handle_null, 0, 1 },
	{ 's', b_mode_handle_null, 0, 1 },
	{ 'p', b_mode_handle_null, 0, 1 },
	{ 'i', b_mode_handle_null, 0, 1 },
	{ 'm', b_mode_handle_null, 0, 1 },
	
	// that's it!
	{ 0 }
};

void b_mode_handle_any( B_MODE_HANDLER_PARMS )
{
	ClaroTableRow *row;
	ClaroTableCell *cell;
	int a;
	
	// BServerWindow *server, BChatWindow *chanwin, char dir, char mode, char *channel, char *victim
	
	if ( dir == '-' )
	{
		// remove that row
		for ( a = 0; a < chanwin->channel_modes->rows; a++ )
		{
			cell = c_tbl_get_cell( chanwin->channel_modes, a, 0 );
			if ( ((char *)cell->data)[0] == mode )
			{
				free( cell->data );
				
				cell = c_tbl_get_cell( chanwin->channel_modes, a, 1 );
				free( cell->data );
				
				c_tbl_delete_row( chanwin->channel_modes, a );
				
				b_chat_update_title( chanwin );
				
				return;
			}
		}
	}
	else
	{
		// firstly, remove the row (just in case) :p
		b_mode_handle_any( server, chanwin, '-', mode, channel, victim );
		
		// now add it
		row = c_tbl_insert_row( chanwin->channel_modes, chanwin->channel_modes->rows );
		
		cell = c_tbl_get_cell( chanwin->channel_modes, row->pos, 0 );
		cell->data = malloc( 2 );
		sprintf( cell->data, "%c", mode );
		
		cell = c_tbl_get_cell( chanwin->channel_modes, row->pos, 1 );
		if ( victim == 0 )
			cell->data = strdup( "" );
		else
			cell->data = strdup( victim );
		
		b_chat_update_title( chanwin );
	}
}

BERS_MESSAGE( b_msg_chanmodeis )
{
	int a, b, c, d, e;
	char act, cch;
	BChatWindow *cw;
	char *tmp;
	char *modevictims = 0;
	
	cw = b_find_chat_by_dest( server, params[1] );
	
	if ( cw == 0 || cw->type != B_CMD_WINDOW_CHANNEL )
		return 0;
	
	d = 0;
	b = 3;
	
	for ( c = 0, act = '+'; c < strlen( params[2] ); c++ )
	{
		cch = params[2][c];
		
		if ( cch == '+' || cch == '-' )
		{
			act = cch;
			continue;
		}
		
		for ( a = 0; b_chan_mode_handlers[a].mode != 0; a++ )
		{
			if ( b_chan_mode_handlers[a].mode == cch )
			{
				// run it :)
				
				tmp = 0;
				
				if ( b_chan_mode_handlers[a].pnum != 0 && pcount > b )
					tmp = params[b];
				
				(*b_chan_mode_handlers[a].handler)( server, cw, act, cch, params[1], tmp );
				b_mode_handle_any( server, cw, act, cch, params[1], tmp );
				
				if ( tmp != 0 )
				{
					e = d;
					d += strlen( tmp ) + 1;
					
					modevictims = (char *)realloc( modevictims, d+1 );
					
					if ( e == 0 )
						strcpy( modevictims, "" );
					else
						strcat( modevictims, " " );
					
					strcat( modevictims, tmp );
				}
				
				b += b_chan_mode_handlers[a].pnum;
				break;
			}
		}
	}
	
	if ( modevictims == 0 )
	{
		modevictims = (char *)malloc( 1 );
		strcpy( modevictims, "" );
	}
	
	lang_phrase_parse( lang_tmp_buf, 1024, "chan_all_modes", "mode", params[2], "victims", modevictims, 0 );
	b_chatwin_printf( cw, BTV_ModeChange, "%s", lang_tmp_buf );
	
	free( modevictims );
	
	return 0;
}

BERS_MESSAGE( b_msg_mode )
{
	char *sender = "NULL";
	BUserMask *from = (BUserMask *)window;
	int a, b, c, d, e;
	char act, cch;
	BChatWindow *cw;
	char *tmp;
	char *modevictims = 0;
	
	if ( flags & 4096 )
		sender = from->nickname;
	
	if ( pcount < 2 )
		return -1;
	
	if ( !strcasecmp( server->nickname, params[0] ) )
	{
		lang_phrase_parse( lang_tmp_buf, 1024, "umode", "nick", sender, "mode", params[1], 0 );
		b_swindow_printf( server, BTV_ModeChange, "%s", lang_tmp_buf );
	}
	else
	{
		// channel modes.
		
		cw = b_find_chat_by_dest( server, params[0] );
		
		if ( cw == 0 || cw->type != B_CMD_WINDOW_CHANNEL )
			return 0;
		
		d = 0;
		b = 2;
		
		for ( c = 0, act = '+'; c < strlen( params[1] ); c++ )
		{
			cch = params[1][c];

			if ( cch == '+' || cch == '-' )
			{
				act = cch;
				continue;
			}
			
			for ( a = 0; b_chan_mode_handlers[a].mode != 0; a++ )
			{
				if ( b_chan_mode_handlers[a].mode == cch )
				{
					// run it :)
					
					tmp = 0;
					
					if ( b_chan_mode_handlers[a].pnum != 0 && pcount > b )
						tmp = params[b];
					
					(*b_chan_mode_handlers[a].handler)( server, cw, act, cch, params[0], tmp );
					if ( b_chan_mode_handlers[a].chmode == 1 )
						b_mode_handle_any( server, cw, act, cch, params[0], tmp );
					
					if ( tmp != 0 )
					{
						e = d;
						d += strlen( tmp ) + 1;
						
						modevictims = (char *)realloc( modevictims, d+1 );
						
						if ( e == 0 )
							strcpy( modevictims, "" );
						else
							strcat( modevictims, " " );
						
						strcat( modevictims, tmp );
					}
					
					b += b_chan_mode_handlers[a].pnum;
					break;
				}
			}
		}
		
		if ( modevictims == 0 )
		{
			modevictims = (char *)malloc( 1 );
			strcpy( modevictims, "" );
		}
		
		lang_phrase_parse( lang_tmp_buf, 1024, "mode", "nick", sender, "mode", params[1], "victims", modevictims, 0 );
		b_chatwin_printf( cw, BTV_ModeChange, "%s", lang_tmp_buf );
		
		free( modevictims );
	}
	
	return 0;
}

BERS_MESSAGE( b_msg_nick )
{
	char *sender = "NULL";
	BUserMask *from = (BUserMask *)window;
	BChatWindow *cw;
	BUserStore *user;
	int a;
	char nickmsg[1024];
	
	if ( flags & 4096 )
		sender = from->nickname;
	
	if ( pcount < 1 )
		return -1;
	
	a = 0;
	
	if ( !strcasecmp( sender, server->nickname ) )
	{
		// we're the user! we've changed nicknames.
		strcpy( server->nickname, params[0] );
		b_server_update_title( server );
		a = 1;
	}
	
	if ( a == 1 )
	{
		lang_phrase_parse( lang_tmp_buf, 1024, "younick", "nick", params[0], 0 );
	}
	else
	{
		lang_phrase_parse( lang_tmp_buf, 1024, "nick", "oldnick", from->nickname, "nick", params[0], 0 );
	}
	
	sprintf( nickmsg, "%s", lang_tmp_buf );
	
	for ( cw = server->chat_head; cw != 0; cw = cw->next )
	{
		if ( cw->type == B_CMD_WINDOW_CHANNEL )
		{
			// channel window
			if ( ( user = b_chat_user_find_nick( cw, from->nickname ) ) != 0 )
			{
				c_btv_printf( cw->content, 0, BTV_UserNick, "%s", nickmsg );
				strcpy( user->nickname, params[0] );
				
				b_userstore_updated( cw, user, 1 );
				//b_update_userlist( cw );
			}
		}
		else
		{
			// query window
			if ( !strcasecmp( cw->dest, from->nickname ) )
			{
				// query to this user
				if ( b_get_option_bool( xidentity, "general", "opt_misc_nick_in_query" ) )
				{
					// write it here too
					c_btv_printf( cw->content, 0, BTV_UserNick, "%s", nickmsg );
				}
				
				if ( b_get_option_bool( xidentity, "general", "opt_misc_nick_update_query" ) )
				{
					// change this window's dest
					strcpy( cw->dest, params[0] );
					b_chat_update_title( cw );
				}
			}
		}
	}
	
	return 0;
}

BERS_MESSAGE( b_msg_unknowncmd )
{
	if ( pcount < 3 )
		return -1;
	
	b_window_printf( server, BTV_Error, "/%s: %s", params[1], params[2] );
	
	return 0;
}

BERS_MESSAGE( b_msg_writeparm1 )
{
	if ( pcount < 2 )
		return -1;
	
	b_window_printf( server, BTV_ServerWelcome, "%s", params[1] );
	
	return 0;
}

BERS_MESSAGE( b_msg_writeparm2 )
{
	if ( pcount < 3 )
		return -1;
	
	b_window_printf( server, BTV_ServerWelcome, "%s", params[2] );
	
	return 0;
}

BERS_MESSAGE( b_msg_writeparm2toactive )
{
	if ( pcount < 3 )
		return -1;
	
	b_window_printf( b_active_window( ), BTV_ModeChange, "%s", params[2] );
	
	return 0;
}

BERS_MESSAGE( b_msg_away )
{
	if ( pcount < 2 )
		return -1;
	
	b_window_printf( b_active_window( ), BTV_Info, "* %s", params[1] );
	
	return 0;
}

BERS_MESSAGE( b_msg_whois_311 )
{
	if ( pcount < 5 )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "whois_info", "nick", params[1], "user", params[2], "host", params[3], "name", params[5], 0 );
	b_window_printf( b_active_window( ), BTV_Whois, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_whois_314 )
{
	if ( pcount < 5 )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "whois_was", "nick", params[1], "user", params[2], "host", params[3], "name", params[5], 0 );
	b_window_printf( b_active_window( ), BTV_Whois, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_whois_is )
{
	if ( pcount < 3 )
		return -1;
	
	b_window_printf( b_active_window( ), BTV_Whois, "%s %s", params[1], params[2] );
	
	return 0;
}

BERS_MESSAGE( b_msg_whois_319 )
{
	if ( pcount < 3 )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "whois_on", "nick", params[1], "what", params[2], 0 );
	b_window_printf( b_active_window( ), BTV_Whois, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_whois_312 )
{
	if ( pcount < 4 )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "whois_using", "nick", params[1], "server", params[2], "quote", params[3], 0 );
	b_window_printf( b_active_window( ), BTV_Whois, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_whois_330 )
{
	if ( pcount < 4 )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "whois_authed_as", "nick", params[1], "auth", params[2], 0 );
	b_window_printf( b_active_window( ), BTV_Whois, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_whois_317 )
{
	int secsidle, signon;
	char *idle, *sign;
	char currtimes[256];
	time_t curtime;
	
	if ( pcount < 5 )
		return -1;
	
	secsidle = signon = 0;
	idle = sign = "unknown";
	
	secsidle = atoi( params[2] );
	signon = atoi( params[3] );
	
	curtime = signon;
	strftime( currtimes, 256, b_get_option_string( xidentity, "time", "opt_time_long_timestamp" ), localtime(&curtime) );
	
	lang_phrase_parse( lang_tmp_buf, 1024, "whois_idle", "nick", params[1], "idle", idle, "signon", currtimes, 0 );
	b_window_printf( b_active_window( ), BTV_Whois, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_whois_338 )
{
	if ( pcount < 4 )
		return -1;
	
	b_window_printf( b_active_window( ), BTV_Whois, "%s %s %s", params[1], params[3], params[2] );
	
	return 0;
}

BERS_MESSAGE( b_msg_invite_341 )
{
	if ( pcount < 3 )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "youinvited", "nick", params[1], "chan", params[2], 0 );
	b_window_printf( b_active_window( ), BTV_Info, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_uaway )
{
	if ( pcount < 3 )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "away", "nick", params[1], "reason", params[2], 0 );
	b_window_printf( b_active_window( ), BTV_Whois, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_time )
{
	if ( pcount < 3 )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "server-time", "time", params[2], "server", params[1], 0 );
	b_window_printf( b_active_window( ), BTV_Info, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_null )
{
	return 0;
}

BERS_MESSAGE( b_msg_checkprefix )
{
	char *prefix;
	char *tmp, *loc;
	
	prefix = strstr( origcmd, "PREFIX=" );
	
	if ( prefix == 0 )
		return 0;
	
	tmp = strdup( prefix );
	
	loc = strstr( tmp, " " );
	if ( loc != 0 )
		loc[0] = 0;
	
	prefix = tmp + 7;
	
	sscanf( prefix, "(%[^)])%s", b_irc_modes, b_irc_symbs );
	
	free( tmp );
	
	return 0;
}

/*
	// :nenolod!~nenolod@nenolod.developer.athemenet INVITE Theo :#priv_meeting
	b_register_message( "invite", &b_msg_invite, 0 );
	
	// :nenolod!~nenolod@nenolod.developer.athemenet WALLOPS :OPERWALL - what
	b_register_message( "wallops", &b_msg_wallops, 0 );
	
	// :irc.free2code.net 329 Theo #priv_meeting 1129514890
*/

BERS_MESSAGE( b_msg_createtime )
{
	BChatWindow *chatwin;
	char currtimes[256];
	time_t curtime;
	
	if ( pcount < 2 )
		return -1;
	
	chatwin = b_find_chat_by_dest( server, params[1] );
	
	if ( chatwin == NULL )
		return -1;
	
	curtime = atoi( params[2] );
	strftime( currtimes, 256, b_get_option_string( xidentity, "time", "opt_time_long_timestamp" ), localtime(&curtime) );
	
	lang_phrase_parse( lang_tmp_buf, 1024, "channel_created", "date", currtimes, 0 );
	b_chatwin_printf( chatwin, BTV_Topic, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_invite )
{
	BUserMask *from = (BUserMask *)window;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "channel_invite", "user", from->nickname, "chan", params[1], 0 );
	b_window_printf( b_active_window( ), BTV_Invite, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_wallops )
{
	BUserMask *from = (BUserMask *)window;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "wallops", "user", from->nickname, "msg", params[0], 0 );
	b_window_printf( server, BTV_Wallops, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_notopic )
{
	BChatWindow *chatwin;
	
	if ( pcount < 2 )
		return -1;
	
	chatwin = b_find_chat_by_dest( server, params[1] );
	
	if ( chatwin == NULL )
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, "channel_notopic", 0 );
	b_chatwin_printf( chatwin, BTV_Topic, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_chanurl )
{
	BChatWindow *chatwin;
	
	if ( pcount < 2 )
		return -1;
	
	chatwin = b_find_chat_by_dest( server, params[1] );
	
	if ( chatwin == NULL )
		return -1;
	
	// FIXME: Topic: Wrong colour?
	lang_phrase_parse( lang_tmp_buf, 1024, "channel_url", "url", params[2], 0 );
	b_chatwin_printf( chatwin, BTV_Topic, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_MESSAGE( b_msg_stderror )
{
	BUserMask *from = (BUserMask *)window;
	char *ermsg = "";
	
	     if ( !strcmp( command, "401" ) ) ermsg = "no_such_nick";
	else if ( !strcmp( command, "402" ) ) ermsg = "no_such_server";
	else if ( !strcmp( command, "403" ) ) ermsg = "no_such_channel";
	else if ( !strcmp( command, "404" ) ) ermsg = "cannot_send";
	else if ( !strcmp( command, "405" ) ) ermsg = "toomanychannels";
	else if ( !strcmp( command, "406" ) ) ermsg = "wasnosuchnick";
	else if ( !strcmp( command, "407" ) ) ermsg = "toomanytargets";
	//
	else if ( !strcmp( command, "471" ) ) ermsg = "cannot_join_l";
	else if ( !strcmp( command, "473" ) ) ermsg = "cannot_join_i";
	else if ( !strcmp( command, "474" ) ) ermsg = "cannot_join_b";
	else if ( !strcmp( command, "475" ) ) ermsg = "cannot_join_k";
	else if ( !strcmp( command, "482" ) ) ermsg = "not_chanop";
	else if ( !strcmp( command, "442" ) ) ermsg = "not_on_channel";
	else if ( !strcmp( command, "437" ) ) ermsg = "res_temp_unavail";
	else
		return -1;
	
	lang_phrase_parse( lang_tmp_buf, 1024, ermsg, "chan", params[1], "nick", params[1], "server", params[1], 0 );
	b_window_printf( b_active_window( ), BTV_Alert, "%s", lang_tmp_buf );
	
	return 0;
}

//
