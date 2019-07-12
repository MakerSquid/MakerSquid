/*************************************************************************
$Id$

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

CWidget *autowin = 0;

extern CWidget *mainwin;
extern XMLItem *xidentity;
extern char filepath[4096];
extern XMLFile *config;

CWidget *autowin_servlist;
ClaroTable *autowin_table = 0;

void b_autowin_run( BServerWindow *first )
{
	BServerWindow *sw = first;
	ClaroTable *table = autowin_table;
	ClaroTableCell *cell;
	int a;
	char *place = "";
	char *server = "";
	int iport = 6667;
	char *pass = "";
	
	for ( a = 0; a < table->rows; a++ )
	{
		if ( a > 0 || sw == 0 )
			sw = b_new_server_window( 0 );
		
		cell = c_tbl_get_cell( table, a, 0 );
		if ( cell->data != 0 )
			server = (char *)cell->data;
		
		cell = c_tbl_get_cell( table, a, 1 );
		if ( cell->data != 0 )
			place = (char *)cell->data;
		
		// tell sw where to go after connect
		b_server_onconnect_goto( sw, place );
		
		// set password
		strcpy( sw->password, pass );
		
		// connect sw to server
		b_server_connect( sw, server, iport );
	}
}

void b_autowin_gui_init( )
{
	XMLItem *autoi, *autoc;
	ClaroTable *table;
	ClaroTableRow *row;
	char *nametxt, *chantxt;
	
	if ( autowin_table == 0 )
		autowin_table = c_tbl_create( 9 );
	
	table = autowin_table;
	
	autoi = c_xml_find_child( xidentity, "auto-connect" );
	
	if ( autoi == 0 )
		return;

	for ( autoc = autoi->child_head; autoc != 0; autoc = autoc->next )
	{
		nametxt = c_xml_attrib_get( autoc, "name" );
		chantxt = c_xml_attrib_get( autoc, "channels" );
		
		row = c_tbl_insert_row( table, table->rows );
		c_tbl_set_cell_data( table, row->pos, 0, strdup( nametxt ), 1 );
		c_tbl_set_cell_data( table, row->pos, 1, strdup( chantxt ), 1 );
	}
}

void b_autowin_gui_save( )
{
	XMLItem *autoi, *autoc;
	ClaroTable *table = autowin_table;
	ClaroTableCell *cell;
	int a;
	
	if ( xidentity == 0 )
	{
		printf( "Invalid identity!\n" );
		exit( 0 );
	}
	
	// remove all items
	autoi = c_xml_find_child( xidentity, "auto-connect" );
	if ( autoi != 0 )
	{
		c_xml_clean_from( autoi->child_head );
		autoi->child_head = autoi->child_curr = 0;
	}
	else
	{
		autoi = c_xml_add_child( xidentity, "auto-connect" );
	}
	
	for ( a = 0; a < table->rows; a++ )
	{
		autoc = c_xml_add_child( autoi, "server" );
		
		cell = c_tbl_get_cell( table, a, 0 );
		if ( cell->data != 0 )
			c_xml_attrib_set( autoc, "name", (char *)cell->data );
		
		cell = c_tbl_get_cell( table, a, 1 );
		if ( cell->data != 0 )
			c_xml_attrib_set( autoc, "channels", (char *)cell->data );
	}
	
	c_xml_dump_file( config, filepath );
}

void b_autowin_killed( )
{
	b_autowin_gui_save( );
	
	autowin = 0;
	autowin_servlist = 0;
}

void b_autowin_close( CEvent *e, void *data )
{
	c_widget_close( autowin );
}

CWidget *autoeditwin = 0;

void b_autoeditwin_killed( )
{
	autoeditwin = 0;
	
	b_open_autowin( );
}

void b_autoeditwin_close( CEvent *e, void *data )
{
	c_widget_close( autoeditwin );
}

CWidget *aew_txt_server, *aew_txt_channels;
int aew_edit_item;

void b_autoeditwin_save( CEvent *e, void *data )
{
	ClaroTableRow *row;
	int pos;

	if ( strcmp( ((CTextBoxWidgetInfo *)aew_txt_server->info)->text, "" ) == 0 )
		return;
	
	if ( aew_edit_item == -1 )
	{
		row = c_tbl_insert_row( autowin_table, autowin_table->rows );
		pos = row->pos;
	}
	else
	{
		pos = aew_edit_item;
	}
	
	c_tbl_set_cell_data( autowin_table, pos, 0, strdup( ((CTextBoxWidgetInfo *)aew_txt_server->info)->text ), 1 );
	c_tbl_set_cell_data( autowin_table, pos, 1, strdup( ((CTextBoxWidgetInfo *)aew_txt_channels->info)->text ), 1 );
	
	b_autoeditwin_close( 0, 0 );
}

CWidget *aw_btnsave, *aw_btncancel;

void b_autoeditwin_txtchanged( CEvent *e, void *data )
{
	if ( !strcmp( ((CTextBoxWidgetInfo *)e->caller->info)->text, "" ) )
	{
		c_widget_disable( aw_btnsave );
		return;
	}
	
	c_widget_enable( aw_btnsave );
}

void create_autoeditwin( int item )
{
	int w, h, btn_w;
	char *srv_title, *chan_title, *srv_text, *chn_text;
	int text_w, b;
	CWidget *aew_lbl_server, *aew_lbl_channels;
	
	aew_edit_item = item;
	
	w = 400;
	h = 120;
	btn_w = (w-20-(10*(2-1))) / 2;
	
	autoeditwin = c_new_window( mainwin, lang_phrase_quick( (item==-1?"addserver_t":"editserver_t") ), w, h, C_DIALOG | C_WINDOW_CENTER_TO_PARENT );
	c_window_maxsize( autoeditwin, w, h );
	c_window_minsize( autoeditwin, w, h );
	c_new_event_handler( autoeditwin, C_EVENT_DESTROY, b_autoeditwin_killed );
	
	// input
	
	srv_title = lang_phrase_quick( "serveraddy_inp" );
	chan_title = lang_phrase_quick( "channels_inp" );
	
	srv_text = "";
	chn_text = "";
	
	if ( item != -1 )
	{
		srv_text = c_tbl_get_cell( autowin_table, item, 0 )->data;
		chn_text = c_tbl_get_cell( autowin_table, item, 1 )->data;
	}
	
	text_w = c_font_get_string_width( mainwin, srv_title, strlen( srv_title ) );
	b = c_font_get_string_width( mainwin, chan_title, strlen( chan_title ) );
	if ( b > text_w )
		text_w = b;
	text_w += 20;
	
	aew_lbl_server = c_new_label( autoeditwin, srv_title, 10, 20, text_w, -1, 0 );
	aew_txt_server = c_new_text( autoeditwin, srv_text, text_w, 18, w-text_w-20, -1, 0 );
	
	aew_lbl_channels = c_new_label( autoeditwin, chan_title, 10, 50, text_w, -1, 0 );
	aew_txt_channels = c_new_text( autoeditwin, chn_text, text_w, 48, w-text_w-20, -1, 0 );
	
	c_new_event_handler( autoeditwin, C_EVENT_DIALOG_OK, b_autoeditwin_save );
	c_new_event_handler( aew_txt_server, C_EVENT_TEXT_CHANGED, b_autoeditwin_txtchanged );
	c_widget_focus( aew_txt_server );
	
	// buttons
	
	aw_btnsave = c_new_pushbutton( autoeditwin, lang_phrase_quick( "save" ), 10, h-10-20, btn_w, -1, 0 );
	aw_btncancel = c_new_pushbutton( autoeditwin, lang_phrase_quick( "cancel" ), 10+btn_w+10, h-10-20, btn_w, -1, 0 );
	
	c_new_event_handler( aw_btnsave, C_EVENT_BUTTON_PRESS, b_autoeditwin_save );
	c_new_event_handler( aw_btncancel, C_EVENT_BUTTON_PRESS, b_autoeditwin_close );
	
	c_widget_disable( aw_btnsave );
}

void b_autowin_add( CEvent *e, void *data )
{
	c_widget_close( autowin );
	
	create_autoeditwin( -1 );
}

void b_autowin_edit( CEvent *e, void *data )
{
	int a = c_listview_selected( autowin_servlist );
	
	c_widget_close( autowin );
	
	create_autoeditwin( a );
}

CWidget *btnadd, *btnedit, *btndelete, *btncancel;

void b_autowin_delete( CEvent *e, void *data )
{
	int a = c_listview_selected( autowin_servlist );
	
	if ( a < 0 )
		return;
	
	c_tbl_delete_row( autowin_table, a );
	
	c_widget_disable( btndelete );
	c_widget_disable( btnedit );
}

void b_autowin_serversel( CEvent *e, void *data )
{
	int a = c_listview_selected( autowin_servlist );
	
	if ( a < 0 )
	{
		c_widget_disable( btndelete );
		c_widget_disable( btnedit );
		return;
	}
	
	c_widget_enable( btndelete );
	c_widget_enable( btnedit );
}

void b_open_autowin( )
{
	int y, yi, w, h, mpos;
	int btn_w;
	
	w = 650;
	h = 200;
	yi = 30;
	mpos = 120;
	
	if ( autowin == 0 )
	{
		autowin = c_new_window( mainwin, lang_phrase_quick( "autoconnectwin" ), w, h, C_DIALOG | C_WINDOW_CENTER_TO_PARENT );
		//c_window_set_icon( autowin, b_icon( (type==0?"connect_inp":"connect") ) );
		c_window_maxsize( autowin, w, h );
		c_window_minsize( autowin, w, h );
		c_new_event_handler( autowin, C_EVENT_DESTROY, b_autowin_killed );
		
		y = 10;
		
		autowin_servlist = c_new_listview( autowin, 10, 10, w-20, h-20-30, 0 );
		c_listview_attach_table( autowin_servlist, autowin_table );
		
		c_listview_add_table_column( autowin_servlist, lang_phrase_quick( "serveraddy" ), 0, 0 );
		c_listview_add_table_column( autowin_servlist, lang_phrase_quick( "channels" ), 1, 1 );
		//c_listview_add_table_column( autowin_servlist, "Enabled", 2, 2 );
		
		btn_w = ((w-20-20)/4);
		
		btnadd = c_new_pushbutton( autowin, lang_phrase_quick( "addserver" ), 10, h-10-20, btn_w, -1, 0 );
		btnedit = c_new_pushbutton( autowin, lang_phrase_quick( "editserver" ), 10+btn_w+10, h-10-20, btn_w, -1, 0 );
		btndelete = c_new_pushbutton( autowin, lang_phrase_quick( "deleteserver" ), 10+btn_w+10+btn_w+10, h-10-20, btn_w, -1, 0 );
		btncancel = c_new_pushbutton( autowin, lang_phrase_quick( "close" ), 10+btn_w+10+btn_w+10+btn_w+10, h-10-20, btn_w, -1, 0 );
		
		// no edit or delete until selected
		c_widget_disable( btndelete );
		c_widget_disable( btnedit );
		
		c_new_event_handler( autowin_servlist, C_EVENT_ITEM_SELECTED, b_autowin_serversel );
		c_new_event_handler( btnadd, C_EVENT_BUTTON_PRESS, b_autowin_add );
		c_new_event_handler( btnedit, C_EVENT_BUTTON_PRESS, b_autowin_edit );
		c_new_event_handler( btndelete, C_EVENT_BUTTON_PRESS, b_autowin_delete );
		c_new_event_handler( btncancel, C_EVENT_BUTTON_PRESS, b_autowin_close );
	}
	else
	{
		c_widget_focus( autowin );
	}
}
