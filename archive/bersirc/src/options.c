/*************************************************************************
$Id: options.c 175 2005-10-17 02:54:21Z terminal $

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

/*** OPTIONS DEFAULTS ***/

typedef struct
{
	char *section;
	char *name;
	char *value;
} BOptionDefault;

#define CD_GREEN  "#005E00"
#define CD_BLUE   "#003264"
#define CD_RED    "#B90000"
#define CD_PURPLE "#5E138C"
#define CD_BLACK  "#000000"
#define CD_GREY   "#4B4B4B"
#define CD_BROWN  "#804000"
#define CD_LGREY  "#AAAAAA"
#define CD_WHITE  "#FFFFFF"

BOptionDefault b_opt_defaults[] = {
	
	// general
	{ "general", "opt_gen_open_new_query", "true" },
	{ "general", "opt_gen_show_ping_pong", "false" },
	{ "general", "opt_gen_flash_on_message", "true" },
	{ "general", "opt_gen_flash_times", "1" },
	{ "general", "opt_gen_close_on_part", "false" },
	{ "general", "opt_gen_rejoin_on_kick", "false" },
	{ "general", "opt_gen_language", "en_uk" },
	
	// misc (general)
	{ "general", "opt_misc_quit_message", "" },
	{ "general", "opt_misc_quit_in_query", "true" },
	{ "general", "opt_misc_nick_in_query", "true" },
	{ "general", "opt_misc_nick_update_query", "true" },
	{ "general", "opt_misc_hide_version", "false" },
	
	// systray
	{ "general", "opt_gen_show_in_systray", "false" },
	{ "general", "opt_gen_min_to_systray", "false" },
	
	// state
	{ "state", "main_x", "100" },
	{ "state", "main_y", "100" },
	{ "state", "main_width", "600" },
	{ "state", "main_height", "400" },
	{ "state", "main_maximise", "true" },
	{ "state", "main_minimise", "false" },
	
	// time
	{ "time", "opt_time_line_timestamp", "[%H:%M]" },
	{ "time", "opt_time_long_timestamp", "%A, %d %B %Y at %H:%M:%S" },
	
	// colours
	{ "colours", "ClientWelcome", CD_GREEN },
	{ "colours", "ConnectionMsg", CD_BLUE },
	{ "colours", "Error", CD_RED },
	{ "colours", "PingPong", CD_GREY },
	{ "colours", "UserJoin", CD_GREEN },
	{ "colours", "Info", CD_BLUE },
	{ "colours", "UserQuit", CD_BLUE },
	{ "colours", "UserNick", CD_GREEN },
	{ "colours", "TopicChange", CD_GREEN },
	{ "colours", "MOTD", CD_BLACK },
	{ "colours", "UserPart", CD_GREEN },
	{ "colours", "CTCP", CD_RED },
	{ "colours", "Notice", CD_BROWN },
	{ "colours", "Alert", CD_RED },
	{ "colours", "Topic", CD_GREEN },
	{ "colours", "UserKick", CD_GREEN },
	{ "colours", "TopicTime", CD_GREEN },
	{ "colours", "Debug", CD_RED },
	{ "colours", "TimeStamp", CD_LGREY },
	{ "colours", "WindowOpen", CD_GREEN },
	{ "colours", "Action", CD_PURPLE },
	{ "colours", "Message", CD_BLACK },
	{ "colours", "PluginMsg", CD_BLUE },
	{ "colours", "ServerWelcome", CD_BLACK },
	{ "colours", "Background", CD_WHITE },
	{ "colours", "ModeChange", CD_GREEN },
	{ "colours", "Highlight", "#316AC5" },
	{ "colours", "HighlightText", "#FFFFFF" },
	{ "colours", "Whois", "#006A9D" },
	{ "colours", "Invite", CD_RED },
	{ "colours", "Wallops", CD_BROWN },
	
	// end of defaults
	{ 0 },
};

/*** OPTIONS FUNCTIONS ***/

char *b_get_option_default( char *root, char *sub )
{
	int a;
	
	for ( a = 0; b_opt_defaults[a].section != 0; a++ )
	{
		if ( !strcasecmp( b_opt_defaults[a].section, root ) && !strcasecmp( b_opt_defaults[a].name, sub ) )
			return b_opt_defaults[a].value;
	}
	
	return "";
}

char *b_get_option_string( XMLItem *identity, char *root, char *sub )
{
	XMLItem *general, *item;
	char *attr;
	
	general = c_xml_find_child( identity, root );
	
	if ( general == 0 )
		return b_get_option_default( root, sub ); // default
	
	item = c_xml_find_child( general, sub );
	
	if ( item == 0 )
		return b_get_option_default( root, sub ); // default
	
	attr = c_xml_attrib_get( item, "value" );
	
	if ( attr == 0 )
		return b_get_option_default( root, sub ); // default
	
	return attr;
}

