/*************************************************************************
$Id: systrayicon.c 106 2005-08-10 00:17:32Z terminal $

Claro - A cross platform GUI toolkit which "makes sense".
Copyright (C) 2004 Theo Julienne and Gian Perrone

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
**************************************************************************/

#include "../../include/includes.h"

int c_systrayicon_number = 0xFF00;
/*
void c_systrayicon_popup_info( CWidget *w, char *title, char *text )
{
	CSysTrayIconWidgetInfo *swi = (CSysTrayIconWidgetInfo *)w->info;
	
#ifdef ENV_WIN32
	NOTIFYICONDATA tnid;
	HWND hwnd_parent = w->parent->info->widget;
	
	tnid.cbSize = sizeof( NOTIFYICONDATA );
	tnid.hWnd = hwnd_parent;
	tnid.uID = swi->id;
	tnid.uFlags = NIF_INFO;
	tnid.uTimeout = 15000;
	
	strcpy( tnid.szInfo, text );
	
	Shell_NotifyIcon( NIM_MODIFY, &tnid );
#endif
}*/

void c_systrayicon_handle_create( CEvent *e, void *data )
{
	CSysTrayIconWidgetInfo *swi = (CSysTrayIconWidgetInfo *)e->caller->info;
	
	swi->id = c_systrayicon_number;
	c_systrayicon_number++;

#ifdef ENV_GTK
#endif

#ifdef ENV_WIN32
	HWND hwnd_parent = e->caller->parent->info->widget;
	BOOL res;
	NOTIFYICONDATA tnid;
	
	tnid.cbSize = sizeof( NOTIFYICONDATA );
	tnid.hWnd = hwnd_parent;
	tnid.uID = swi->id;
	tnid.uFlags = NIF_MESSAGE | NIF_ICON | NIF_TIP;
	tnid.uCallbackMessage = C_WM_SYSTRAYICON_ACTION;
	tnid.hIcon = swi->icon->icon;
	
	strcpy( tnid.szTip, swi->tooltip );
	
	res = Shell_NotifyIcon( NIM_ADD, &tnid );
	
	e->caller->info->widget = 0;
#endif

	//c_systrayicon_popup_info( e->caller, "Hello", "World" );

	printf("c_systrayicon_handle_create( )\n");
}

void c_systrayicon_handle_destroy( CEvent *e, void *data )
{
	CSysTrayIconWidgetInfo *swi = (CSysTrayIconWidgetInfo *)e->caller->info;
	
#ifdef ENV_WIN32
	NOTIFYICONDATA tnid;
	HWND hwnd_parent = e->caller->parent->info->widget;
	
	tnid.cbSize = sizeof( NOTIFYICONDATA );
	tnid.hWnd = hwnd_parent;
	tnid.uID = swi->id;
	
	Shell_NotifyIcon( NIM_DELETE, &tnid );
	
	free( swi->tooltip );
#endif
}

CWidget *c_new_systrayicon( CWidget *parent, char *tooltip, ClaroIcon *icon, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CSysTrayIconWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_SYSTRAYICON;
	w->info->x = 0;
	w->info->y = 0;
	w->info->width = 0;
	w->info->height = 0;
	w->info->flags = flags;
	w->info->visible = 1;
	((CSysTrayIconWidgetInfo *)w->info)->icon = icon;
	((CSysTrayIconWidgetInfo *)w->info)->tooltip = strdup( tooltip );
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_systrayicon_handle_create );
	c_new_event_handler( w, C_EVENT_DESTROY, c_systrayicon_handle_destroy );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
