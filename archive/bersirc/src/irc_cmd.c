/*************************************************************************
$Id: irc_cmd.c 186 2005-11-03 23:35:26Z terminal $

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

extern CWidget *mainwin;

/** Commands returning '1' halt, '0' just continue, '-1' too few params, '-2' too many params, '-3' invalid param count, '-4' invalid params **/

BERS_COMMAND( b_cmd_server )
{
	BServerWindow *target;
	char hostname[256];
	int port;
	int a, b, n;
	
	if ( pcount < 1 )
		return -1;
	
	port = 6667;
	target = server;
	n = 0;
	
	// if command starts with 'n', it's either
	//  nserver or nsvr, so default to new status
	if ( command[0] == 'n' )
		n = 1;
	
	for ( a = b = 0; a < pcount; a++ )
	{
		if ( params[a][0] != '-' )
		{
			if ( b == 0 )
				strncpy( hostname, params[a], 256 );
			else if ( b == 1 )
				port = atoi( params[a] );
			
			b++;
		}
		else
		{
			if ( !strcasecmp( params[a], "-new" ) )
			{
				n = 1;
			}
		}
	}
	
	if ( b < 1 )
		return -1;
	
	if ( n == 1 )
		target = b_new_server_window( 0 );
	
	b_server_connect( target, hostname, port );
	
	return 0;
}

BERS_COMMAND( b_cmd_quit )
{
	char *msg = 0;
	
	if ( pcount > 0 )
	{
		msg = origcmd + strlen( command ) + 2;
	}
	
	if ( msg == 0 )
		msg = b_get_quit_message( );
	
	if ( server->connected == 0 )
	{
		b_swindow_printf( server, BTV_ConnectionMsg, lang_phrase_quick( "bad_command" ) );
		return 0;
	}
	
	b_server_printf( server, "QUIT :%s", msg );
	
	return 0;
}

BERS_COMMAND( b_cmd_join )
{
	char *channels = NULL;
	char *key = "";
	
	if ( pcount < 1 )
	{
		if ( !( flags & 1 ) || ((BChatWindow *)window)->type != B_CMD_WINDOW_CHANNEL )
			return -1;
		else
			channels = ((BChatWindow *)window)->dest;
	}
	else
		channels = params[0];
	
	if ( pcount >= 2 )
		key = params[1];

	if ( channels[0] != '#' && channels[0] != '&' && channels[0] != '!' && channels[0] != '+' )
		b_server_printf( server, "JOIN #%s %s", channels, key );
	else
		b_server_printf( server, "JOIN %s %s", channels, key );
	
	return 0;
}

BERS_COMMAND( b_cmd_part )
{
	char *channels = NULL;
	char *chancpy, *chanptr, *chan;
	BChatWindow *chatwin;
	
	if ( pcount < 1 )
	{
		if ( !( flags & 1 ) || ((BChatWindow *)window)->type != B_CMD_WINDOW_CHANNEL )
			return -1;
		else
			channels = ((BChatWindow *)window)->dest;
	}
	else
		channels = params[0];
	
	chancpy = (char *)malloc( strlen( channels ) + 1 );

	if ( !chancpy )
		return 0;

	strcpy( chancpy, channels );
	
	chanptr = chancpy;
	
	while ( ( chan = strtok( chanptr, "," ) ) != 0 )
	{
		chanptr = 0;
		
		chatwin = b_find_chat_by_dest( server, chan );
		
		if ( chatwin != 0 )
			chatwin->partrequested = 1;
	}
	
	free( chancpy );
	
	if ( channels[0] != '#' )
		b_server_printf( server, "PART :#%s", channels );
	else
		b_server_printf( server, "PART :%s", channels );
	
	return 0;
}

// /kick <user> [reason]
BERS_COMMAND( b_cmd_kick )
{
	char *reason = "No Reason";
	char *user = "";
	char *channel = ((BChatWindow *)window)->dest;
	
	if ( pcount < 1 )
		return -1;

	user = params[0];
	
	if ( pcount > 1 )
	{
		reason = origcmd + strlen( command ) + strlen( user ) + 3;
	}

	b_server_printf( server, "KICK %s %s :%s", channel, user, reason );
	
	return 0;
}

BERS_COMMAND( b_cmd_clear )
{
	BTextView *btv;
	
	if ( flags & 1 )
		btv = ((BChatWindow *)window)->content;
	else
		btv = server->content;
	
	c_btv_clear( btv );
	
	return 0;
}