int b_get_option_bool( XMLItem *identity, char *root, char *sub )
{
	char *ret;
	
	ret = b_get_option_string( identity, root, sub );
	
	if ( ret == 0 )
		return 0; // false, because it's not there
	
	if ( !strcasecmp( ret, "true" ) )
		return 1;
	
	return 0;
}

int b_get_option_int( XMLItem *identity, char *root, char *sub )
{
	char *ret;
	
	ret = b_get_option_string( identity, root, sub );
	
	if ( ret == 0 )
		return 0; // false, because it's not there
	
	return atoi( ret );
}

void b_set_option_string( XMLItem *identity, char *root, char *sub, char *value )
{
	XMLItem *general, *item;
	
	general = c_xml_find_child( identity, root );
	
	if ( general == 0 )
		general = c_xml_add_child( identity, root );
	
	item = c_xml_find_child( general, sub );
	
	if ( item == 0 )
		item = c_xml_add_child( general, sub );
	
	c_xml_attrib_set( item, "value", value );
}

void b_set_option_bool( XMLItem *identity, char *root, char *sub, int value )
{
	b_set_option_string( identity, root, sub, (value?"true":"false") );
}

void b_set_option_int( XMLItem *identity, char *root, char *sub, int value )
{
	char tmp[128];
	
	sprintf( tmp, "%d", value );
	
	b_set_option_string( identity, root, sub, tmp );
}


/*** OPTIONS WINDOW ***/


CWidget *optionswin = 0;

extern CWidget *mainwin;
extern XMLItem *xidentity;
extern char filepath[4096];
extern XMLFile *config;
ClaroTable *opt_cats_tbl;

CWidget *opt_categories=0;

typedef struct
{
	CWidget *page;
	void (*save_func)( B_OPTS_PAGE_SAVE_PARMS );
} BOptionsPageLink;

int boptnums = 0, lastselected = -1;
BOptionsPageLink *boptlinks = 0;
CWidget *b_opt_active = 0;

void b_options_killed( )
{
	optionswin = 0;
	
	free( boptlinks );
	b_opt_active = 0;
	boptnums = 0;
	boptlinks = 0;
	lastselected = -1;
	c_tbl_empty( opt_cats_tbl );
	free( opt_cats_tbl );
	opt_cats_tbl = 0;
}

void b_options_cancel( CEvent *e, void *data )
{
	c_widget_close( optionswin );
}

void b_options_save( CEvent *e, void *data )
{
	int a;
	
	for ( a = 0; a < boptnums; a++ )
	{
		(*(boptlinks[a].save_func))( xidentity );
	}
	
	c_xml_dump_file( config, filepath );
	
	c_widget_close( optionswin );
}

void b_opt_cat_selected( CEvent *e, void *data )
{
	int a, b;
	ClaroTableCell *cell;
	
	a = c_listbox_selected( e->caller );
	
	if ( a == -1 || ( a == lastselected ) )
		return;
	
	cell = c_tbl_get_cell( opt_cats_tbl, a, 1 );
	
	b = (int)cell->data;
	lastselected = a;
	
	if ( b_opt_active != 0 )
		c_widget_hide( b_opt_active );
	
	c_widget_show( boptlinks[b].page );
	
	b_opt_active = boptlinks[b].page;
}

void b_options_begin_page( int sub, char *langtext, CWidget * (*func)( B_OPTS_PAGE_CREATE_PARMS ), void (*sfunc)( B_OPTS_PAGE_SAVE_PARMS ), int px, int py, int pw, int ph )
{
	char name[128];
	char *lt = lang_phrase_quick( langtext );
	CWidget *cat;
	ClaroTableRow *row;
	
	boptnums++;
	boptlinks = (BOptionsPageLink *)realloc( boptlinks, sizeof( BOptionsPageLink ) * boptnums );
	
	sprintf( name, "%s%s", (sub==0?"":"  "), lt );
	
	row = c_tbl_insert_row( opt_cats_tbl, opt_cats_tbl->rows );
	c_tbl_set_cell_data( opt_cats_tbl, row->pos, 0, (void *)strdup( name ), 1 );
	c_tbl_set_cell_data( opt_cats_tbl, row->pos, 1, (void *)(boptnums-1), 0 );
	
	cat = (*func)( lt, optionswin, px, py, pw, ph, xidentity );
	
	boptlinks[boptnums-1].page = cat;
	boptlinks[boptnums-1].save_func = sfunc;
	
	if ( cat != 0 )
		c_widget_hide( cat );
}

