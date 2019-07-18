/*************************************************************************
$Id: profile.c 151 2005-08-10 01:10:11Z terminal $

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

CWidget *profilewin = 0;

extern CWidget *mainwin;
extern XMLItem *xidentity;
extern char filepath[4096];
extern XMLFile *config;

int savedprofile = 0;
int cansaveprof = 0;

CWidget *labels[10];
CWidget *texts[10];
CWidget *buttons[4];
CWidget *saveident, *btncancel;
CWidget *nicklist;

void b_profile_killed( )
{
	profilewin = 0;
}

void b_profile_cansave_check( )
{
	char *t1t = ((CTextBoxWidgetInfo *)texts[0]->info)->text;
	char *t2t = ((CTextBoxWidgetInfo *)texts[1]->info)->text;
	//CListBoxItem *citem;
	int a = ((CListBoxWidgetInfo *)nicklist->info)->table->rows;
	/*
	for ( citem = ((CListBoxWidgetInfo *)nicklist->info)->items; citem != 0; citem = citem->next )
		a++;
	*/
	if ( !strcmp( t1t, "" ) || !strcmp( t2t, "" ) || a == 0 )
	{
		c_widget_disable( saveident );
		cansaveprof = 0;
		return;
	}
	
	c_widget_enable( saveident );
	cansaveprof = 1;
}

void b_profile_input_changed( CEvent *e, void *data )
{
	b_profile_cansave_check( );
}

void b_profile_add_click( CEvent *e, void *data )
{
	char *nick = ((CTextBoxWidgetInfo *)texts[2]->info)->text;
	ClaroTableRow *row;
	ClaroTableCell *cell;
	ClaroTable *table = ((CListBoxWidgetInfo *)nicklist->info)->table;
	
	if ( !strcmp( nick, "" ) )
		return;
	
	//c_listbox_additem( nicklist, nick );
	row = c_tbl_insert_row( table, table->rows );
	cell = c_tbl_get_cell( table, row->pos, 0 );
	c_tbl_set_cell_data( table, row->pos, 0, strdup( nick ), 1 );
	
	c_text_settext( texts[2], "" );
	
	b_profile_cansave_check( );
	
	c_widget_focus( texts[2] );
}

void b_profile_del_click( CEvent *e, void *data )
{
	ClaroTable *table = ((CListBoxWidgetInfo *)nicklist->info)->table;
	int a;
	
	a = c_listbox_selected( nicklist );
	
	if ( a == -1 )
		return;
	
	//c_listbox_delitem( nicklist, a );
	c_tbl_delete_row( table, a );
	
	c_widget_disable( buttons[1] );
	
	b_profile_cansave_check( );
	
	c_widget_focus( nicklist );
}

void b_profile_cancel( CEvent *e, void *data )
{
	c_widget_close( profilewin );
}

void b_profile_save( CEvent *e, void *data )
{
	XMLItem *nicks;
	XMLItem *nick;
	//CListBoxItem *citem;
	int a;
	ClaroTableCell *cell;
	ClaroTable *table = ((CListBoxWidgetInfo *)nicklist->info)->table;
	
	if ( cansaveprof == 0 )
		return;
	
	if ( xidentity == 0 )
	{
		printf( "Invalid identity!\n" );
		exit( 0 );
	}
	
	c_xml_attrib_set( xidentity, "username", ((CTextBoxWidgetInfo *)texts[0]->info)->text );
	c_xml_attrib_set( xidentity, "realname", ((CTextBoxWidgetInfo *)texts[1]->info)->text );
	
	nicks = c_xml_find_child( xidentity, "nicks" );
	c_xml_clean_from( nicks->child_head );
	nicks->child_head = nicks->child_curr = 0;

	for ( a = 0; a < table->rows; a++ )
	{
		cell = c_tbl_get_cell( table, a, 0 );
		nick = c_xml_add_child( nicks, "nick" );
		if ( cell->data != 0 )
		{
			c_xml_attrib_set( nick, "name", (char *)cell->data );
		}
	}
	
	c_xml_dump_file( config, filepath );
	
	b_profile_cancel( e, data );
	
	savedprofile = 1;
}

