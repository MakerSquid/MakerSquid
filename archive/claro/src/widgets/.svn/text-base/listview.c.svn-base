/*************************************************************************
$Id$

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

/*
CWidget *c_new_listview( CWidget *parent, int x, int y, int width, int height, int flags );
void c_listview_attach_table( CWidget *w, ClaroTable *tbl );
void c_listview_add_table_column( CWidget *w, char *title, int table_col, int dest_col );
*/

int c_listview_selected( CWidget *w )
{
	return ((CListViewWidgetInfo *)w->info)->selected;
}

/*
void c_listview_set_select( CWidget *w, int a )
{
	CListViewWidgetInfo *wi = (CListViewWidgetInfo *)w->info;
#ifdef ENV_WIN32
	if ( w->info->widget != 0 )
		SendMessage( w->info->widget, LB_SETCURSEL, a, 0 );
#endif
	wi->selected = wi->table->lookup[a];
	c_send_event( w, C_EVENT_ITEM_SELECTED, 0 );
}
*/

int c_listview_get_item_count( CWidget *w )
{
	CListViewWidgetInfo *wi = (CListViewWidgetInfo *)w->info;
	return wi->table->rows;
}

void c_listview_copy_from_table( CWidget *w )
{
	CListViewWidgetInfo *wi = (CListViewWidgetInfo *)w->info;
	
#ifdef ENV_WIN32
	HWND hwnd = w->info->widget;
#endif
	
#ifdef ENV_WIN32
	// tell Windows the new number of items we contain..
	SendMessage( hwnd, LVM_SETITEMCOUNT, (WPARAM)wi->table->rows, 0 );
#endif
}

void c_listview_table_notify( int msg, ClaroTable *table, ClaroTableRow *row, ClaroTableCell *celli )
{
	CWidget *w = (CWidget *)table->ndata;
	CListViewWidgetInfo *wi;
	//ClaroTableCell *cell;
	//char *txt;
	
	if ( w == 0 || w->info->widget == 0 )
		return;
	
	wi = (CListViewWidgetInfo *)w->info;
	
	switch ( msg ) {
		case C_TABLE_NOTIFY_INSERT_ROW:
			c_listview_copy_from_table( w );
			break;
		case C_TABLE_NOTIFY_REMOVE_ROW:
			c_listview_copy_from_table( w );
			break;
		case C_TABLE_NOTIFY_MOVE_ROW:
			c_listview_copy_from_table( w );
			break;
		case C_TABLE_NOTIFY_CHANGE_CELL:
			c_listview_copy_from_table( w );
			break;
	}
}

void c_listview_attach_table( CWidget *w, ClaroTable *tbl )
{
	CListViewWidgetInfo *wi = (CListViewWidgetInfo *)w->info;
	
	wi->table = tbl;
	tbl->ndata = w;
	
	c_tbl_set_notify( tbl, c_listview_table_notify );
	
	if ( w->info->widget != 0 )
	{
		// widget created, run initial insert
		c_listview_copy_from_table( w );
	}
}

void c_listview_restore_columns( CWidget *w )
{
	CListViewWidgetInfo *wi = (CListViewWidgetInfo *)w->info;
	int a;
	
	for ( a = 0; a < wi->col_num; a++ )
	{
#ifdef ENV_WIN32
		LVCOLUMN lc;
		
		memset( &lc, 0, sizeof( LVCOLUMN ) );
		
		lc.mask = LVCF_FMT | LVCF_TEXT | LVCF_SUBITEM;
		lc.fmt = LVCFMT_LEFT;
		lc.pszText = wi->columns[a].title;
		lc.cchTextMax = strlen( wi->columns[a].title ) + 1;
		lc.iSubItem = wi->columns[a].table_cell;
		
		SendMessage( w->info->widget, LVM_INSERTCOLUMN, wi->columns[a].listview_cell, (LPARAM)&lc );
#endif

#ifdef ENV_CARBON
	DataBrowserListViewColumnDesc cd;
	CFStringRef str;
	OSStatus oserr;
	
	if ( w->info->widget == 0 )
		return;
	
	memset( &cd, 0, sizeof(DataBrowserListViewColumnDesc) );
	
	str = CFStringCreateWithCString( NULL, wi->columns[a].title, strlen( wi->columns[a].title ) );
	
	cd.propertyDesc.propertyID = 0x430000 + wi->columns[a].table_cell;
	cd.propertyDesc.propertyType = kDataBrowserTextType;
	cd.propertyDesc.propertyFlags = kDataBrowserDefaultPropertyFlags;
	
	cd.headerBtnDesc.version = kDataBrowserListViewLatestHeaderDesc;
	
	cd.headerBtnDesc.minimumWidth = 100;
	cd.headerBtnDesc.maximumWidth = 500;

	cd.headerBtnDesc.titleOffset = 0;
	
	cd.headerBtnDesc.titleString = str;
	
	cd.headerBtnDesc.initialOrder = kDataBrowserOrderIncreasing;
	
	cd.headerBtnDesc.btnFontStyle.flags = 0;
	
	cd.headerBtnDesc.btnContentInfo.contentType = kControlContentTextOnly;
	
	if ( ( oserr = AddDataBrowserListViewColumn( w->info->widget, &cd, ULONG_MAX ) ) != noErr )
	{
		printf( "Error: %x ? %x ? %x\n", oserr, paramErr, noErr );
		ExitToShell();
	}
	
	CFRelease( str );
#endif
	}
}

