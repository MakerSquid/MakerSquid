/*************************************************************************
$Id: listbox.c 106 2005-08-10 00:17:32Z terminal $

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

#define C_DEPRECATED printf( "The function %s() was called but has been deprecated. Please update your source code to use the newer API or downgrade to an earlier version of Claro.\n", __FUNCTION__ );

int c_listbox_selected( CWidget *w )
{
	if ( ((CListBoxWidgetInfo *)w->info)->selected == 0 )
		return -1;
	
	return ((CListBoxWidgetInfo *)w->info)->selected->pos;
}

void c_listbox_set_select( CWidget *w, int a )
{
	CListBoxWidgetInfo *wi = (CListBoxWidgetInfo *)w->info;
#ifdef ENV_WIN32
	if ( w->info->widget != 0 )
		SendMessage( w->info->widget, LB_SETCURSEL, a, 0 );
#endif
	wi->selected = wi->table->lookup[a];
	c_send_event( w, C_EVENT_ITEM_SELECTED, 0 );
}

void c_listbox_clear( CWidget *w ) { C_DEPRECATED }
int c_listbox_get_item_pos( CWidget *w, int item ) { C_DEPRECATED; return 0; }
CListBoxItem *c_listbox_get_item( CWidget *w, int item ) { C_DEPRECATED; return 0; }
int c_listbox_additem_at( CWidget *w, char *text, int pos ) { C_DEPRECATED; return 0; }
int c_listbox_additem( CWidget *w, char *text ) { C_DEPRECATED; return 0; }
void c_listbox_delitem( CWidget *w, int item ) { C_DEPRECATED }

int c_listbox_get_item_count( CWidget *w )
{
	CListBoxWidgetInfo *wi = (CListBoxWidgetInfo *)w->info;
	return wi->table->rows;
}

void c_listbox_copy_from_table( CWidget *w )
{
	CListBoxWidgetInfo *wi = (CListBoxWidgetInfo *)w->info;
	ClaroTableCell *cell;
	char *txt;
	int a;
	
#ifdef ENV_WIN32
	HWND hwnd = w->info->widget;
#endif
	
	if ( wi->table == 0 )
		return; // no table attached :-(
	
	for ( a = 0; a < wi->table->rows; a++ )
	{
		cell = c_tbl_get_cell( wi->table, a, wi->visible_cell );
		txt = cell->data;

#ifdef ENV_WIN32
		SendMessage( hwnd, LB_ADDSTRING, 0, (LPARAM)txt );
		SendMessage( hwnd, LB_SETITEMDATA, a, (LPARAM)wi->table->lookup[a] );
#endif
	}
	
	if ( wi->selected != 0 )
	{
#ifdef ENV_WIN32
		SendMessage( w->info->widget, LB_SETCURSEL, wi->selected->pos, 0 );
#endif
	}
}

void c_listbox_table_notify( int msg, ClaroTable *table, ClaroTableRow *row, ClaroTableCell *celli )
{
	CWidget *w = (CWidget *)table->ndata;
	CListBoxWidgetInfo *wi;
	ClaroTableCell *cell;
	char *txt;
	
	if ( w == 0 || w->info->widget == 0 )
		return;
	
	wi = (CListBoxWidgetInfo *)w->info;
	
	switch ( msg ) {
		case C_TABLE_NOTIFY_INSERT_ROW:
			cell = c_tbl_get_cell( table, row->pos, wi->visible_cell );
			txt = cell->data;
			
			if ( txt == 0 )
				txt = "";
			
#ifdef ENV_WIN32
			SendMessage( w->info->widget, LB_INSERTSTRING, row->pos, (LPARAM)txt );
			SendMessage( w->info->widget, LB_SETITEMDATA, row->pos, (LPARAM)row );
#endif
			break;
		case C_TABLE_NOTIFY_REMOVE_ROW:
			if ( row == wi->selected )
				wi->selected = 0;
#ifdef ENV_WIN32
			SendMessage( w->info->widget, LB_DELETESTRING, row->pos, 0 );
#endif
			break;
		case C_TABLE_NOTIFY_MOVE_ROW:
			cell = c_tbl_get_cell( table, row->pos, wi->visible_cell );
			txt = cell->data;
			
			if ( txt == 0 )
				txt = "";
			
#ifdef ENV_WIN32
			SendMessage( w->info->widget, LB_DELETESTRING, (int)celli, 0 );
			SendMessage( w->info->widget, LB_INSERTSTRING, row->pos, (LPARAM)txt );
			SendMessage( w->info->widget, LB_SETITEMDATA, row->pos, (LPARAM)row );
#endif
			/*if ( row == wi->selected )
			{
#ifdef ENV_WIN32
				SendMessage( w->info->widget, LB_SETCURSEL, row->pos, 0 );
#endif
				c_send_event( w, C_EVENT_ITEM_SELECTED, 0 );
			}*/

			break;
		case C_TABLE_NOTIFY_CHANGE_CELL:
			cell = c_tbl_get_cell( table, row->pos, wi->visible_cell );
			if ( cell == celli )
			{
				txt = cell->data;
				
				if ( txt == 0 )
					txt = "";
				
#ifdef ENV_WIN32
				SendMessage( w->info->widget, LB_DELETESTRING, row->pos, 0 );
				SendMessage( w->info->widget, LB_INSERTSTRING, row->pos, (LPARAM)txt );
				SendMessage( w->info->widget, LB_SETITEMDATA, row->pos, (LPARAM)row );
#endif
			}
			
			break;
	}
	
	if ( wi->selected != 0 )
	{
#ifdef ENV_WIN32
		SendMessage( w->info->widget, LB_SETCURSEL, wi->selected->pos, 0 );
#endif
	}
}