void b_profile_load( )
{
	XMLItem *nicks;
	XMLItem *nick;
	char *nicktxt;
	char *tmp;
	ClaroTable *table = ((CListBoxWidgetInfo *)nicklist->info)->table;
	ClaroTableRow *row;
	ClaroTableCell *cell;
	
	tmp = c_xml_attrib_get( xidentity, "username" );
	if ( tmp != 0 )
		c_text_settext( texts[0], tmp );
	
	tmp = c_xml_attrib_get( xidentity, "realname" );
	if ( tmp != 0 )
		c_text_settext( texts[1], tmp );
	
	nicks = c_xml_find_child( xidentity, "nicks" );
	
	for ( nick = nicks->child_head; nick != 0; nick = nick->next )
	{
		nicktxt = c_xml_attrib_get( nick, "name" );
		
		row = c_tbl_insert_row( table, table->rows );
		cell = c_tbl_get_cell( table, row->pos, 0 );
		c_tbl_set_cell_data( table, row->pos, 0, strdup( nicktxt ), 1 );
	}
	
	b_profile_cansave_check( );
}

void b_profile_nick_changed( CEvent *e, void *data )
{
	if ( !strcmp( ((CTextBoxWidgetInfo *)e->caller->info)->text, "" ) )
	{
		c_widget_disable( buttons[0] );
		return;
	}
	
	c_widget_enable( buttons[0] );
}

void b_profile_nicklist_selected( CEvent *e, void *data );

void b_profile_up_click( CEvent *e, void *data )
{
	ClaroTable *table = ((CListBoxWidgetInfo *)nicklist->info)->table;
	int a;
	//ClaroTableRow *row;
	
	a = c_listbox_selected( nicklist );
	
	if ( a < 0 )
		return;
		
	c_tbl_move_row( table, a, a-1 );
	
	b_profile_nicklist_selected( e, data );
}

void b_profile_down_click( CEvent *e, void *data )
{
	ClaroTable *table = ((CListBoxWidgetInfo *)nicklist->info)->table;
	int a;
	//ClaroTableRow *row;
	
	a = c_listbox_selected( nicklist );
	
	if ( a < 0 )
		return;
		
	c_tbl_move_row( table, a, a+1 );
	
	b_profile_nicklist_selected( e, data );
}

void b_profile_nicklist_selected( CEvent *e, void *data )
{
	int a, b, c;
	
	a = c_listbox_selected( nicklist );
	
	if ( a == -1 )
	{
		c_widget_disable( buttons[1] );
		c_widget_disable( buttons[2] );
		c_widget_disable( buttons[3] );
		return;
	}
	
	c_widget_enable( buttons[1] );
	
	b = a;
	c = c_listbox_get_item_count( nicklist );
	
	if ( b > 0 )
		c_widget_enable( buttons[2] );
	else
		c_widget_disable( buttons[2] );
	
	if ( b < c-1 )
		c_widget_enable( buttons[3] );
	else
		c_widget_disable( buttons[3] );
}