BERS_COMMAND( b_cmd_close )
{
	if ( flags & 1 )
		c_close_widget( ((BChatWindow *)window)->window );
	else
		c_close_widget( server->window );
	
	return 0;
}

BERS_COMMAND( b_cmd_query )
{
	BChatWindow *chatwin;
	
	if ( pcount < 1 )
		return -1;
	
	chatwin = b_find_chat_by_dest( server, params[0] );
	
	if ( chatwin == NULL )
	{
		chatwin = b_new_chat_window( server, params[0], 0 );
	}
	
	return 0;
}

void b_restore_me( );

BERS_COMMAND( b_cmd_comefg )
{
	b_restore_me( );
	
	return 0;
}

BERS_COMMAND( b_cmd_ctcp )
{
	char *comd;
	
	if ( pcount < 2 )
		return -1;
	
	comd = origcmd + strlen( command ) + strlen( params[0] ) + 3;
	
	b_server_printf( server, "PRIVMSG %s :\1%s\1", params[0], comd );
	
	b_window_printf( b_active_window( ), BTV_CTCP, "-> [%s] %s", params[0], params[1] );
	
	return 0;
}

BERS_COMMAND( b_cmd_default )
{
	b_server_printf( server, "%s", origcmd+1 );
	
	return 0;
}

BERS_COMMAND( b_cmd_nick )
{
	if ( pcount < 1 )
		return -1;
	
	b_server_printf( server, "NICK %s", params[0] );
	
	return 0;
}

BERS_COMMAND( b_cmd_privmsg )
{
	char *message = NULL;
	char *dest = NULL;
	
	if ( pcount < 2 )
		return -1;
	
	message = origcmd;
	message += strlen( command ) + 2; // ignore the command, /, and space
	message += strlen( params[0] ) + 1; // ignore the destination and space
	
	dest = params[0];
	
	b_server_printf( server, "PRIVMSG %s :%s", dest, message );
	
	return 0;
}

BERS_COMMAND( b_cmd_raw )
{
	char *message = NULL;
	
	if ( pcount < 1 )
		return -1;
	
	message = origcmd;
	message += strlen( command ) + 2; // ignore the command, /, and space
	
	b_server_printf( server, "%s", message );
	
	return 0;
}

BERS_COMMAND( b_cmd_action )
{
	char *message = NULL;
	char *dest = NULL;
	
	if ( pcount < 2 )
		return -1;
	
	message = origcmd;
	message += strlen( command ) + 2; // ignore the command, /, and space
	message += strlen( params[0] ) + 1; // ignore the destination and space
	
	dest = params[0];
	
	b_server_printf( server, "PRIVMSG %s :\1ACTION %s\1", dest, message );
	
	return 0;
}

BERS_COMMAND( b_cmd_me )
{
	char *message = NULL;
	char *dest = NULL;
	
	if ( pcount < 1 )
		return -1;
	
	if ( !(flags & 1) )
		return -4;
	
	message = origcmd;
	message += strlen( command ) + 2; // ignore the command, /, and space
	
	dest = ((BChatWindow *)window)->dest;
	
	b_server_printf( server, "PRIVMSG %s :\1ACTION %s\1", dest, message );
	b_chatwin_printf( (BChatWindow *)window, BTV_Action, "* %s %s", server->nickname, message );
	
	return 0;
}


BERS_COMMAND( b_cmd_quickmode )
{
	char *channel = "";
	char *mode = "";
	char modes[256];
	char victims[256];
	int a = 0;
	
	strcpy( modes, "" );
	strcpy( victims, "" );
	
	if ( command[0] == 'd' && command[1] == 'e' )
		strcat( modes, "-" );
	else
		strcat( modes, "+" );
	
	if ( !strcasecmp( command, "op" ) )
		mode = "o";
	else if ( !strcasecmp( command, "deop" ) )
		mode = "o";
	else if ( !strcasecmp( command, "halfop" ) || !strcasecmp( command, "hop" ) )
		mode = "h";
	else if ( !strcasecmp( command, "dehalfop" ) || !strcasecmp( command, "dehop" ) )
		mode = "h";
	else if ( !strcasecmp( command, "voice" ) || !strcasecmp( command, "vop" ) )
		mode = "v";
	else if ( !strcasecmp( command, "devoice" ) || !strcasecmp( command, "devop" ) )
		mode = "v";
	
	if ( pcount == 0 )
	{
		if ( !( flags & 1 ) || ((BChatWindow *)window)->type != B_CMD_WINDOW_CHANNEL )
			return -1;
		
		strcpy( victims, server->nickname );
		strcat( modes, mode );
		channel = ((BChatWindow *)window)->dest;
	}
	else
	{
		if ( !( flags & 1 ) || ((BChatWindow *)window)->type != B_CMD_WINDOW_CHANNEL )
			return -1;
		
		channel = ((BChatWindow *)window)->dest;
		
		for ( a = 0; a < pcount; a++ )
		{
			strcat( modes, mode );
			
			if ( a != 0 )
				strcat( victims, " " );
				
			strcat( victims, params[a] );
		}
	}
	
	b_server_printf( server, "MODE %s %s %s", channel, modes, victims );
	
	return 0;
}

