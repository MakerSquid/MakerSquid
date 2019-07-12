/*************************************************************************
$Id$

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

void c_image_handle_create( CEvent *e, void *data )
{
	CImageWidgetInfo *lwi = (CImageWidgetInfo *)e->caller->info;

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;
	
	if ( !( hwnd = CreateWindowEx( 0, "STATIC", 
	                               "",
	                               WS_CHILD | SS_BITMAP,
	                               lwi->info.x, lwi->info.y,
	                               lwi->info.width, lwi->info.height,
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create image HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;
	
	SendMessage( hwnd, STM_SETIMAGE, IMAGE_BITMAP, (LPARAM)((CImageWidgetInfo *)e->caller->info)->im );
	
	ShowWindow( hwnd, SW_SHOW );
	UpdateWindow( hwnd );
	
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );
#endif

	printf("c_image_handle_create( )\n");
}

CWidget *c_new_image( CWidget *parent, char *filename, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CImageWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_IMAGE;
	w->info->x = x;
	w->info->y = y;
	w->info->visible = 1;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	
#ifdef ENV_WIN32
	((CImageWidgetInfo *)w->info)->im = LoadImage( 0, filename, IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE );
#endif
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_image_handle_create );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
