/*************************************************************************
$Id: groupbox.c 115 2005-08-31 00:18:56Z terminal $

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

void c_groupbox_handle_create( CEvent *e, void *data )
{
	CGroupBoxWidgetInfo *gwi = (CGroupBoxWidgetInfo *)e->caller->info;
#ifdef ENV_GTK
#endif

#ifdef ENV_CARBON
	Rect bounds;
	
	bounds.left = gwi->info.x;
	bounds.right = gwi->info.x + gwi->info.width;
	bounds.top = gwi->info.y;
	bounds.bottom = gwi->info.y + gwi->info.height;
	
	CreateUserPaneControl( e->caller->parent->info->widget, &bounds, kControlSupportsEmbedding, &gwi->pcontrol );
	e->caller->info->widget = e->caller->parent->info->widget;
	
	c_widget_install( e->caller );
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;
	
	if ( !( hwnd = CreateWindowEx( 0, "BUTTON", 
	                               gwi->text,
	                               WS_CHILD | BS_GROUPBOX | WS_GROUP | WS_TABSTOP,
	                               gwi->info.x, gwi->info.y,
	                               gwi->info.width, gwi->info.height, 
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create groupbox HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;
	
	c_widget_install( e->caller );
	
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );
#endif

	printf("c_groupbox_handle_create( )\n");
}

void c_groupbox_settext( CWidget *who, char *text )
{
	if(!text) {
		fprintf(stderr, "WARNING: [MINOR] Action attempted to set null groupbox text\n");
		return;
	}
	
	free( ((CGroupBoxWidgetInfo *)who->info)->text );
	((CGroupBoxWidgetInfo *)who->info)->text = strdup( text );
	c_send_event( who, C_EVENT_UPDATE, 0 );
}

void c_groupbox_handle_update( CEvent *e, void *data )
{
	CGroupBoxWidgetInfo *gwi = (CGroupBoxWidgetInfo *)e->caller->info;
#ifdef ENV_GTK

#endif

#ifdef ENV_WIN32
	HWND hwnd;
	char *text = gwi->text;
		
	hwnd = (HWND)gwi->info.widget;
	
	SetWindowText( hwnd, text );

	MoveWindow( hwnd, gwi->info.x, gwi->info.y, gwi->info.width, gwi->info.height, 1 );
	UpdateWindow( hwnd );
#endif
	printf( "c_groupbox_handle_update( )\n" );
	
	c_send_event( e->caller, C_EVENT_DRAW, 0 );
}


CWidget *c_new_groupbox( CWidget *parent, char *text, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CGroupBoxWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_GROUPBOX;
	w->info->x = x;
	w->info->y = y;
	w->info->visible = 1;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	((CGroupBoxWidgetInfo *)w->info)->text = strdup( text );
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_groupbox_handle_create );
	c_new_event_handler( w, C_EVENT_UPDATE, c_groupbox_handle_update );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
