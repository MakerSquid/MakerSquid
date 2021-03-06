/*************************************************************************
$Id: taskbar.c 183 2005-11-02 22:03:34Z terminal $

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

#define B_TASKBAR_COL_STD_BACK C_NATIVE_BACKGROUND
#define B_TASKBAR_COL_STD_TEXT 0x363636FF
#define B_TASKBAR_COL_STD_BORD C_NATIVE_BACKGROUND
#define B_TASKBAR_COL_ACTIVE_BACK 0xD4D5D8FF
#define B_TASKBAR_COL_ACTIVE_TEXT 0x000000FF
#define B_TASKBAR_COL_ACTIVE_BORD 0x0A246AFF
#define B_TASKBAR_COL_OVER_BACK 0xB6BDD2FF
#define B_TASKBAR_COL_OVER_TEXT 0x000000FF
#define B_TASKBAR_COL_OVER_BORD 0x0A246AFF
#define B_TASKBAR_COL_AOVER_BACK 0xB6BDD2FF
#define B_TASKBAR_COL_AOVER_TEXT 0xFFFFFFFF
#define B_TASKBAR_COL_AOVER_BORD 0x0A246AFF

#define B_TASKBAR_COL_TEXT_TEXT 0x000080FF
#define B_TASKBAR_COL_TEXT_MESG 0xFF0000FF

#define B_TASKBAR_DEF_BUTTONWIDTH 150
#define B_TASKBAR_DEF_BUTTONHEIGHT 21
#define B_TASKBAR_DEF_BUTTONPADD 2
#define B_TASKBAR_DEF_BUTTONSTART 1

extern BServerWindow *server_head;

CWidget *taskbar;

void b_taskbar_redraw( )
{
	c_canvas_invalid( taskbar );
	c_send_event_singular( taskbar, C_EVENT_PREDRAW, 0 );
}

void b_taskbar_draw_button( CWidget *c, int type, char *text, int x, int y, int w, int h, int bd, int bg, int fg )
{
	ClaroIcon *icon;
	
	if ( type == B_CMD_WINDOW_CHANNEL )
		icon = b_icon( "channel_window" );
	else if ( type == B_CMD_WINDOW_QUERY )
		icon = b_icon( "query_window" );
	else
		icon = b_icon( "status_window" );
	
	c_canvas_paint_fillrect( c, bd, x, y, w, h );
	c_canvas_paint_fillrect( c, bg, x+1, y+1, w-2, h-2 );
	c_canvas_paint_icon( c, icon, x+4, y+3 );
	c_canvas_paint_text_full( c, x+4+16+3, y+2, w-4-16-3-3, h, fg, text, C_CANVAS_TEXT_CLIP );
}

#define B_GET_COLOURING( flags, active ) \
if ( active == 1 ) { if ( flags & 2 ) flags -= 2; if ( flags & 4 ) flags -= 4; } \
if ( active == 1 && flags & 1 ) {ca = B_TASKBAR_COL_AOVER_BORD; cb = B_TASKBAR_COL_AOVER_BACK; cc = B_TASKBAR_COL_AOVER_TEXT;} \
else if ( active == 1 ) {ca = B_TASKBAR_COL_ACTIVE_BORD; cb = B_TASKBAR_COL_ACTIVE_BACK; cc = B_TASKBAR_COL_ACTIVE_TEXT;} \
else if ( flags & 1 ) {ca = B_TASKBAR_COL_OVER_BORD; cb = B_TASKBAR_COL_OVER_BACK; cc = B_TASKBAR_COL_OVER_TEXT;} \
else {ca = B_TASKBAR_COL_STD_BORD; cb = B_TASKBAR_COL_STD_BACK; cc = B_TASKBAR_COL_STD_TEXT;} \
if ( flags & 2 ) cc = B_TASKBAR_COL_TEXT_TEXT; \
if ( flags & 4 ) cc = B_TASKBAR_COL_TEXT_MESG;

void b_taskbar_draw( CEvent *e, void *data )
{
	CWidget *w = e->caller;
	BServerWindow *srv;
	BChatWindow *chat;
	int x, y=B_TASKBAR_DEF_BUTTONSTART, width=B_TASKBAR_DEF_BUTTONWIDTH;
	int height=B_TASKBAR_DEF_BUTTONHEIGHT, padding=B_TASKBAR_DEF_BUTTONPADD;
	int buttons, wwth;
	char *name;
	int ca, cb, cc;
	
	c_canvas_paint_clear( w, C_NATIVE_BACKGROUND );
	
	// first, count the buttons
	for ( srv = server_head, buttons = 0; srv != 0; srv = srv->next )
	{
		buttons++;
		for ( chat = srv->chat_head; chat != 0; chat = chat->next )
		{
			buttons++;
		}
	}
	
	if ( buttons == 0 )
		return;
	
	wwth = c_widget_width( w ) - 2;
	
	if ( wwth < buttons * width )
	{
		width = wwth / buttons;
	}
	
	for ( srv = server_head, x = 1; srv != 0; srv = srv->next )
	{
		name = "Status";
		
		if ( srv->connected == 1 )
			name = srv->servername;
		
		B_GET_COLOURING( srv->taskbar_flags, ( c_workspace_get_active( workspace ) == srv->window ? 1 : 0 ) );
		
		b_taskbar_draw_button( w, B_CMD_WINDOW_STATUS, name, x, y, width, height, ca, cb, cc );
		x += width + padding;
		
		for ( chat = srv->chat_head; chat != 0; chat = chat->next )
		{
			B_GET_COLOURING( chat->taskbar_flags, ( c_workspace_get_active( workspace ) == chat->window ? 1 : 0 ) );
			
			b_taskbar_draw_button( w, chat->type, chat->dest, x, y, width, height, ca, cb, cc );
			x += width + padding;
		}
	}
}

void b_taskbar_mouse_move( CEvent *e, void *data )
{
	CWidget *w = e->caller;
	BServerWindow *srv;
	BChatWindow *chat;
	int x, y=B_TASKBAR_DEF_BUTTONSTART, width=B_TASKBAR_DEF_BUTTONWIDTH;
	int height=B_TASKBAR_DEF_BUTTONHEIGHT, padding=B_TASKBAR_DEF_BUTTONPADD;
	int r, rd = 0;
	int buttons, wwth;

	int *dat;
	int mx;
	int my;
	
	if ( data != 0 )
	{
		dat = (int *)data;
		mx = dat[0];
		my = dat[1];
	}
	else
	{
		mx = -1;
		my = -1;
	}
	
	// first, count the buttons
	for ( srv = server_head, buttons = 0; srv != 0; srv = srv->next )
	{
		buttons++;
		for ( chat = srv->chat_head; chat != 0; chat = chat->next )
		{
			buttons++;
		}
	}
	
	wwth = c_widget_width( w ) - 2;
	
	if ( wwth < buttons * width )
	{
		width = wwth / buttons;
	}
	
	for ( srv = server_head, x = 1; srv != 0; srv = srv->next )
	{
		r = ((x <= mx) && (mx <=x+width) && (y <= my) && (my <= y+height));
		if ( r && ( srv->taskbar_flags & 1 ) == 0 )
			{ srv->taskbar_flags |= 1; rd++; }
		else if ( !r && srv->taskbar_flags & 1 )
			{ srv->taskbar_flags -= 1; rd++; }
		
		if ( e->id == C_EVENT_MOUSE_LEFT_CLICK && srv->taskbar_flags & 1 )
			b_window_focus( srv->window );
		else if ( e->id == C_EVENT_MOUSE_RIGHT_RELEASE && srv->taskbar_flags & 1 )
		{
			int px, py;
			
			px = mx;
			py = my;
			
			px += c_widget_screen_offset_x( e->caller );
			py += c_widget_screen_offset_y( e->caller );
			
			c_menubar_popup( srv->conmenu.menu, px, py );
		}
		
		x += width + padding;
		
		for ( chat = srv->chat_head; chat != 0; chat = chat->next )
		{
			r = ((x <= mx) && (mx <=x+width) && (y <= my) && (my <= y+height));
			if ( r && ( chat->taskbar_flags & 1 ) == 0 )
				{ chat->taskbar_flags |= 1; rd++; }
			else if ( !r && chat->taskbar_flags & 1 )
				{ chat->taskbar_flags -= 1; rd++; }
			
			if ( e->id == C_EVENT_MOUSE_LEFT_CLICK && chat->taskbar_flags & 1 )
				b_window_focus( chat->window );
			else if ( e->id == C_EVENT_MOUSE_RIGHT_RELEASE && chat->taskbar_flags & 1 )
			{
				int px, py;
				
				px = mx;
				py = my;
				
				px += c_widget_screen_offset_x( e->caller );
				py += c_widget_screen_offset_y( e->caller );
				
				c_menubar_popup( chat->conmenu.menu, px, py );
			}
			
			x += width + padding;
		}
	}
	
	if ( rd > 0 )
		b_taskbar_redraw( );
}

CWidget *b_create_taskbar( CWidget *parent )
{
	taskbar = c_new_canvas( parent, 0, 0, 100, 25, C_BORDER_NONE );
	
	c_new_event_handler( taskbar, C_EVENT_DRAW, b_taskbar_draw );
	c_new_event_handler( taskbar, C_EVENT_MOUSE_MOVE, b_taskbar_mouse_move );
	c_new_event_handler( taskbar, C_EVENT_MOUSE_LEAVE, b_taskbar_mouse_move );
	c_new_event_handler( taskbar, C_EVENT_MOUSE_LEFT_CLICK, b_taskbar_mouse_move );
	c_new_event_handler( taskbar, C_EVENT_MOUSE_RIGHT_RELEASE, b_taskbar_mouse_move );
	
	c_canvas_invalid( taskbar );
	c_send_event_singular( taskbar, C_EVENT_PREDRAW, 0 );
	
	return taskbar;
}

//