B_OPTIONS_PAGE_SAVE( b_options_null_save ) { }
B_OPTIONS_PAGE_CREATE( b_options_null_page )
{
	CWidget *cat;
	
	cat = c_new_groupbox( parent, title, px, py, pw, ph, 0 );
	
	c_new_label( cat, lang_phrase_quick( "opt_reserved_1" ), 10, 20, pw-20, -1, 0 );
	c_new_label( cat, lang_phrase_quick( "opt_reserved_2" ), 10, 38, pw-20, -1, 0 );
	
	return cat;
}

B_OPTIONS_PAGE_CREATE( b_options_general_page );
B_OPTIONS_PAGE_SAVE( b_options_general_save );
B_OPTIONS_PAGE_CREATE( b_options_time_page );
B_OPTIONS_PAGE_SAVE( b_options_time_save );
B_OPTIONS_PAGE_CREATE( b_options_misc_page );
B_OPTIONS_PAGE_SAVE( b_options_misc_save );
B_OPTIONS_PAGE_CREATE( b_options_font_page );
B_OPTIONS_PAGE_SAVE( b_options_font_save );

void b_options_load_pages( CWidget *parent, int px, int py, int pw, int ph )
{
	b_options_begin_page( 0, "opt_cat_general_settings", &b_options_general_page, &b_options_general_save, px, py, pw, ph );
	{
		/*
		b_options_begin_page( 1, "opt_cat_connections", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
		
		b_options_begin_page( 1, "opt_cat_irc_servers", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
		
		b_options_begin_page( 1, "opt_cat_firewall_ip", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
		*/
	}
	
	b_options_begin_page( 0, "opt_cat_misc", &b_options_misc_page, &b_options_misc_save, px, py, pw, ph );
	{
		b_options_begin_page( 1, "opt_cat_time", &b_options_time_page, &b_options_time_save, px, py, pw, ph );
	}
	
	
	b_options_begin_page( 0, "opt_cat_visual", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
	{
		/*b_options_begin_page( 1, "opt_cat_assorted", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
		
		b_options_begin_page( 1, "opt_cat_taskbar", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
		
		b_options_begin_page( 1, "opt_cat_nicklist", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
		*/
		b_options_begin_page( 1, "opt_cat_fonts", &b_options_font_page, &b_options_font_save, px, py, pw, ph );
		/*
		b_options_begin_page( 1, "opt_cat_colour", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
		
		b_options_begin_page( 1, "opt_cat_text", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
		
		b_options_begin_page( 1, "opt_cat_highlight", &b_options_null_page, &b_options_null_save, px, py, pw, ph );
		*/
	}
	
	c_listbox_set_select( opt_categories, 0 );
	c_widget_focus( opt_categories );
}

CWidget *opt_save, *opt_cancel;

void b_open_options( )
{
	int w, h;
	
	w = 640;
	h = 460;
	
	if ( optionswin == 0 )
	{
		optionswin = c_new_window( mainwin, lang_phrase_quick( "options" ), w, h, C_DIALOG | C_WINDOW_CENTER_TO_PARENT );
		c_window_set_icon( optionswin, b_icon( "options" ) );
		c_window_maxsize( optionswin, w, h );
		c_window_minsize( optionswin, w, h );
		c_new_event_handler( optionswin, C_EVENT_DESTROY, b_options_killed );
		
		opt_categories = c_new_listbox( optionswin, 10, 10, 150, h-20-30, 0 );
		c_new_event_handler( opt_categories, C_EVENT_ITEM_SELECTED, b_opt_cat_selected );
		
		opt_cats_tbl = c_tbl_create( 2 );
		c_listbox_attach_table( opt_categories, opt_cats_tbl, 0 );
		
		opt_save = c_new_pushbutton( optionswin, lang_phrase_quick( "save" ), w-150-10-150-10, h-30, 150, -1, 0 );
		opt_cancel = c_new_pushbutton( optionswin, lang_phrase_quick( "cancel" ), w-150-10, h-30, 150, -1, 0 );
		
		b_options_load_pages( optionswin, 170, 2, w-180, h-12-30 );
		
		c_new_event_handler( opt_save, C_EVENT_BUTTON_PRESS, b_options_save );
		c_new_event_handler( opt_cancel, C_EVENT_BUTTON_PRESS, b_options_cancel );
		c_new_event_handler( optionswin, C_EVENT_DIALOG_OK, b_options_save );
	}
	else
	{
		c_widget_focus( optionswin );
	}
}