BERS_COMMAND( b_cmd_topic )
{
	char *channel = "";
	
	if ( pcount == 0 )
	{
		if ( !( flags & 1 ) || ((BChatWindow *)window)->type != B_CMD_WINDOW_CHANNEL )
			return -1;
		
		channel = ((BChatWindow *)window)->dest;
	}
	else
		channel = params[0];
	
	if ( pcount <= 1 )
		b_server_printf( server, "TOPIC %s", channel );
	else
	{
		b_server_printf( server, "TOPIC %s :%s", channel, origcmd + 1 + strlen( command ) + 1 + strlen( params[0] ) + 1 );
	}
	
	return 0;
}

BERS_COMMAND( b_cmd_cycle )
{
	char *channel = "";
	BChatWindow *cw;
	
	if ( pcount == 0 )
	{
		if ( !( flags & 1 ) || ((BChatWindow *)window)->type != B_CMD_WINDOW_CHANNEL )
			return -1;
		
		channel = ((BChatWindow *)window)->dest;
	}
	else
		channel = params[0];
	
	b_server_printf( server, "PART %s :Cycling channel", channel );
	
	cw = b_find_chat_by_dest( server, channel );
	
	if ( cw == NULL || !strcmp( cw->key, "" ) )
		b_server_printf( server, "JOIN %s", channel );
	else
		b_server_printf( server, "JOIN %s %s", channel, cw->key );
	
	return 0;
}

BERS_COMMAND( b_cmd_dns )
{
	char *res;
	
	if ( pcount == 0 )
		return -1;
	
	res = c_socket_hostname_to_ip( params[0] );
	
	if ( params[0] == res )
	{
		lang_phrase_parse( lang_tmp_buf, 1024, "unable_to_resolve", "addr", params[0], 0 );
		b_window_printf( window, BTV_Error, "%s", lang_tmp_buf );
	}
	else
		b_window_printf( window, BTV_Error, "* %s -> %s", params[0], res );
	
	return 0;
}