void c_listview_autosize_columns( CWidget *w )
{
	CListViewWidgetInfo *wi = (CListViewWidgetInfo *)w->info;
	int a;
	
	for ( a = 0; a < wi->col_num; a++ )
	{
#ifdef ENV_WIN32
		SendMessage( w->info->widget, LVM_SETCOLUMNWIDTH, wi->columns[a].listview_cell, LVSCW_AUTOSIZE_USEHEADER ); //LVSCW_AUTOSIZE );
#endif
	}
}

void c_listview_autosize_columns_content( CWidget *w )
{
	CListViewWidgetInfo *wi = (CListViewWidgetInfo *)w->info;
	int a;
	
	for ( a = 0; a < wi->col_num; a++ )
	{
#ifdef ENV_WIN32
		SendMessage( w->info->widget, LVM_SETCOLUMNWIDTH, wi->columns[a].listview_cell, LVSCW_AUTOSIZE );
#endif
	}
}

#ifdef ENV_CARBON
OSStatus MySimpleDataCallback(
	ControlRef browser,
	DataBrowserItemID itemID,
	DataBrowserPropertyID property,
	DataBrowserItemDataRef itemData,
	Boolean changeValue) {
	
	OSStatus err;

	/* look at the property ID and decide what to do
	depending on what column we're dealing with... */
//	if (property == kMyCheckboxColumn) {
//		ThemeButtonValue buttonValue;
//
//			/* are we being asked to change the value
//			we have in our own store or are we being
//			asked to retried the value?  You'll only
//			have ask this question for mutable columns. */
//		if (changeValue) {
///*
//			err = GetDataBrowserItemDataButtonValue(itemData,
//								 &buttonValue);
//			if (err != noErr) goto bail;
//
//				// NOTE: our internal storage lookup mechanism must
//				//map itemID numbers to the values stored for each
//				//button in the list.
//			err = StoreTheValueSomewhere(itemID, buttonValue);
//			if (err != noErr) goto bail;
//*/
//		} else {
//
//			err = GetTheButtonValueFromSomewhere(itemID, &buttonValue);
//			if (err != noErr) goto bail;
//
//			err = SetDataBrowserItemDataButtonValue(itemData,
//					buttonValue);
//			if (err != noErr) goto bail;
//		}
//
//	} else {
//		err = errDataBrowserPropertyNotSupported
//		goto bail;
//	}

	return noErr;

bail:
	return err;
}
#endif

