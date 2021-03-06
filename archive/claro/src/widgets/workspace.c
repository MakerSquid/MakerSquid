/*************************************************************************
$Id: workspace.c 106 2005-08-10 00:17:32Z terminal $

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

#ifdef ENV_WIN32
HWND glob_mdi_client;
#endif
#ifdef ENV_GTK
GtkWidget *glob_mdi_client;
CWidget *current_child;
#endif

#ifdef ENV_CARBON
void c_workspace_do_resize( CWidget *w )
{
	CWidget *curr, *curr2;
	
	for ( curr = w->child_head; curr != 0; curr = curr->next )
	{
		curr->info->x = w->info->x;
		curr->info->y = w->info->y;
		curr->info->width = w->info->width;
		curr->info->height = w->info->height;
		
		curr->info->cspace.x = w->info->x;
		curr->info->cspace.y = w->info->y;
		curr->info->cspace.w = w->info->width;
		curr->info->cspace.h = w->info->height;
		
		MoveControl( ((CWindowWidgetInfo *)curr->info)->ws_pcontrol, w->info->x, w->info->y );
		SizeControl( ((CWindowWidgetInfo *)curr->info)->ws_pcontrol, w->info->width, w->info->height );
		
		c_send_event_now( curr, C_EVENT_RESIZE, 0 );
		
		for ( curr2 = curr->child_head; curr2 != 0; curr2 = curr2->next )
			c_send_event_now( curr2, C_EVENT_PARENTSIZE, 0 );
	}
}

void c_workspace_resize( CEvent *e, void *data )
{
	c_workspace_do_resize( e->caller );
}
#endif

void c_workspace_dock( CWidget *ws, CWidget *win, int pos )
{
	int oldpos;
	CWindowWidgetInfo *wi;
	
	if ( win->info->type != CLARO_WIDGET_WINDOW )
		return;
	
	if ( ws->info->type != CLARO_WIDGET_WORKSPACE )
		return;
	
	wi = ((CWindowWidgetInfo *)win->info);
	
	oldpos = wi->dock_pos;
	
	wi->dock_pos = pos;
	
	if ( oldpos == 0 )
	{
		// wasn't docked. we need to change it's flags.
		if ( win->info->widget != 0 )
		{
#ifdef ENV_WIN32
			SetWindowLong( win->info->widget, GWL_STYLE, WS_CHILD | WS_VISIBLE );
#endif
		}
		
		wi->dock_helpers[0] = c_new_label( c_find_nonaligner_parent( ws ), "DOCKING WINDOW", 0, 0, 0, 0, 0 );
		wi->dock_helpers[1] = c_new_pushbutton( c_find_nonaligner_parent( ws ), "X", 0, 0, 0, 0, 0 );
	}
}

int c_workspace_docksize( CWidget *w, int pos )
{
	CWidget *curr;
	int size = 0;
	
	for ( curr = w->child_head; curr != 0; curr = curr->next )
	{
		if ( curr->info->type != CLARO_WIDGET_WINDOW )
			continue;
		
		if ( ((CWindowWidgetInfo *)curr->info)->dock_pos == pos )
			size = curr->info->width;
	}
	
	return size;
}

void c_workspace_dockmove( CWidget *w, int pos, int x, int y, int size )
{
	CWidget *curr;
	int a = 0, b = 20;
	
	for ( curr = w->child_head; curr != 0; curr = curr->next )
	{
		if ( curr->info->type != CLARO_WIDGET_WINDOW )
			continue;
		
		if ( ((CWindowWidgetInfo *)curr->info)->dock_pos != pos )
			continue;
		
		if ( pos == C_DOCK_LEFT || pos == C_DOCK_RIGHT )
		{
			c_widget_move( curr, x, y+a+b, size, curr->info->height );
			c_widget_move( ((CWindowWidgetInfo *)curr->info)->dock_helpers[0], x+3, y+a+2, size-20-3, 20-2 );
			c_widget_move( ((CWindowWidgetInfo *)curr->info)->dock_helpers[1], x+(size-20+2), y+a+2, 16, 16 );
			c_label_settext( ((CWindowWidgetInfo *)curr->info)->dock_helpers[0], ((CWindowWidgetInfo *)curr->info)->title );
			a += curr->info->height;
		}
		else
		{
			c_widget_move( curr, x, y+a+b, curr->info->width, size );
			//  FIXME: Docking !! :)
			a += curr->info->width;
		}
		
		a += b; // header size
	}
}

void c_workspace_parent_size( CEvent *e, void *data )
{
	int x, y, w, h;
	CWidget *wg = e->caller;
	int dl, dr, dt, db;
	
	x = wg->info->x;
	y = wg->info->y;
	w = wg->info->width;
	h = wg->info->height;
	
	dl = dr = dt = db = 0;
	
	dl = c_workspace_docksize( wg, C_DOCK_LEFT );
	dr = c_workspace_docksize( wg, C_DOCK_RIGHT );
	dt = c_workspace_docksize( wg, C_DOCK_TOP );
	db = c_workspace_docksize( wg, C_DOCK_BOTTOM );
	
	x += dl;
	w -= dl;
	w -= dr;
	
	y += dt;
	h -= dt;
	h -= db;
	
	c_workspace_dockmove( wg, C_DOCK_LEFT, wg->info->x, wg->info->y, dl );
	c_workspace_dockmove( wg, C_DOCK_RIGHT, x+w, wg->info->y, dr );
	c_workspace_dockmove( wg, C_DOCK_TOP, x, wg->info->y, dt );
	c_workspace_dockmove( wg, C_DOCK_BOTTOM, x, y+h, db );
	
	c_widget_move( wg, x, y, w, h );
	
	/*
#ifdef ENV_WIN32
	HWND hwnd;
	
	hwnd = (HWND)wg->info->widget;
	
	// this is the ACTUAL x, y, w, h of the > MDI CLIENT <
	MoveWindow( hwnd, x, y, w, h, true );
	UpdateWindow( hwnd );
#endif
#ifdef ENV_GTK
	gtk_layout_move( wg->parent->info->widget, wg->info->widget, x, y );
	gtk_widget_set_size_request( wg->info->widget, w, h );
#endif
	*/
}