void b_open_profile( )
{
	int y, yi, w, h;
	ClaroTable *table;
	int x_offset = 130;
	
	w = 500;
	h = 400;
	yi = 30;
	
	if ( profilewin == 0 )
	{
		profilewin = c_new_window( mainwin, lang_phrase_quick( "profile_man" ), w, h, C_DIALOG | C_WINDOW_CENTER_TO_PARENT );
		c_window_set_icon( profilewin, b_icon( "profile_man" ) );
		c_new_event_handler( profilewin, C_EVENT_DESTROY, b_profile_killed );
		
		//lang_phrase_quick( "profilewin_" )
		
		y = 10;
		labels[0] = c_new_label( profilewin, lang_phrase_quick( "profilewin_username" ), 10, y, x_offset, -1, 0 );
		texts[0] = c_new_text( profilewin, "bersirc", x_offset, y, w-x_offset-10, -1, 0 );
		c_widget_focus( texts[0] );
		y += yi;
		labels[1] = c_new_label( profilewin, lang_phrase_quick( "profilewin_realname" ), 10, y, x_offset, -1, 0 );
		texts[1] = c_new_text( profilewin, "Bersirc User", x_offset, y, w-x_offset-10, -1, 0 );
		y += yi;
		labels[2] = c_new_label( profilewin, lang_phrase_quick( "profilewin_nickname" ), 10, y, x_offset, -1, 0 );
		texts[2] = c_new_text( profilewin, "", x_offset, y, w-x_offset-10-220, -1, 0 );
		buttons[0] = c_new_pushbutton( profilewin, lang_phrase_quick( "profilewin_btn_add" ), w-220, y, 50, -1, 0 );
		buttons[1] = c_new_pushbutton( profilewin, lang_phrase_quick( "profilewin_btn_del" ), w-168, y, 50, -1, 0 );
		buttons[2] = c_new_pushbutton( profilewin, lang_phrase_quick( "profilewin_btn_up" ), w-116, y, 50, -1, 0 );
		buttons[3] = c_new_pushbutton( profilewin, lang_phrase_quick( "profilewin_btn_down" ), w-64, y, 50, -1, 0 );
		c_widget_disable( buttons[0] );
		c_widget_disable( buttons[1] );
		c_widget_disable( buttons[2] );
		c_widget_disable( buttons[3] );
		y += yi;
		nicklist = c_new_listbox( profilewin, x_offset, y, w-x_offset-10, 100, 0 );
		table = c_tbl_create( 1 );
		c_listbox_attach_table( nicklist, table, 0 );
		y += 120;
		saveident = c_new_pushbutton( profilewin, lang_phrase_quick( "save_ident" ), x_offset, y, 150, -1, 0 );
		btncancel = c_new_pushbutton( profilewin, lang_phrase_quick( "cancel" ), x_offset+150+10, y, 150, -1, 0 );
		c_widget_move_info( profilewin, 0, 0, w, y + yi ); // update height
		
		c_widget_disable( saveident );
		
		c_window_maxsize( profilewin, w, y + yi );
		c_window_minsize( profilewin, w, y + yi );
		
		c_new_event_handler( buttons[0], C_EVENT_BUTTON_PRESS, b_profile_add_click );
		c_new_event_handler( buttons[1], C_EVENT_BUTTON_PRESS, b_profile_del_click );
		c_new_event_handler( buttons[2], C_EVENT_BUTTON_PRESS, b_profile_up_click );
		c_new_event_handler( buttons[3], C_EVENT_BUTTON_PRESS, b_profile_down_click );
		c_new_event_handler( nicklist, C_EVENT_ITEM_SELECTED, b_profile_nicklist_selected );
		c_new_event_handler( texts[2], C_EVENT_TEXT_CHANGED, b_profile_nick_changed );
		c_new_event_handler( texts[2], C_EVENT_TEXT_ENTER, b_profile_add_click );
		c_new_event_handler( texts[0], C_EVENT_TEXT_CHANGED, b_profile_input_changed );
		c_new_event_handler( texts[1], C_EVENT_TEXT_CHANGED, b_profile_input_changed );
		c_new_event_handler( saveident, C_EVENT_BUTTON_PRESS, b_profile_save );
		c_new_event_handler( btncancel, C_EVENT_BUTTON_PRESS, b_profile_cancel );
		c_new_event_handler( profilewin, C_EVENT_DIALOG_OK, b_profile_save );
		
		b_profile_load( );
	}
	else
	{
		c_widget_focus( profilewin );
	}
}