void c_listview_add_table_column( CWidget *w, char *title, int table_col, int dest_col )
{
	CListViewWidgetInfo *wi = (CListViewWidgetInfo *)w->info;
	//ClaroTable *tbl = wi->table;
	int a;
	
	a = wi->col_num;
	
	wi->col_num++;
	wi->columns = (CListViewCellLink *)realloc( wi->columns, wi->col_num * sizeof(CListViewCellLink) );
	
	wi->columns[a].title = title;
	
	wi->columns[a].table_cell = table_col;
	wi->columns[a].listview_cell = dest_col;
	
#ifdef ENV_WIN32
	LVCOLUMN lc;
	
	memset( &lc, 0, sizeof( LVCOLUMN ) );
	
	lc.mask = LVCF_FMT | LVCF_TEXT | LVCF_SUBITEM;
	lc.fmt = LVCFMT_LEFT;
	lc.pszText = title;
	lc.cchTextMax = strlen( title ) + 1;
	lc.iSubItem = table_col;
	
	if ( w->info->widget != 0 )
		SendMessage( w->info->widget, LVM_INSERTCOLUMN, dest_col, (LPARAM)&lc );
#endif

#ifdef ENV_CARBON
	DataBrowserListViewColumnDesc cd;
	CFStringRef str;
	OSStatus oserr;
	
	if ( w->info->widget == 0 )
		return;
	
	memset( &cd, 0, sizeof(DataBrowserListViewColumnDesc) );
	
	str = CFStringCreateWithCString( NULL, title, strlen( title ) );
	
	cd.propertyDesc.propertyID = 0x430000 + table_col;
	cd.propertyDesc.propertyType = kDataBrowserTextType;
	cd.propertyDesc.propertyFlags = kDataBrowserDefaultPropertyFlags;
	
	cd.headerBtnDesc.version = kDataBrowserListViewLatestHeaderDesc;
	
	cd.headerBtnDesc.minimumWidth = 100;
	cd.headerBtnDesc.maximumWidth = 500;

	cd.headerBtnDesc.titleOffset = 0;
	
	cd.headerBtnDesc.titleString = NULL;//str;
	
	cd.headerBtnDesc.initialOrder = kDataBrowserOrderIncreasing;
	
	cd.headerBtnDesc.btnFontStyle.flags = 0;
	
	cd.headerBtnDesc.btnContentInfo.contentType = kControlContentTextOnly;
	
	if ( ( oserr = AddDataBrowserListViewColumn( w->info->widget, &cd, ULONG_MAX ) ) != noErr )
	{
		printf( "Error: %x ? %x ? %x\n", oserr, paramErr, noErr );
		//ExitToShell();
	}
	
	//CFRelease( str );
#endif
}

void c_listview_handle_create( CEvent *e, void *data )
{
	CListViewWidgetInfo *bwi = (CListViewWidgetInfo *)e->caller->info;

#ifdef ENV_GTK
	#warning "No GTK port for c_listview coded"
#endif

#ifdef ENV_CARBON
	Rect boundsList = { 0, 0, 0, 0 };
	DataBrowserCallbacks dbc;
	
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
	
	if ( ( CreateDataBrowserControl( e->caller->parent->info->widget, &boundsList, kDataBrowserListView, &e->caller->info->widget ) != noErr )
			|| ( e->caller->info->widget == NULL ) )	 ExitToShell();
	
	InitDataBrowserCallbacks( &dbc );
	SetDataBrowserCallbacks( e->caller->info->widget, &dbc );
#endif

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;
	int flags = e->caller->info->flags;
	//CListViewItem *curr;

	if ( !( hwnd = CreateWindowEx( ( flags & C_BORDER_NONE ? 0 : WS_EX_CLIENTEDGE ), WC_LISTVIEW, 
								   "",
								   WS_CHILD | WS_TABSTOP | LVS_AUTOARRANGE | LVS_OWNERDATA | LVS_REPORT,//WS_VSCROLL | WS_HSCROLL | LVS_AUTOARRANGE | LVS_OWNERDATA | LVS_REPORT | LVS_LIST,
								   bwi->info.x, bwi->info.y,
								   bwi->info.width, bwi->info.height,
								   hwnd_parent,
								   NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create listview HWND.", "Claro error", 0 );
	
	SendMessage( hwnd, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT );
	
	e->caller->info->widget = hwnd;
	
	c_font_fix( e->caller );
	
	ShowWindow( hwnd, SW_SHOW );
	UpdateWindow( hwnd );
#endif
	
	c_listview_restore_columns( e->caller );

	c_listview_copy_from_table( e->caller );
	
	c_listview_autosize_columns( e->caller );
	//c_listview_autosize_columns_content( e->caller );

	c_widget_install( e->caller );
	
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );

	printf("c_listview_handle_create( )\n");
}

void c_listview_handle_update( CEvent *e, void *data )
{
	printf( "c_listview_handle_update( )\n" );
	
	c_send_event( e->caller, C_EVENT_DRAW, 0 );
}

void c_listview_handle_destroy( CEvent *e, void *data )
{
	CListViewWidgetInfo *wi = (CListViewWidgetInfo *)e->caller->info;
	ClaroTable *tbl = wi->table;
	
	if ( tbl == 0 )
		return;
	
	tbl->ndata = 0;
}

CWidget *c_new_listview( CWidget *parent, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CListViewWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_LISTVIEW;
	w->info->x = x;
	w->info->y = y;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	w->info->visible = 1;
	
	((CListViewWidgetInfo *)w->info)->table = 0;
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_listview_handle_create );
	c_new_event_handler( w, C_EVENT_UPDATE, c_listview_handle_update );
	c_new_event_handler( w, C_EVENT_DESTROY, c_listview_handle_destroy );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
