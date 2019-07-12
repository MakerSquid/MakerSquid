/*************************************************************************
$Id: radiogroup.c 106 2005-08-10 00:17:32Z terminal $

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

void c_radiogroup_handle_create( CEvent *e, void *data )
{
	//CWidget *w = e->caller;
}

int c_radiogroup_get_value( CWidget *group )
{
	return ((CRadioGroupWidgetInfo *)group->info)->value;
}

CWidget *c_new_radiogroup( CWidget *parent, int x, int y, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CRadioGroupWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_RADIOGROUP;
	w->info->x = x;
	w->info->y = y;
	w->info->width = 1;
	w->info->height = 1;
	w->info->flags = flags;
	((CRadioGroupWidgetInfo *)w->info)->value = -1;
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_radiogroup_handle_create );
	//c_new_event_handler( w, C_EVENT_UPDATE, c_radiogroup_handle_update );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}


/*

CWidget *c_new_radiobutton( CWidget *parent, float pos, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CRadioButtonWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_RADIOBUTTON;
	w->info->x = x;
	w->info->y = y;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	
	// add event handler
	//c_new_event_handler( w, C_EVENT_CREATE, c_radiobutton_handle_create );
	//c_new_event_handler( w, C_EVENT_UPDATE, c_radiobutton_handle_update );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}

*/
