/*************************************************************************
$Id: application.c 111 2005-08-30 02:45:11Z terminal $

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

#ifdef ENV_CARBON
OSStatus claro_carbon_app_event_handler( EventHandlerCallRef nextHandler, EventRef event, void *userData );
#endif

CWidget *c_new_application( int flags )
{
#ifdef ENV_WIN32
	INITCOMMONCONTROLSEX icc;
#endif

	CWidget *w;
	CFont *f;
	
#ifdef ENV_WIN32
	int a;
	
	a = GetSysColor( COLOR_BTNFACE );
	
	// real native background, default in canvas.c
	c_native_background = ( (a>>16&0xFF) + (a&0xFF00) + (a<<16&0xFF0000) ) << 8;
#endif
#ifdef ENV_CARBON
	// looks-better native background, default in canvas.c
	c_native_background = 0xeeeeee00;
	
	const EventTypeSpec events[] = {
		{ kEventClassKeyboard, kEventRawKeyDown },
		{ kEventClassKeyboard, kEventRawKeyRepeat },
		{ kEventClassMouse, kEventMouseDown },
		{ kEventClassMouse, kEventMouseWheelMoved },
		{ kEventClassCommand, kEventCommandProcess }
	};
	
	InstallApplicationEventHandler( NewEventHandlerUPP( claro_carbon_app_event_handler ), GetEventTypeCount( events ), events, NULL, NULL );
#endif
	
	w = c_clone_widget( 0, 0 );
	
	c_init_widget_info( w, sizeof( CApplicationWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_APPLICATION;
	w->info->flags = flags;
	
#ifdef ENV_WIN32
	icc.dwSize = sizeof( INITCOMMONCONTROLSEX );
	icc.dwICC = ICC_WIN95_CLASSES | ICC_USEREX_CLASSES | ICC_COOL_CLASSES;
	InitCommonControlsEx( &icc );
#endif

	f = c_font_create( "Verdana", 16 );
	c_font_bind_widget( f, w );
	
	return w;
}
