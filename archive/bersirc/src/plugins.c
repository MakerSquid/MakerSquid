/*************************************************************************
$Id: plugins.c 69 2005-05-08 06:06:55Z terminal $

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

#ifndef ENV_WIN32
#include <dlfcn.h>
#endif

BersircPlugin *plg_head = 0;

int b_window_printf( void *win, int colour, char *fmt, ... )
{
	int *wintype = win;
	va_list args;
	char buf[16384];
	
	va_start( args, fmt );
	vsprintf( buf, fmt, args );
	va_end( args );
	
	if ( *wintype == B_CMD_WINDOW_STATUS )
		return b_swindow_printf( win, colour, "%s", buf );
	else
		return b_chatwin_printf( win, colour, "%s", buf );
}

void *b_active_window(  )
{
	CWidget *w;
	void *sw, *cw;
	
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
		return cw;
	
	return 0;
}

int BPTYPE b_plugin_message( BersircPlugin *plugin, int message, void *data )
{
	char **loc;
	BersircPluginWrite *bpw;
	BersircPluginCommand *bpc;
	
	switch ( message )
	{
		case B_MSG_APP_WIN_ACTIVE:
			loc = data;
			*loc = (char *)b_active_window( );
			break;
		case B_MSG_APP_WRITE:
			bpw = data;
			b_window_printf( bpw->window, bpw->colour, "%s", bpw->text );
			break;
		case B_MSG_APP_COMMAND_ADD:
			bpc = data;
			b_register_command( bpc->command, bpc->function, bpc->flags );
			break;
		default:
			return 0;
	}
	
	return 1;
}

int b_plugin_send( BersircPlugin *plugin, int message, void *data )
{
	return (*plugin->handler)( plugin, message, data );
}

int b_plugin_load( char *filename )
{
	BersircPlugin plg, *ptmp;
	
	memset( &plg, 0, sizeof( BersircPlugin ) );
		
#ifdef ENV_WIN32
	plg.plugin = LoadLibrary( filename );
#else
	plg.plugin = dlopen( filename, RTLD_LAZY );
#endif
	
	if ( plg.plugin == 0 )
		return 0;
	
#ifdef ENV_WIN32
	plg.handler = GetProcAddress( plg.plugin, "Message" );
#else
	plg.handler = dlsym( plg.plugin, "Message" );
#endif
	
	plg.init.handler = (BPHANDLER)&b_plugin_message;
	
	if ( plg.handler == 0 || b_plugin_send( &plg, B_MSG_PLG_INIT, &plg.init ) != 1 )
	{
#ifdef ENV_WIN32
		FreeLibrary( plg.plugin );
#else
		dlclose( plg.plugin );
#endif
		return 0;
	}
	
	// all worked.. let's save this plugin.
	
	ptmp = (BersircPlugin *)malloc( sizeof(BersircPlugin) );
	
	memcpy( ptmp, &plg, sizeof(BersircPlugin) );
	
	ptmp->next = plg_head;
	if ( plg_head != 0 )
		plg_head->prev = ptmp;
	plg_head = ptmp;
	
	
	
	return 1;
}

//