BERS_COMMAND( b_cmd_dcc )
{
	CSocket* curr;
	char* temp;
	int index = 0;
	
	int done, total, eta, now;
	double perDone, rate;
	
	int fileSize;
	
	char which = 0; // holds wether we display using M/K/B
	
	// Display DCC List
	if ( pcount == 0 || ( pcount == 1 && ( !strcasecmp( params[0], "LIST" ) ) ) )
	{
		c_btv_addline( server->content, "DCC: ", 0, BTV_Error );
		for ( curr = c_socket_list( ); curr != 0; curr = curr->next )
		{
			if ( curr->data == 0 )
				continue;
			
			temp = (char *)malloc( 512 );	

			if ( !temp )
				return 0;

			((struct DCCData*)curr->data)->index = index;
			
			sprintf( temp, "(%d) %s - ", ((struct DCCData*)curr->data)->index, ((struct DCCData*)curr->data)->name ); // (index) username
			
			// Send
			// (index) username SEND/RECV(Listening/Waiting): filename (X[m/k/b] of Y[m/k/b]) (X%) - ETA: 00:00:00 
			if ( ((struct DCCData*)curr->data)->state == 1 || ((struct DCCData*)curr->data)->state == 2 )
			{
				if( ((struct DCCData*)curr->data)->state == 1 )
					strcat( temp, "SEND( Listening ) : " );
				else
					strcat( temp, "SEND : " );
			}
			
			// Receive
			else
			{
				if( ((struct DCCData*)curr->data)->state == 3 )
					strcat( temp, "RECV( Waiting ) : " );
				else
					strcat( temp, "RECV : " );
			}
			
			if ( ((struct DCCData*)curr->data)->fileSize / 1048576 < 2 )
			{
				if ( ((struct DCCData*)curr->data)->fileSize / 1024 < 2 ) // Bytes
				{
					which = 'B';
					done = ((struct DCCData*)curr->data)->position;
					total = ((struct DCCData*)curr->data)->fileSize;
				}
				else // Kilos
				{
					which = 'K';
					done = ((struct DCCData*)curr->data)->position/1024;
					total = ((struct DCCData*)curr->data)->fileSize/1024;
				}
			}
			else // Megs
			{
				which = 'M';
				done = ((struct DCCData*)curr->data)->position/1048576;
				total = ((struct DCCData*)curr->data)->fileSize/1048576;
			}
			perDone = ((struct DCCData*)curr->data)->position/(double)((struct DCCData*)curr->data)->fileSize * 100;
			
			sprintf( temp, "%s%s (%u%c of %u%c)(%.1f%%) ", temp, ((struct DCCData*)curr->data)->file, done, which, total, which, perDone );
			
			if ( ((struct DCCData*)curr->data)->state == 2 || ((struct DCCData*)curr->data)->state == 4 )
			{
				now = ( time( 0 ) - ((struct DCCData*)curr->data)->startTime <= 0 ) ? 1 : time( 0 ) - ((struct DCCData*)curr->data)->startTime;
				rate = ((struct DCCData*)curr->data)->position/(double)now;
				if ( rate < 1.0 )
					rate = 1.0;
				eta = ( ((struct DCCData*)curr->data)->fileSize - ((struct DCCData*)curr->data)->position ) / (int)rate;
			
				sprintf( temp, "%s- %.2fKB/s - ETA: %02d:%02d:%02d", temp, rate/1024.0, eta/3600, (eta/60)%60, eta%60 );
			}
			
			// Output to screen:
			// b_window_printf( window, "%s", temp );
			c_btv_addline( server->content, temp, 0, BTV_Error );
			
			free( temp );
			index++;
		}
		return 0;
	}
	
	// Send File
	else if ( pcount >= 3 && !strcasecmp( params[0], "SEND" ) )
	{
		FILE *file;
		char *myaddr;
		int port;
		CSocket *sock;
		char *filename;
		char *ptr;
		
		filename = params[2];
		
		// open the file with the full filename specified
		file = fopen( params[2], "rb" );
		
		// now trim it to find the actual filename
		
		// find the last '\', if we find one, everything after is our new filename
		if ( ( ptr = strrchr( filename, '\\' ) ) != 0 )
			filename = ptr + 1;
		
		// find the last '/', if we find one, everything after is our new filename
		if ( ( ptr = strrchr( filename, '/' ) ) != 0 )
			filename = ptr;
		
		if ( file == 0 )
			return -4;
		
		fseek( file, 0, SEEK_END );
		fileSize = ftell( file );
		fclose( file );
		
		srand( time( 0 ) );
		port = ( rand() % 3701 ) + 1300;
		
		myaddr = strdup( c_socket_hostname_to_ip( server->user_hostname ) );
		b_server_printf( server, "PRIVMSG %s :\1DCC SEND %s %u %u %u \1", params[1], filename, htonl( inet_addr( myaddr ) ), port, fileSize );
		free( myaddr );
		
		sock = c_socket_create();
		c_socket_set_handler( sock, C_SOCK_CLIENTWAITING, &dcc_send_init );
		c_socket_set_handler( sock, C_SOCK_DISCONNECTED, &dcc_donothing );
		c_socket_set_handler( sock, C_SOCK_LISTENING, &dcc_donothing );
		c_socket_listen( sock, port );
		
		sock->data = (struct DCCData*)malloc( sizeof( struct DCCData ) );
		((struct DCCData*)sock->data)->file = malloc( 256 );
		strcpy( ((struct DCCData*)sock->data)->file, params[2] );
		((struct DCCData*)sock->data)->fileSize = fileSize;
		((struct DCCData*)sock->data)->position = 0;
		((struct DCCData*)sock->data)->dpacketSize = 4096; // user will (soon) specify this in the options menu
		((struct DCCData*)sock->data)->packetSize = 0;
		((struct DCCData*)sock->data)->state = 1;
		((struct DCCData*)sock->data)->index = -1;
		((struct DCCData*)sock->data)->name = malloc( 64 );
		strcpy( ((struct DCCData*)sock->data)->name, params[1] );
		
		return 0;
	}
	
	// Receive File (indexed from DCC List)
	else if ( pcount == 2 && ( !strcasecmp( params[0], "RECV" ) || !strcasecmp( params[0], "GET" ) ) )
	{
		// Here we go:
		CSocket* curr;
		char* temp;
		int index; // = atoi( params[1] );
		char *snick = "";
		
		index = -1;
		
		sscanf( params[1], "%d", &index );
		
		if ( index < 0 )
		{
			// assume nickname instead of index
			snick = params[1];
		}

		temp = (char *)malloc( 256 );

		if ( !temp )
			return 0;
		
		for ( curr = c_socket_list( ); curr != 0; curr = curr->next )
		{
			if( curr->data == 0 )
				continue;
			
			if ( ((struct DCCData*)curr->data)->state != 3 )
				continue;
			
			if ( ((struct DCCData*)curr->data)->index == index || !strcasecmp( ((struct DCCData*)curr->data)->name, snick ) )
			{
				dcc_recv_init( curr );
				sprintf( temp, "DCC Recv from %s of %s: Accepted", ((struct DCCData*)curr->data)->name, ((struct DCCData*)curr->data)->file );		
				c_btv_addline( server->content, temp, 0, BTV_Error );
				free( temp );
				return 0;
			}
		}
		sprintf( temp, "Invalid index, run \"/dcc list\" to retrieve the list." );
		c_btv_addline( server->content, temp, 0, BTV_Error );
		free( temp );
		return 0;
	}
	
	// Close DCC Send/Receive (indexed from DCC List)
	else if ( pcount == 2 && !strcasecmp( params[0], "CLOSE" ) )
	{
		CSocket* curr;
		char* temp;
		int index; // = atoi( params[1] );
		char *snick = "";
		
		index = -1;
		
		sscanf( params[1], "%d", &index );
		
		if ( index < 0 )
		{
			// assume nickname instead of index
			snick = params[1];
		}

		temp = (char *)malloc( 256 );

		if ( !temp )
			return 0;
		
		for ( curr = c_socket_list( ); curr != 0; curr = curr->next )
		{
			if( curr->data == 0 )
				continue;
				
			if ( ((struct DCCData*)curr->data)->index == index || !strcasecmp( ((struct DCCData*)curr->data)->name, snick ) )
			{
				if ( ((struct DCCData*)curr->data)->state == 1 || ((struct DCCData*)curr->data)->state == 2 )
					sprintf( temp, "DCC Send to %s of %s closed", ((struct DCCData*)curr->data)->name, ((struct DCCData*)curr->data)->file );
				else
					sprintf( temp, "DCC Recv from %s of %s closed", ((struct DCCData*)curr->data)->name, ((struct DCCData*)curr->data)->file );
				
				c_btv_addline( server->content, temp, 0, BTV_Error );
				dcc_close( curr );
				free( temp );
				return 0;
			}
		}
		sprintf( temp, "Invalid index, run \"/dcc list\" to retrieve the list." );
		c_btv_addline( server->content, temp, 0, BTV_Error );
		free( temp );
		return 0;
	}
	
	return -4;
}

