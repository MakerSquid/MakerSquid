/*************************************************************************
$Id: label.c 115 2005-08-31 00:18:56Z terminal $

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

void c_label_handle_create( CEvent *e, void *data )
{
	CLabelWidgetInfo *lwi = (CLabelWidgetInfo *)e->caller->info;
#ifdef ENV_GTK
	GtkWidget *label;

	printf("Creating label which says: %s at %d, %d\n", lwi->text, lwi->info.x, lwi->info.y);

	label = gtk_label_new (lwi->text);

	/*if(lwi->info.width != -1 && lwi->info.height != -1)
		gtk_widget_set_size_request(GTK_WIDGET(label), lwi->info.width, lwi->info.height);*/

	gtk_layout_put (GTK_LAYOUT (e->caller->parent->info->widget),
		       label,
		       lwi->info.x,
		       lwi->info.y);

	lwi->info.widget = label;

	gtk_widget_show( label );

	c_send_event( e->caller, C_EVENT_UPDATE, 0 );
#endif

#ifdef ENV_CARBON
	CFStringRef str;
	
	Rect boundsButton = { 0, 0, 0, 0 };
	
	boundsButton.left = lwi->info.x;
	boundsButton.top = lwi->info.y;
	
	if ( lwi->info.width == -1 )
		boundsButton.right = boundsButton.left + 100;
	else
		boundsButton.right = boundsButton.left + lwi->info.width;
	
	if ( lwi->info.height == -1 )
		boundsButton.bottom = boundsButton.top + 15;
	else
		boundsButton.bottom = boundsButton.top + lwi->info.height;
	
	str = CFStringCreateWithCString( NULL, lwi->text, strlen( lwi->text ) );
	
	if ( ( CreateStaticTextControl( e->caller->parent->info->widget, &boundsButton, str, ((CFont *)e->caller->font)->cfont, &e->caller->info->widget ) != noErr )
	        || ( e->caller->info->widget == NULL ) )     ExitToShell();

	CFRelease( str );

	c_widget_install( e->caller );
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;
	
	if ( !( hwnd = CreateWindowEx( 0, "STATIC", 
	                               lwi->text,
	                               WS_CHILD | SS_LEFTNOWORDWRAP,
	                               lwi->info.x, lwi->info.y,
	                               0, 0, 
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create label HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;
	
	c_font_fix( e->caller );
//	SendMessage( hwnd, WM_SETFONT, (WPARAM)w32_font, true );
	
	ShowWindow( hwnd, SW_SHOW );
	UpdateWindow( hwnd );
	
	c_widget_update_enable( e->caller );
	
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );
#endif

	printf("c_label_handle_create( )\n");
}

void c_label_settext( CWidget *who, char *text )
{
	if(!text) {
		fprintf(stderr, "WARNING: [MINOR] Action attempted to set null label text\n");
		return;
	}
	
	free( ((CLabelWidgetInfo *)who->info)->text );
	((CLabelWidgetInfo *)who->info)->text = strdup( text );
	c_send_event( who, C_EVENT_UPDATE, 0 );
}

void c_label_handle_update( CEvent *e, void *data )
{
	CLabelWidgetInfo *lwi = (CLabelWidgetInfo *)e->caller->info;
#ifdef ENV_GTK
	if(lwi->info.visible)
		gtk_widget_set_child_visible(lwi->info.widget, TRUE);
	else {
		gtk_widget_set_child_visible(lwi->info.widget, FALSE);
	}

	gtk_label_set_text(GTK_LABEL(lwi->info.widget), lwi->text);

	gtk_layout_move ((GtkLayout *)e->caller->parent->info->widget,
			lwi->info.widget,
			lwi->info.x,
			lwi->info.y);

	if(lwi->info.width != -1 && lwi->info.height != -1)
		gtk_widget_set_size_request(GTK_WIDGET(lwi->info.widget), lwi->info.width, lwi->info.height);
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	char *text = lwi->text;
	HDC hdc;
	SIZE sz;
	int w, h;
	char *copy;
		
	hwnd = (HWND)lwi->info.widget;
	
	copy = (char *)malloc( strlen( text ) + 2 );
	strcpy( copy, text );
	strcat( copy, " " ); // meh
	SetWindowText( hwnd, copy );
	
	text = copy;
	
	w = lwi->info.width;
	h = lwi->info.height;
	
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
	
	MoveWindow( hwnd, lwi->info.x, lwi->info.y, w, h, 1 );
	UpdateWindow( hwnd );
	
	free( copy );
#endif
	printf( "c_label_handle_update( )\n" );
	
	c_send_event( e->caller, C_EVENT_DRAW, 0 );
}


CWidget *c_new_label( CWidget *parent, char *text, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CLabelWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_LABEL;
	w->info->x = x;
	w->info->y = y;
	w->info->visible = 1;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	((CLabelWidgetInfo *)w->info)->text = strdup( text );
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_label_handle_create );
	c_new_event_handler( w, C_EVENT_UPDATE, c_label_handle_update );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
