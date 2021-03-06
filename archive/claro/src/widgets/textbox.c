/*************************************************************************
$Id: textbox.c 115 2005-08-31 00:18:56Z terminal $

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

void c_text_settext( CWidget *w, char *text )
{
	strcpy( ((CTextBoxWidgetInfo *)w->info)->text, text );
	
	c_send_event_now( w, C_EVENT_UPDATE, 0 );
}

void c_text_setsel( CWidget *w, int start, int end )
{
#ifdef ENV_WIN32
	SendMessage( w->info->widget, EM_SETSEL, start, end );
	SendMessage( w->info->widget, EM_SCROLLCARET, 0, 0 );
#endif
}

void c_text_handle_update( CEvent *e, void *data );

#ifdef ENV_GTK
static void c_text_catch_event( GtkWidget *widget, gpointer data )
{
	CWidget *w = (CWidget *)data;
	CTextBoxWidgetInfo *twi = (CTextBoxWidgetInfo *)w->info;

	printf( "c_text_catch_event()\n" );

	strcpy( twi->text, gtk_editable_get_chars(GTK_EDITABLE(twi->info.widget), 0, -1) );

	printf("Currently in the text box: %s\n", gtk_editable_get_chars(GTK_EDITABLE(twi->info.widget), 0, -1));

	c_send_event( w, C_EVENT_TEXT_CHANGED, 0 );
}

static void c_text_catch_activate( GtkWidget *widget, gpointer data )
{
	CWidget *w = (CWidget *)data;
	CTextBoxWidgetInfo *twi = (CTextBoxWidgetInfo *)w->info;

	strcpy( twi->text, gtk_editable_get_chars(GTK_EDITABLE(twi->info.widget), 0, -1) );

	printf("Currently in the text box: %s\n", gtk_editable_get_chars(GTK_EDITABLE(twi->info.widget), 0, -1));

	printf( "c_text_catch_enter press()\n" );

	c_send_event( w, C_EVENT_TEXT_ENTER, 0 );
}
#endif

#ifdef ENV_CARBON
pascal OSStatus cTextBoxHandler( EventHandlerCallRef nextHandler, EventRef theEvent, CWidget *widget )
{
	unsigned int whatHappened = GetEventKind( theEvent );
	char *ct;
	Size actualSize;
	unsigned int keycode;
	
	switch ( whatHappened )
	{
		case kEventTextInputUnicodeForKeyEvent:
			// first, let the OS handle the event ...
			CallNextEventHandler( nextHandler, theEvent );
			
			// get the contents into our local storage
			ct = ((CTextBoxWidgetInfo *)widget->info)->text;
			GetControlData( widget->info->widget, kControlEditTextPart,  kControlEditTextTextTag, CLARO_TEXTBOX_MAXIMUM, ct, &actualSize );
			ct[actualSize] = 0;
			
			// send the event
			c_send_event( widget, C_EVENT_TEXT_CHANGED, 0 );
			break;
		case kEventRawKeyDown:
			GetEventParameter( theEvent, kEventParamKeyCode, typeUInt32, NULL, sizeof( typeUInt32 ), NULL, &keycode );
			
			// does widget want to receive keypress events?
			if ( widget->info->flags & C_WANT_KEYPRESS )
			{
				// yes, it does. send it the event.
				if ( c_send_event_now( widget, C_EVENT_KEY_PRESS, &keycode ) == 1 )
				{
					return noErr;
				}
			}
			
			// send enter press event
			if ( keycode == CK_RETURN && c_send_event_now( widget, C_EVENT_TEXT_ENTER, 0 ) == 1 )
			{
				return noErr;
			}
			
			break;
	}
	
	return eventNotHandledErr;
}
#endif

#define C_DEFAULT_TEST_TEXT "abcdefghijklmnopqrstuvqxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/^"

void c_text_handle_create( CEvent *e, void *data )
{
	CTextBoxWidgetInfo *twi = (CTextBoxWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
	GtkWidget *text;
	
	text = gtk_entry_new();
	c_font_fix( e->caller );
	e->caller->info->widget = text; 
	
	if ( twi->info.height == -1 )
		twi->info.height = c_font_get_height( e->caller ) + 4; // 4 padding

	gtk_widget_set_usize(GTK_WIDGET(text), twi->info.width, twi->info.height);

	gtk_layout_put (GTK_LAYOUT (e->caller->parent->info->widget),
		       text,
		       twi->info.x,
		       twi->info.y);

	if (twi->text[0]!=0) 
		gtk_entry_set_text( (GtkEntry *)text, twi->text );

	g_signal_connect( G_OBJECT( text ), "changed", G_CALLBACK (c_text_catch_event), (gpointer)e->caller);
	g_signal_connect( G_OBJECT( text ), "activate", G_CALLBACK (c_text_catch_activate), (gpointer)e->caller);
	g_signal_connect( G_OBJECT( text ), "configure_event", G_CALLBACK( c_window_resized_handler ), e->caller );

	/* FIXME: There should be a flag associated with this */
	gtk_entry_set_activates_default ((GtkEntry *)text, TRUE);

	gtk_widget_show( text );

	//twi->info.widget = text;
#endif