BERS_COMMAND( b_msg_operwall )
{
	char *message;
	
	message = origcmd;
	message += strlen( command ) + 2; // ignore the command, /, and space
	
	b_server_printf( server, "OPERWALL :%s", message );
}








BERS_COMMAND( b_cmd_exit )
{
	c_shutdown( );
	return 0;
}

BERS_COMMAND( b_cmd_newstatus )
{
	b_new_server_window( 0 );
	return 0;
}

BERS_COMMAND( b_cmd_dccwin )
{
	b_open_dccwin( );
	return 0;
}

BERS_COMMAND( b_cmd_urlwin )
{
	b_open_urlwin( );
	return 0;
}

BERS_COMMAND( b_cmd_joinwin )
{
	b_open_joinwin( );
	return 0;
}

BERS_COMMAND( b_cmd_profile )
{
	b_open_profile( );
	return 0;
}

BERS_COMMAND( b_cmd_netbrowse )
{
	b_open_netbrowser( );
	return 0;
}

BERS_COMMAND( b_cmd_savetext )
{
	BTextView *btv;
	BTVLine *lines;
	int a, b;
	CWidget *n;

	if ( flags & 1 )
		btv = ((BChatWindow *)window)->content;
	else
		btv = server->content;

	if ( btv == 0 )
		return 0;

	lines = btv->lines_data;
	a = btv->lines_num;

	if ( a == 0 )
		return 0;

	n = c_new_choosefile( mainwin );
	c_choosefile_set_filter( n, "Bersirc Logs (*.log; *.txt)\0*.log; *.txt\0All Files (*.*)\0*.*\0" );

	if ( c_choosefile_save( n ) == 0 )
	{
		c_destroy_widget( n, 1 );
		return 0;
	}
	else
	{
		FILE *fp;
		char time_fmt[128], *txt;
		time_t logtime;

		txt = (char *)malloc( 256 );

		if ( !txt )
			return 0;

		sprintf( time_fmt, "%s", b_get_option_string( xidentity, "time", "opt_time_line_timestamp" ) );

		if ( !( fp = fopen( c_choosefile_get_filename( n ), "w" ) ) )
		{
			free( txt );
			c_destroy_widget( n, 1 );
			return 0;
		}
	
		for ( b = 0; b < a; b++ )
		{
			if ( strcmp(time_fmt,"") != 0 )
			{
				logtime = lines[b].time;
				strftime( txt, 256, time_fmt, localtime( &logtime ) );
				fprintf( fp, "%s ", txt );
			}
			fprintf( fp, "%s", lines[b].text );

			#ifdef ENV_WIN32
				fprintf( fp, "%s", "\r\n" );
			#else
				fprintf( fp, "%s", "\n" );
			#endif
		}

		fclose( fp );
		free( txt );
	}
	
	c_destroy_widget( n, 1 );
	
	return 0;
}

