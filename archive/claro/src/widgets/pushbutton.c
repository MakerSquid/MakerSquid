/*************************************************************************
$Id: pushbutton.c 106 2005-08-10 00:17:32Z terminal $

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

void c_pushbutton_settext( CWidget *w, char *text )
{
	// reallocate text memory.
	((CButtonWidgetInfo *)w->info)->text = realloc( ((CButtonWidgetInfo *)w->info)->text, strlen( text ) + 1 );
	
	strcpy( ((CButtonWidgetInfo *)w->info)->text, text );
	
	c_send_event( w, C_EVENT_UPDATE, 0 );
}

#ifdef ENV_GTK
static void c_pushbutton_catch_event( GtkWidget *widget, gpointer data )
{
	CWidget *w = (CWidget *)data;

	printf( "c_pushbutton_catch_event()\n" );

	c_send_event( w, C_EVENT_BUTTON_PRESS, 0 );
}
#endif

#ifdef ENV_CARBON
pascal OSStatus cPushButtonHandler( EventHandlerCallRef nextHandler, EventRef theEvent, CWidget *widget )
{
	c_send_event( widget, C_EVENT_BUTTON_PRESS, 0 );
}
#endif

void c_pushbutton_handle_create( CEvent *e, void *data )
{
	CButtonWidgetInfo *bwi = (CButtonWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
	GtkWidget *button;

	button = gtk_button_new_with_label (bwi->text);

	gtk_widget_set_size_request(GTK_WIDGET(button), bwi->info.width, bwi->info.height);

	g_signal_connect (G_OBJECT (button), "clicked",
		      G_CALLBACK (c_pushbutton_catch_event), (gpointer)e->caller);

	gtk_layout_put( GTK_LAYOUT (e->caller->parent->info->widget),
		       button,
		       bwi->info.x,
		       bwi->info.y );
		      
	gtk_widget_show( button );

	bwi->info.widget = button;
#endif

#ifdef ENV_CARBON
	CFStringRef str;
	
	Rect boundsButton = { 0, 0, 0, 0 };
	
	boundsButton.left = bwi->info.x;
	boundsButton.top = bwi->info.y;
	
	if ( bwi->info.width == -1 )
		boundsButton.right = boundsButton.left + 100;
	else
		boundsButton.right = boundsButton.left + bwi->info.width;
	
	if ( bwi->info.height == -1 )
		boundsButton.bottom = boundsButton.top + 15;
	else
		boundsButton.bottom = boundsButton.top + bwi->info.height;
	
	str = CFStringCreateWithCString( NULL, bwi->text, strlen( bwi->text ) );
	
	if ( ( CreatePushButtonControl( e->caller->parent->info->widget, &boundsButton, str, &e->caller->info->widget ) != noErr )
	        || ( e->caller->info->widget == NULL ) )     ExitToShell();
	
	EventTypeSpec eventTypeList[] =  { { kEventClassControl, kEventControlHit } };
	InstallEventHandler( GetControlEventTarget( e->caller->info->widget ), NewEventHandlerUPP( cPushButtonHandler ), 1, eventTypeList, e->caller, NULL );
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;

	if ( !( hwnd = CreateWindowEx( 0, "BUTTON", 
	                               bwi->text,
	                               WS_CHILD | WS_TABSTOP | BS_PUSHBUTTON,
	                               bwi->info.x, bwi->info.y,
	                               0, 0, 
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create pushbutton HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;
	
	c_font_fix( e->caller );
	//SendMessage( hwnd, WM_SETFONT, (WPARAM)w32_font, true );
	
	ShowWindow( hwnd, SW_SHOW );
	UpdateWindow( hwnd );
#endif

	c_widget_install( e->caller );
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );

	printf("c_pushbutton_handle_create( )\n");
}

void c_pushbutton_handle_update( CEvent *e, void *data )
{
	CButtonWidgetInfo *bwi = (CButtonWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
	if(bwi->info.visible)
		gtk_widget_set_child_visible(bwi->info.widget, TRUE);
	else {
		gtk_widget_set_child_visible(bwi->info.widget, FALSE);
	}

	gtk_layout_move ((GtkLayout *)e->caller->parent->info->widget,
			bwi->info.widget,
			bwi->info.x,
			bwi->info.y);

	if(bwi->info.width != -1 && bwi->info.height != -1)
		gtk_widget_set_size_request(GTK_WIDGET(bwi->info.widget), bwi->info.width, bwi->info.height);

	gtk_button_set_label((GtkButton *)bwi->info.widget, bwi->text);
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
		
		if ( !( bwi->info.flags & C_BORDER_NONE ) )
			sz.cy += C_W32_TOTALYOFFSET_NOCAP;
		
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
	printf( "c_pushbutton_handle_update( )\n" );
	
	c_send_event( e->caller, C_EVENT_DRAW, 0 );
}


CWidget *c_new_pushbutton( CWidget *parent, char *text, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CButtonWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_BUTTON;
	w->info->x = x;
	w->info->y = y;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	w->info->visible = 1;
	c_pushbutton_settext( w, text );
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_pushbutton_handle_create );
	c_new_event_handler( w, C_EVENT_UPDATE, c_pushbutton_handle_update );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