void c_workspace_handle_create( CEvent *e, void *data )
{
#ifdef ENV_WIN32
	CLIENTCREATESTRUCT ccs;
	HWND hwnd_client;
	CWidget *wp;
	
	ccs.hWindowMenu  = 0;
	ccs.idFirstChild = 0xF0000;
	
	hwnd_client = CreateWindowEx(
		WS_EX_CLIENTEDGE,
		"mdiclient",
		NULL,
		WS_CHILD | WS_CLIPCHILDREN | WS_VISIBLE,
		CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
		e->caller->parent->info->widget, NULL, (HINSTANCE) GetModuleHandle( NULL ), (LPVOID)&ccs
	);
			
	((CWorkspaceWidgetInfo *)e->caller->info)->clientwin = hwnd_client;
	
	if ( hwnd_client == NULL )
	{
		MessageBox(NULL, "Workspace (MDIClient) Creation Failed!", "Error!", MB_ICONEXCLAMATION | MB_OK);
		return;
	}
	
	MoveWindow( hwnd_client, e->caller->info->x, e->caller->info->y, e->caller->info->width, e->caller->info->height, false );
	
	glob_mdi_client = hwnd_client;
	
	e->caller->info->widget = (CNativeWidget)hwnd_client;
	
	wp = e->caller->parent;
	
	while ( wp->parent != 0 && wp->info->type != CLARO_WIDGET_WINDOW )
		wp = wp->parent;
	
	((CWindowWidgetInfo *)wp->info)->clientwin = (CNativeWidget)hwnd_client;

	c_font_fix( e->caller );

	c_widget_update_enable( e->caller );

	c_send_event( e->caller, C_EVENT_POSTCREATE, 0 );
	c_send_event( e->caller, C_EVENT_CREATED, 0 );
	c_send_event( e->caller, C_EVENT_RESIZE, 0 );
#endif
	
#ifdef ENV_GTK
	GtkWidget *win,*clientwin;
	CWidget *wp;
	
	wp = e->caller->parent;
	
	while ( wp->parent != 0 && wp->info->type != CLARO_WIDGET_WINDOW )
		wp = wp->parent;

	win=wp->info->widget; //gtk_window_new(GTK_WINDOW_TOPLEVEL);
	clientwin=gtk_vbox_new( FALSE, 0 );//gtk_layout_new(NULL,NULL);

	gtk_layout_put( GTK_LAYOUT( win ), GTK_WIDGET( clientwin ), e->caller->info->x, e->caller->info->y );
	//gtk_container_add(GTK_CONTAINER(win), clientwin);

	((CWorkspaceWidgetInfo *)e->caller->info)->win = win;
	((CWorkspaceWidgetInfo *)e->caller->info)->clientwin = clientwin;

	gtk_widget_set_size_request(GTK_WIDGET(clientwin),e->caller->info->width, e->caller->info->height);
	//gtk_window_resize(GTK_WINDOW(win), e->caller->info->width, e->caller->info->height);
	//gtk_window_move(GTK_WINDOW(clientwin), e->caller->info->x, e->caller->info->y);

	e->caller->info->widget = (CNativeWidget)clientwin;
	glob_mdi_client = clientwin;
	current_child =0;
#endif

#ifdef ENV_CARBON
	e->caller->info->widget = e->caller->parent->info->widget;
#endif

	printf("c_workspace_handle_create( )\n");
}