BERS_COMMAND( b_cmd_go )
{
	if ( pcount < 1 )
		return -1;
	
	c_open_browser( c_application, params[0] );
	
	return 0;
}

BERS_COMMAND( b_cmd_connectwin )
{
	int flag;
	
	flag = 0;
	
	if ( pcount > 0 )
	{
		if ( !strcasecmp( params[0], "-network" ) )
			flag = 1;
	}
	
	b_open_conto( flag );
	
	return 0;
}

BERS_COMMAND( b_cmd_tile )
{
	int or;
	
	or = C_WORKSPACE_TILE_HORIZ;
	
	if ( pcount > 0 )
	{
		if ( !strcasecmp( params[0], "-v" ) )
			or = C_WORKSPACE_TILE_VERT;
	}
	
	c_workspace_tile( workspace, or );
	
	return 0;
}

BERS_COMMAND( b_cmd_casc )
{
	c_workspace_cascade( workspace );
	return 0;
}

BERS_COMMAND( b_cmd_options )
{
	b_open_options( );
	return 0;
}

BERS_COMMAND( b_cmd_chanstats )
{
	int a, b, c;
	char sa[16], sb[16], sc[16];
	BUserStore *curr;
	BChatWindow *chatwin = (BChatWindow *)window;
	
	if ( chatwin->type != B_CMD_WINDOW_CHANNEL )
	{
		b_window_printf( server, BTV_Info, lang_phrase_quick( "cmd_only_channel" ) );
		return 0;
	}
	
	if ( server->connected != 1 )
	{
		b_chatwin_printf( chatwin, BTV_Info, lang_phrase_quick( "not_connected" ) );
		return 0;
	}
	
	if ( chatwin->parted == 1 )
	{
		b_chatwin_printf( chatwin, BTV_Info, lang_phrase_quick( "not_in_channel" ) );
		return 0;
	}
	
	a = b = c = 0;
	
	for ( curr = chatwin->users; curr != 0; curr = curr->next )
	{
		c++; // users
		
		if ( strchr( curr->modes, 'o' ) != NULL )
			a++; // ops
		else
			b++; // non-ops
	}
	
	sprintf( sa, "%d", a );
	sprintf( sb, "%d", b );
	sprintf( sc, "%d", c );
	
	lang_phrase_parse( lang_tmp_buf, 1024, "chanstats", "numops", sa, "numusers", sb, "users", sc, 0 );
	b_chatwin_printf( chatwin, BTV_Topic, "%s", lang_tmp_buf );
	
	return 0;
}

BERS_COMMAND( b_cmd_about )
{
	b_open_aboutwin( );
	return 0;
}

BERS_COMMAND( b_cmd_autowin )
{
	b_open_autowin( );
	return 0;
}

//
