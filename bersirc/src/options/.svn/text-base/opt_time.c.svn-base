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

CWidget *opt_time_line_timestamp = 0;
CWidget *opt_time_long_timestamp = 0;

B_OPTIONS_PAGE_CREATE( b_options_time_page )
{
	CWidget *cat;
	int y = 20;
	int sx = 180;
	
	cat = c_new_groupbox( parent, title, px, py, pw, ph, 0 );
	
	c_new_label( cat, lang_phrase_quick( "opt_time_line_timestamp" ), 10, y, sx, -1, 0 );
	opt_time_line_timestamp = c_new_text( cat, b_get_option_string( identity, "time", "opt_time_line_timestamp" ), sx+10, y, pw-20-sx, -1, 0 );
	y += 30;
	
	c_new_label( cat, lang_phrase_quick( "opt_time_long_timestamp" ), 10, y, sx, -1, 0 );
	opt_time_long_timestamp = c_new_text( cat, b_get_option_string( identity, "time", "opt_time_long_timestamp" ), sx+10, y, pw-20-sx, -1, 0 );
	y += 30;
	
	return cat;
}

B_OPTIONS_PAGE_SAVE( b_options_time_save )
{
	b_set_option_string( identity, "time", "opt_time_line_timestamp", ((CTextBoxWidgetInfo *)opt_time_line_timestamp->info)->text );
	b_set_option_string( identity, "time", "opt_time_long_timestamp", ((CTextBoxWidgetInfo *)opt_time_long_timestamp->info)->text );
}

//