CWidget *c_workspace_get_active( CWidget *w )
{
#ifdef ENV_WIN32
	HWND win;
	
	win = (HWND)SendMessage( w->info->widget, WM_MDIGETACTIVE, 0, 0 );
	
	if ( win == 0 )
		return 0;
	
	return c_get_window_by_handle( w, win, 0 );
#endif
#ifdef ENV_GTK
	return current_child;
#endif
#ifdef ENV_CARBON
	return ((CWorkspaceWidgetInfo *)w->info)->active;
#endif

	return 0;
}

void c_workspace_cascade( CWidget *w )
{
#ifdef ENV_WIN32
	SendMessage( w->info->widget, WM_MDICASCADE, MDITILE_SKIPDISABLED, 0 );
#endif
}

void c_workspace_tile( CWidget *w, int dir )
{
#ifdef ENV_WIN32
	SendMessage( w->info->widget, WM_MDITILE, ( dir & C_WORKSPACE_TILE_HORIZ ? MDITILE_HORIZONTAL : MDITILE_VERTICAL ), 0 );
#endif
}

void c_workspace_newchild( CWidget *ws, CWidget *ch )
{
#ifdef ENV_CARBON
	CWorkspaceWidgetInfo *wsi = (CWorkspaceWidgetInfo *)ws->info;
	CWindowWidgetInfo *chi = (CWindowWidgetInfo *)ch->info;
	
	chi->ws_order_num = wsi->ws_childnum;
	wsi->ws_childnum++;
	
	c_workspace_do_resize( ws );
#endif
}

void c_workspace_deadchild( CWidget *ws, CWidget *ch )
{
#ifdef ENV_CARBON
	CWorkspaceWidgetInfo *wsi = (CWorkspaceWidgetInfo *)ws->info;
	CWindowWidgetInfo *chi = (CWindowWidgetInfo *)ch->info, *ch2;
	CWidget *curr;
	int a;
	
	wsi->ws_childnum--;
	
	if ( wsi->ws_childnum == 0 )
		wsi->active = 0;
	
	a = chi->ws_order_num;
	
	for ( curr = ws->child_head; curr != 0; curr = curr->next )
	{
		ch2 = (CWindowWidgetInfo *)curr->info;
		
		if ( ch2->ws_order_num > a )
			ch2->ws_order_num--; // lower order
		
		if ( ch2->ws_order_num == 0 && curr != ch )
			wsi->active = curr;
	}
#endif
}

void c_workspace_popup( CWidget *ws, CWidget *ch )
{
#ifdef ENV_CARBON
	CWorkspaceWidgetInfo *wsi = (CWorkspaceWidgetInfo *)ws->info;
	CWidget *curr;
	CWindowWidgetInfo *chi;
	int a;
	
	// firstly, are we already active?
	if ( wsi->active == ch )
		return; // do nothing
	
	// save our order
	a = ((CWindowWidgetInfo *)ch->info)->ws_order_num;
	
	// move all children down the order heap
	for ( curr = ws->child_head; curr != 0; curr = curr->next )
	{
		chi = (CWindowWidgetInfo *)curr->info;
		
		// we only need to move ones who were above us (lower order #)
		if ( chi->ws_order_num < a )
			chi->ws_order_num++; // lower order
		
		// hide this child
		if ( curr != ch )
		{
			HideControl( chi->ws_pcontrol );
		}
	}
	
	// bring us to the top (0)
	chi = (CWindowWidgetInfo *)ch->info;
	chi->ws_order_num = 0;
	
	// show this one
	ShowControl( chi->ws_pcontrol );
	
	// save new active child
	wsi->active = ch;
#endif
}

CWidget *c_new_workspace( CWidget *parent, int x, int y, int width, int height, int flags )
{
	CWidget *w, *parentw;

	if ( parent == 0 )
		parent = c_application;

	w = c_clone_widget( 0, parent );

	c_init_widget_info( w, sizeof( CWindowWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_WORKSPACE;
	w->info->width = width;
	w->info->height = height;
	w->info->x = x;
	w->info->y = y;
	w->info->flags = flags;
	w->info->visible = 1;
#ifdef ENV_CARBON
	((CWorkspaceWidgetInfo *)w->info)->active = 0;
	((CWorkspaceWidgetInfo *)w->info)->ws_childnum = 0;
#endif

	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_workspace_handle_create );
	c_new_event_handler( w, C_EVENT_PARENTSIZE, c_workspace_parent_size );
#ifdef ENV_CARBON
	c_new_event_handler( w, C_EVENT_RESIZE, c_workspace_resize );
#endif
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	parentw = c_find_nonaligner_parent( w );
	parentw->info->flags |= C_MDIPARENT;
	((CWindowWidgetInfo *)parentw->info)->workspace = w;
	
	return w;
}
