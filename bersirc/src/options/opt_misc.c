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

#include "../includes.h"

CWidget *opt_misc_quit_message = 0;
CWidget *opt_misc_quit_in_query = 0;
CWidget *opt_misc_nick_in_query = 0;
CWidget *opt_misc_nick_update_query = 0;
CWidget *opt_misc_hide_version = 0;

B_OPTIONS_PAGE_CREATE( b_options_misc_page )
{
	CWidget *cat;
	int y = 20;
	//int sx = 150;
	
	cat = c_new_groupbox( parent, title, px, py, pw, ph, 0 );
	
	c_new_label( cat, lang_phrase_quick( "opt_misc_quit_message" ), 10, y, pw-20, -1, 0 );
	y += 20;
	opt_misc_quit_message = c_new_text( cat, b_get_option_string( identity, "general", "opt_misc_quit_message" ), 30, y, pw-20-20, -1, 0 );
	y += 30;
	
	opt_misc_quit_in_query = c_new_checkbox( cat, lang_phrase_quick( "opt_misc_quit_in_query" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_misc_quit_in_query, b_get_option_bool( identity, "general", "opt_misc_quit_in_query" ) );
	y += 20;
	
	opt_misc_nick_in_query = c_new_checkbox( cat, lang_phrase_quick( "opt_misc_nick_in_query" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_misc_nick_in_query, b_get_option_bool( identity, "general", "opt_misc_nick_in_query" ) );
	y += 20;
	
	opt_misc_nick_update_query = c_new_checkbox( cat, lang_phrase_quick( "opt_misc_nick_update_query" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_misc_nick_update_query, b_get_option_bool( identity, "general", "opt_misc_nick_update_query" ) );
	y += 20;

	opt_misc_hide_version = c_new_checkbox( cat, lang_phrase_quick( "opt_misc_hide_version" ), 10, y, pw-20, -1, 0 );
	c_checkbox_checked( opt_misc_hide_version, b_get_option_bool( identity, "general", "opt_misc_hide_version" ) );
	y += 20;
	
	return cat;
}

B_OPTIONS_PAGE_SAVE( b_options_misc_save )
{
	b_set_option_string( identity, "general", "opt_misc_quit_message", ((CTextBoxWidgetInfo *)opt_misc_quit_message->info)->text );
	b_set_option_bool( identity, "general", "opt_misc_quit_in_query", ((CCheckBoxWidgetInfo *)opt_misc_quit_in_query->info)->checked );
	b_set_option_bool( identity, "general", "opt_misc_nick_in_query", ((CCheckBoxWidgetInfo *)opt_misc_nick_in_query->info)->checked );
	b_set_option_bool( identity, "general", "opt_misc_nick_update_query", ((CCheckBoxWidgetInfo *)opt_misc_nick_update_query->info)->checked );
	b_set_option_bool( identity, "general", "opt_misc_hide_version", ((CCheckBoxWidgetInfo *)opt_misc_hide_version->info)->checked );
}

//
