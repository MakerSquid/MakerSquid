/*************************************************************************
$Id: opt_general.c 173 2005-09-19 01:45:00Z terminal $

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

#include "../includes.h"

CWidget *opt_gen_open_new_query = 0;
CWidget *opt_gen_rejoin_on_kick = 0;
CWidget *opt_gen_show_ping_pong = 0;
CWidget *opt_gen_flash_on_message = 0;
CWidget *opt_gen_language = 0;
char    *opt_gen_lang_real = "en_uk";
CWidget *opt_gen_show_in_systray = 0;
CWidget *opt_gen_min_to_systray = 0;

XMLFile *xml_lang=0;

void b_options_general_load_languages( char *sel )
{
	XMLItem *langs;
	XMLItem *lang;
	char *langname, *langcode;
	int a;
	
	if ( xml_lang == 0 )
	{
		xml_lang = c_xml_create( );
		
		if ( !( c_xml_load_file( xml_lang, "xml/lang.xml" ) ) )
			return;
	}
	
	langs = c_xml_get_path( xml_lang, "Bersirc.languages" );
	
	if ( langs == 0 )
		return;
	
	for ( lang = langs->child_head; lang != 0; lang = lang->next )
	{
		langname = c_xml_attrib_get( lang, "title" );
		langcode = c_xml_attrib_get( lang, "code" );
		
		if ( langcode == 0 || langname == 0 )
			continue;
		
		a = c_dropdown_additem( opt_gen_language, langname );
		
		if ( !strcasecmp( langcode, sel ) )
			c_dropdown_select_item( opt_gen_language, a );
	}
}

void b_gen_language_selected( CEvent *e, void *data )
{
	XMLItem *langs;
	XMLItem *lang;
	char *langname, *langcode;
	char *itemtxt = 0;
	int a;
	
	CDropDownItem *item;
	
	a = c_dropdown_selected( e->caller );
	
	for ( item = ((CDropDownWidgetInfo *)e->caller->info)->items; item != 0; item = item->next )
	{
		if ( item->id == a )
			itemtxt = item->text;
	}
	
	if ( itemtxt == 0 )
		return;
	
	langs = c_xml_get_path( xml_lang, "Bersirc.languages" );
	
	if ( langs == 0 )
		return;
	
	for ( lang = langs->child_head; lang != 0; lang = lang->next )
	{
		langname = c_xml_attrib_get( lang, "title" );
		langcode = c_xml_attrib_get( lang, "code" );
		
		if ( langcode == 0 || langname == 0 )
			continue;
		
		if ( !strcasecmp( langname, itemtxt ) )
		{
			opt_gen_lang_real = langcode;
		}
	}
}

B_OPTIONS_PAGE_CREATE( b_options_general_page )
{
	CWidget *cat;
	int y = 20;
	//int sx = 200;
	
	cat = c_new_groupbox( parent, title, px, py, pw, ph, 0 );
	
	// language
	
	int lang_w = 200;
	int text_w;
	
	char *l_title = lang_phrase_quick( "opt_gen_language" );
	
	text_w = c_font_get_string_width( parent, l_title, strlen( l_title ) );
	text_w += 20;
	
	c_new_label( cat, l_title, 10, y, text_w, -1, 0 );
	//opt_gen_language = c_new_text( cat, b_get_option_string( identity, "general", "opt_gen_language" ), text_w, y, lang_w, -1, 0 );
	opt_gen_language = c_new_dropdown( cat, text_w, y, lang_w, 200, 0 );
	opt_gen_lang_real = b_get_option_string( identity, "general", "opt_gen_language" );
	b_options_general_load_languages( opt_gen_lang_real );
	c_new_event_handler( opt_gen_language, C_EVENT_ITEM_SELECTED, b_gen_language_selected );
	y += 30;
	
	// visual
	
	opt_gen_open_new_query = c_new_checkbox( cat, lang_phrase_quick( "opt_gen_open_new_query" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_gen_open_new_query, b_get_option_bool( identity, "general", "opt_gen_open_new_query" ) );
	y += 20; // FIXME: This should be found some other way!

	opt_gen_rejoin_on_kick = c_new_checkbox( cat, lang_phrase_quick( "opt_gen_rejoin_on_kick" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_gen_rejoin_on_kick, b_get_option_bool( identity, "general", "opt_gen_rejoin_on_kick" ) );
	y += 20;
	
	opt_gen_show_ping_pong = c_new_checkbox( cat, lang_phrase_quick( "opt_gen_show_ping_pong" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_gen_show_ping_pong, b_get_option_bool( identity, "general", "opt_gen_show_ping_pong" ) );
	y += 20;
	
	opt_gen_flash_on_message = c_new_checkbox( cat, lang_phrase_quick( "opt_gen_flash_on_message" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_gen_flash_on_message, b_get_option_bool( identity, "general", "opt_gen_flash_on_message" ) );
	y += 20;
	
	// systray
	
	opt_gen_show_in_systray = c_new_checkbox( cat, lang_phrase_quick( "opt_gen_show_in_systray" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_gen_show_in_systray, b_get_option_bool( identity, "general", "opt_gen_show_in_systray" ) );
	y += 20;
	
	opt_gen_min_to_systray = c_new_checkbox( cat, lang_phrase_quick( "opt_gen_min_to_systray" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_gen_min_to_systray, b_get_option_bool( identity, "general", "opt_gen_min_to_systray" ) );
	y += 20;
	
	return cat;
}

void b_insert_systray( );
void b_remove_systray( );

B_OPTIONS_PAGE_SAVE( b_options_general_save )
{
	b_set_option_bool( identity, "general", "opt_gen_open_new_query", ((CCheckBoxWidgetInfo *)opt_gen_open_new_query->info)->checked );
	b_set_option_bool( identity, "general", "opt_gen_show_ping_pong", ((CCheckBoxWidgetInfo *)opt_gen_show_ping_pong->info)->checked );
	b_set_option_bool( identity, "general", "opt_gen_flash_on_message", ((CCheckBoxWidgetInfo *)opt_gen_flash_on_message->info)->checked );
	b_set_option_bool( identity, "general", "opt_gen_rejoin_on_kick", ((CCheckBoxWidgetInfo *)opt_gen_rejoin_on_kick->info)->checked );
	b_set_option_string( identity, "general", "opt_gen_language", opt_gen_lang_real );
	
	// systray
	
	b_set_option_bool( identity, "general", "opt_gen_show_in_systray", ((CCheckBoxWidgetInfo *)opt_gen_show_in_systray->info)->checked );
	if ( ((CCheckBoxWidgetInfo *)opt_gen_show_in_systray->info)->checked )
		b_insert_systray( ); // make sure it's shown
	else
		b_remove_systray( );
	b_set_option_bool( identity, "general", "opt_gen_min_to_systray", ((CCheckBoxWidgetInfo *)opt_gen_min_to_systray->info)->checked );
}

//
