/*************************************************************************
$Id: progressbar.c 106 2005-08-10 00:17:32Z terminal $

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

void c_progress_handle_create( CEvent *e, void *data )
{
	CProgressBarWidgetInfo *pwi = (CProgressBarWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
	GtkWidget *bar;

	bar = gtk_progress_bar_new ();

	if(pwi->info.width != -1 && pwi->info.height != -1)
		gtk_widget_set_size_request(GTK_WIDGET(bar), pwi->info.width, pwi->info.height);

	gtk_layout_put (GTK_LAYOUT (e->caller->parent->info->widget),
		       bar,
		       pwi->info.x,
		       pwi->info.y);

	gtk_widget_show( bar );

	pwi->info.widget = bar;
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;

	if ( !( hwnd = CreateWindowEx( 0, PROGRESS_CLASS, 
	                               0,
	                               WS_CHILD | WS_VISIBLE,
	                               pwi->info.x, pwi->info.y,
	                               pwi->info.width, pwi->info.height, 
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create progressbar HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;
	
	SendMessage( hwnd, PBM_SETRANGE, 0, MAKELPARAM( 0, 65535 ) );
	
	ShowWindow( hwnd, SW_SHOW );
	UpdateWindow( hwnd );
	
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );
#endif

	printf("c_progress_handle_create( )\n");
}

int c_progress_get_value( CWidget *prog )
{
	return ((CProgressBarWidgetInfo *)prog->info)->position;
}

void c_progress_set_value( CWidget *prog, float pos )
{
	((CProgressBarWidgetInfo *)prog->info)->position = pos;
}

void c_progress_handle_update( CEvent *e, void *data )
{
	CProgressBarWidgetInfo *pwi = (CProgressBarWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
	if(pwi->info.visible)
		gtk_widget_set_child_visible(pwi->info.widget, TRUE);
	else {
		gtk_widget_set_child_visible(pwi->info.widget, FALSE);
	}

	if(pwi->position > 1.0 || pwi->position < 0.0)
		return;

	gtk_progress_set_percentage (GTK_PROGRESS(pwi->info.widget), pwi->position);

	gtk_layout_move ((GtkLayout *)e->caller->parent->info->widget,
		pwi->info.widget,
		pwi->info.x,
		pwi->info.y);

	if(pwi->info.width != -1 && pwi->info.height != -1)
		gtk_widget_set_size_request(GTK_WIDGET(pwi->info.widget), pwi->info.width, pwi->info.height);
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	int intpos = (int)((float)pwi->position * 65535.0);
		
	hwnd = (HWND)pwi->info.widget;

	SendMessage( hwnd, PBM_SETPOS, intpos, 0 );
	MoveWindow( hwnd, pwi->info.x, pwi->info.y, pwi->info.width, pwi->info.height, 1 );
	UpdateWindow( hwnd );
#endif
	printf( "c_progress_handle_update( )\n" );
	
	c_send_event( e->caller, C_EVENT_DRAW, 0 );
}

void c_progress_change( CWidget *w, float pos )
{
	CProgressBarWidgetInfo *pbi;
	
	pbi = (CProgressBarWidgetInfo *)w->info;
	
	pbi->position = pos;
	
	c_send_event( w, C_EVENT_UPDATE, 0 );
}

CWidget *c_new_progress( CWidget *parent, float pos, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	if ( width == -1 )
		width = 100;
	if ( height == -1 )
		height = 15;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CProgressBarWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_PROGRESSBAR;
	w->info->x = x;
	w->info->y = y;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	w->info->visible = true;
	((CProgressBarWidgetInfo *)w->info)->position = pos;
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_progress_handle_create );
	c_new_event_handler( w, C_EVENT_UPDATE, c_progress_handle_update );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
