/*************************************************************************
$Id: checkbox.c 106 2005-08-10 00:17:32Z terminal $

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

void c_checkbox_handle_create( CEvent *e, void *data )
{
	CCheckBoxWidgetInfo *bwi = (CCheckBoxWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;

	if ( !( hwnd = CreateWindowEx( 0, "BUTTON", 
	                               bwi->text,
	                               WS_CHILD | WS_TABSTOP | BS_CHECKBOX,
	                               bwi->info.x, bwi->info.y,
	                               0, 0, 
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create checkbox HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;
	
	c_checkbox_checked( e->caller, ((CCheckBoxWidgetInfo *)e->caller->info)->checked );
	
	c_widget_install( e->caller );
	
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );
#endif

	printf("c_checkbox_handle_create( )\n");
}

void c_checkbox_handle_update( CEvent *e, void *data )
{
	CCheckBoxWidgetInfo *bwi = (CCheckBoxWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	char *text = bwi->text;
	HDC hdc;
	SIZE sz;
	int w, h;
	char *copy;
		
	hwnd = (HWND)bwi->info.widget;
	
	copy = (char *)malloc( strlen( text ) + 2 );
	strcpy( copy, text );
	strcat( copy, " " ); // meh
	SetWindowText( hwnd, copy );
	
	text = copy;
	
	w = bwi->info.width;
	h = bwi->info.height;
	
	if ( w == -1 || h == -1 )
	{
		// either width or height needs to be guessed :-)
		
		hdc = GetDC( hwnd );
		SelectObject( hdc, (HFONT)SendMessage( hwnd, WM_GETFONT, 0, 0 ) );
		
		if ( GetTextExtentPoint32( hdc, text, strlen( text ), &sz ) == 0 )
			printf( "Warning: could not determine font metrics (GetLastError()=%d)!\n", (int)GetLastError() );
		
		// set whichever
		if ( w == -1 )
			w = sz.cx;
		if ( h == -1 )
			h = sz.cy;
	}
	
	MoveWindow( hwnd, bwi->info.x, bwi->info.y, w, h, 1 );
	UpdateWindow( hwnd );
	
	free( copy );
#endif
	printf( "c_checkbox_handle_update( )\n" );
	
	c_send_event( e->caller, C_EVENT_DRAW, 0 );
}

void c_checkbox_checked( CWidget *w, int checked )
{
#ifdef ENV_WIN32
	if ( w->info->widget != 0 )
		SendMessage( w->info->widget, BM_SETCHECK, (checked==1?BST_CHECKED:BST_UNCHECKED), 0 );
	((CCheckBoxWidgetInfo *)w->info)->checked = checked;
#endif
}

CWidget *c_new_checkbox( CWidget *parent, char *text, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CCheckBoxWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_CHECKBOX;
	w->info->x = x;
	w->info->y = y;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	w->info->visible = 1;
	((CCheckBoxWidgetInfo *)w->info)->text = text;
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_checkbox_handle_create );
	c_new_event_handler( w, C_EVENT_UPDATE, c_checkbox_handle_update );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