void c_listbox_attach_table( CWidget *w, ClaroTable *tbl, int cell )
{
	CListBoxWidgetInfo *wi = (CListBoxWidgetInfo *)w->info;
	
	wi->table = tbl;
	tbl->ndata = w;
	wi->visible_cell = cell;
	
	c_tbl_set_notify( tbl, c_listbox_table_notify );
	
	if ( w->info->widget != 0 )
	{
		// widget created, run initial insert
		c_listbox_copy_from_table( w );
	}
}

void c_listbox_handle_create( CEvent *e, void *data )
{
	CListBoxWidgetInfo *bwi = (CListBoxWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
	#warning "No GTK port for c_listbox coded"
#endif

#ifdef ENV_CARBON
	ListDefSpec lsp = { kListDefStandardTextType };
	
	Rect boundsList = { 0, 0, 0, 0 };
	
	boundsList.left = bwi->info.x;
	boundsList.top = bwi->info.y;
	
	if ( bwi->info.width == -1 )
		boundsList.right = boundsList.left + 100;
	else
		boundsList.right = boundsList.left + bwi->info.width;
	
	if ( bwi->info.height == -1 )
		boundsList.bottom = boundsList.top + 100;
	else
		boundsList.bottom = boundsList.top + bwi->info.height;
	
	if ( ( CreateListBoxControl( e->caller->parent->info->widget, &boundsList, 0, 1, 1, true, true, 16, 50, true, &lsp, &e->caller->info->widget ) != noErr )
	        || ( e->caller->info->widget == NULL ) )     ExitToShell();
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;
	int flags = e->caller->info->flags;
	//CListBoxItem *curr;

	if ( !( hwnd = CreateWindowEx( ( flags & C_BORDER_NONE ? 0 : WS_EX_CLIENTEDGE ), "LISTBOX", 
	                               "",
	                               WS_CHILD | LBS_NOTIFY | WS_TABSTOP | LBS_NOINTEGRALHEIGHT | WS_VSCROLL | WS_HSCROLL,
	                               bwi->info.x, bwi->info.y,
	                               bwi->info.width, bwi->info.height,
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create listbox HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;
	
	c_font_fix( e->caller );

	/*
	for ( curr = ((CListBoxWidgetInfo *)e->caller->info)->items; curr != NULL; curr = curr->next )
	{
		curr->winid = SendMessage( hwnd, LB_ADDSTRING, 0, (LPARAM)curr->text );
		SendMessage( hwnd, LB_SETITEMDATA, curr->winid, (LPARAM)curr->id );
		
		if ( ((CListBoxWidgetInfo *)e->caller->info)->selected == curr )
			SendMessage( e->caller->info->widget, LB_SETCURSEL, curr->winid, 0 );
	}
	*/
	
	ShowWindow( hwnd, SW_SHOW );
	UpdateWindow( hwnd );
#endif

	c_listbox_copy_from_table( e->caller );

	c_widget_install( e->caller );
	
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );

	printf("c_listbox_handle_create( )\n");
}

void c_listbox_handle_update( CEvent *e, void *data )
{
	//CListBoxWidgetInfo *bwi = (CListBoxWidgetInfo *)e->caller->info;

	printf( "c_listbox_handle_update( )\n" );
	
	c_send_event( e->caller, C_EVENT_DRAW, 0 );
}

CWidget *c_new_listbox( CWidget *parent, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CListBoxWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_LISTBOX;
	w->info->x = x;
	w->info->y = y;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	w->info->visible = 1;
	
	((CListBoxWidgetInfo *)w->info)->table = 0;
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_listbox_handle_create );
	c_new_event_handler( w, C_EVENT_UPDATE, c_listbox_handle_update );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}


/***

void c_listbox_set_select( CWidget *w, int a )
{
	CListBoxItem *curr, *item;
	int b = -1;
	
	for ( curr = ((CListBoxWidgetInfo *)w->info)->items; curr != NULL; curr = curr->next )
	{
		if ( curr->id == a )
		{
#ifdef ENV_WIN32
			b = curr->winid;
#endif
			item = curr;
		}
	}
	
	if ( b == -1 )
		return;
	
	((CListBoxWidgetInfo *)w->info)->selected = item;
	c_send_event( w, C_EVENT_ITEM_SELECTED, 0 );
	
#ifdef ENV_WIN32
	if ( w->info->widget != 0 )
		SendMessage( w->info->widget, LB_SETCURSEL, b, 0 );
#endif
}

void c_listbox_clear( CWidget *w )
{
	CListBoxItem *curr, *next;
	
	for ( curr = ((CListBoxWidgetInfo *)w->info)->items; curr != NULL; curr = next )
	{
		next = curr->next;
		
		free( curr->text );
		free( curr );
	}
	
	((CListBoxWidgetInfo *)w->info)->items = 0;
	
#ifdef ENV_WIN32
	if ( w->info->widget != 0 )
		SendMessage( w->info->widget, LB_RESETCONTENT, 0, 0 );
#endif
}

int c_listbox_get_item_pos( CWidget *w, int item )
{
	CListBoxItem *curr;
	int a;
	
	for ( a = 0, curr = ((CListBoxWidgetInfo *)w->info)->items; curr != NULL; curr = curr->next, a++ )
	{
		if ( item == curr->id )
			return a;
	}
	
	return -1;
}

CListBoxItem *c_listbox_get_item( CWidget *w, int item )
{
	CListBoxItem *curr;
	
	for ( curr = ((CListBoxWidgetInfo *)w->info)->items; curr != NULL; curr = curr->next )
	{
		if ( item == curr->id )
			return curr;
	}
	
	return 0;
}

int c_listbox_get_item_count( CWidget *w )
{
	CListBoxItem *curr;
	int a;
	
	for ( a = 0, curr = ((CListBoxWidgetInfo *)w->info)->items; curr != NULL; curr = curr->next, a++ )
		;
	
	return a;
}

int c_listbox_additem_at( CWidget *w, char *text, int pos )
{
	CListBoxItem *item, *curr, *prev, *head;
	
	if ( !( item = (CListBoxItem *)malloc( sizeof( CListBoxItem ) ) ) )
		return -1;
	
	item->id = ((CListBoxWidgetInfo *)w->info)->count;
	item->text = strdup( text );
	item->next = 0;
	
	((CListBoxWidgetInfo *)w->info)->count++;

	if ( pos != -1 )
	{
		int a;
		
		for ( a = 0, prev = 0, curr = ((CListBoxWidgetInfo *)w->info)->items; curr != NULL && a < pos; curr = curr->next, a++ )
			prev = curr;
		
		if ( curr == 0 )
			pos = -1; // adding it to the end, pretend that's what we were asked! ;)
		else 
		{
			item->next = curr;
			
			if ( curr == ((CListBoxWidgetInfo *)w->info)->items )
				((CListBoxWidgetInfo *)w->info)->items = item;
			
			if ( prev != 0 )
				prev->next = item;
		}
	}
	
	if ( pos == -1 )
	{
		if ( ((CListBoxWidgetInfo *)w->info)->items == 0 )
			((CListBoxWidgetInfo *)w->info)->items = item;
		else
			((CListBoxWidgetInfo *)w->info)->icurr->next = item;
		
		((CListBoxWidgetInfo *)w->info)->icurr = item;
	}
	
#ifdef ENV_WIN32
	if ( w->info->widget != 0 )
	{
		item->winid = SendMessage( w->info->widget, LB_INSERTSTRING, pos, (LPARAM)item->text );
		SendMessage( w->info->widget, LB_SETITEMDATA, item->winid, (LPARAM)item->id ); 
		
		// fix other indexes
		for ( curr = ((CListBoxWidgetInfo *)w->info)->items; curr != NULL; curr = curr->next )
		{
			if ( curr != item && curr->winid >= item->winid )
				curr->winid++;
		}
	}
#endif
	
	return item->id;
}

int c_listbox_additem( CWidget *w, char *text )
{
	c_listbox_additem_at( w, text, -1 ); // end of list, compatibility
}

void c_listbox_delitem( CWidget *w, int item )
{
	CListBoxItem *curr, *curr2, *prev;
	
	prev = 0;
	
	for ( curr = ((CListBoxWidgetInfo *)w->info)->items; curr != NULL; curr = curr->next )
	{
		if ( curr->id == item )
		{
#ifdef ENV_WIN32
			if ( w->info->widget != 0 )
				SendMessage( w->info->widget, LB_DELETESTRING, curr->winid, 0 );
#endif
			
			if ( curr->next == 0 )
				((CListBoxWidgetInfo *)w->info)->icurr = prev;
			
			if ( prev == 0 )
				((CListBoxWidgetInfo *)w->info)->items = curr->next;
			else
				prev->next = curr->next;
			
			// Allow me to take this opportunity so say FUCK YOU MICROSOFT.
			// A flea could design an API better than your developers have.
			//   - Term
			
#ifdef ENV_WIN32
			for ( curr2 = ((CListBoxWidgetInfo *)w->info)->items; curr2 != NULL; curr2 = curr2->next )
			{
				if ( curr2->winid > curr->winid )
					curr2->winid--;
			}
#endif
			
			free( curr->text );
			free( curr );
			return;
		}
		prev = curr;
	}
}

***/