#ifdef ENV_CARBON
	CFStringRef str;
	
	Rect boundsInput = { 0, 0, 0, 0 };
	
	boundsInput.left = twi->info.x;
	boundsInput.top = twi->info.y;
	
	if ( twi->info.width == -1 )
		twi->info.width = 100;
	
	if ( twi->info.height == -1 )
		twi->info.height = 15;
	
	boundsInput.right = boundsInput.left + twi->info.width;
	boundsInput.bottom = boundsInput.top + twi->info.height;
	
	str = CFStringCreateWithCString( NULL, twi->text, strlen( twi->text ) );
	
	if ( ( CreateEditUnicodeTextControl( e->caller->parent->info->widget, &boundsInput, str, (twi->info.flags & C_TEXTBOX_PASSWORD), ((CFont *)e->caller->font)->cfont, &e->caller->info->widget ) != noErr )
	        || ( e->caller->info->widget == NULL ) )     ExitToShell();
	
	EventTypeSpec eventTypeList[] =  {
		{ kEventClassTextInput, kEventTextInputUnicodeForKeyEvent },
		{ kEventClassKeyboard, kEventRawKeyDown },
	};
	
	InstallEventHandler( GetControlEventTarget( e->caller->info->widget ), NewEventHandlerUPP( cTextBoxHandler ), 2, eventTypeList, e->caller, NULL );
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;

	int flags = twi->info.flags;
	
	if ( !( hwnd = CreateWindowEx( ( flags & C_BORDER_NONE ? 0 : WS_EX_CLIENTEDGE ),"EDIT", 0,
	                               WS_CHILD | ES_AUTOHSCROLL | WS_TABSTOP |
	                               (flags & C_TEXTBOX_PASSWORD ? ES_PASSWORD : 0),
	                               twi->info.x, twi->info.y,
	                               0, 0, 
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create text HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;

	ShowWindow( hwnd, SW_SHOW );
	UpdateWindow( hwnd );
#endif
	
	c_widget_install( e->caller );

	printf("c_text_handle_create( )\n");
	
	//c_send_event( e->caller, C_EVENT_UPDATE, 0 );
	c_text_handle_update( e, 0 );
}

void c_text_handle_resize( CEvent *e, void *data )
{
	c_text_handle_update( e, data );
}

void c_text_handle_update( CEvent *e, void *data )
{
	CTextBoxWidgetInfo *twi = (CTextBoxWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
	/*
	if(twi->info.visible)
		gtk_widget_set_child_visible(twi->info.widget, TRUE);
	else {
		gtk_widget_set_child_visible(twi->info.widget, FALSE);
	}

	gtk_layout_move ( GTK_LAYOUT( e->caller->parent->info->widget ),
			twi->info.widget,
			twi->info.x,
			twi->info.y);

	if(twi->info.width != -1 && twi->info.height != -1)
		gtk_widget_set_size_request(GTK_WIDGET(twi->info.widget), twi->info.width, twi->info.height);
	*/
	gtk_entry_set_text( (GtkEntry *)twi->info.widget, twi->text );
#endif

#ifdef ENV_CARBON
	CFStringRef text;
	text = CFStringCreateWithCString( NULL, twi->text, strlen( twi->text ) );
	SetControlData( e->caller->info->widget, kControlEntireControl, kControlStaticTextCFStringTag, sizeof( CFStringRef ), &text );
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	char *text = twi->text;
	char *textt = twi->text;
	HDC hdc;
	SIZE sz;
	int w, h;
	
	textt = C_DEFAULT_TEST_TEXT;
		
	hwnd = (HWND)twi->info.widget;
	
	SetWindowText( hwnd, text );
	
	w = twi->info.width;
	h = twi->info.height;
	
	if ( w == -1 || h == -1 )
	{
		// either width or height needs to be guessed :-)
		
		hdc = GetDC( hwnd );
		SelectObject( hdc, (HFONT)SendMessage( hwnd, WM_GETFONT, 0, 0 ) );
		
		if ( GetTextExtentPoint32( hdc, textt, strlen( textt ), &sz ) == 0 )
			printf( "Warning: could not determine font metrics (GetLastError()=%d)!\n", (int)GetLastError() );
		
		if ( !( twi->info.flags & C_BORDER_NONE ) )
			sz.cy += C_W32_TOTALYOFFSET_NOCAP;
		
		// set whichever
		if ( w == -1 )
			w = sz.cx;
		if ( h == -1 )
			h = sz.cy;
		
		ReleaseDC( hwnd, hdc );
		
		twi->info.width = w;
		twi->info.height = h;
	}
	
	MoveWindow( hwnd, twi->info.x, twi->info.y, w, h, 1 );
	UpdateWindow( hwnd );
#endif
	printf( "c_text_handle_update( )\n" );
	
	//c_send_event( e->caller, C_EVENT_DRAW, 0 );
}

void c_text_handle_destroy( CEvent *e, void *data )
{
	free( ((CTextBoxWidgetInfo *)e->caller->info)->text );
	
	printf( "c_text_handle_destroy( )\n" );
}

CWidget *c_new_text( CWidget *parent, char *text, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CTextBoxWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_TEXTBOX;
	w->info->x = x;
	w->info->y = y;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	w->info->visible = 1;
	((CTextBoxWidgetInfo *)w->info)->text = (char *)malloc( CLARO_TEXTBOX_MAXIMUM );
	strcpy( ((CTextBoxWidgetInfo *)w->info)->text, text );
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_text_handle_create );
	c_new_event_handler( w, C_EVENT_RESIZE, c_text_handle_resize );
	c_new_event_handler( w, C_EVENT_UPDATE, c_text_handle_update );
	c_new_event_handler( w, C_EVENT_DESTROY, c_text_handle_destroy );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
