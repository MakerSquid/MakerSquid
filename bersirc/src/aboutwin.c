/*************************************************************************
$Id: aboutwin.c 167 2005-08-20 00:04:08Z terminal $

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

CWidget *aboutwin = 0, *btnclose;

extern CWidget *mainwin;

void b_aboutwin_killed( )
{
	aboutwin = 0;
}

void b_aboutwin_close( CEvent *e, void *data )
{
	c_widget_close( aboutwin );
}

void b_open_aboutwin( )
{
	CWidget *txt;
	
	if ( aboutwin == 0 )
	{
		aboutwin = c_new_window( mainwin, lang_phrase_quick( "about_bers" ), 350, 265, C_DIALOG | C_WINDOW_CENTER_TO_PARENT );
		c_window_maxsize( aboutwin, 350, 265 );
		c_window_minsize( aboutwin, 350, 265 );
		c_window_set_icon( aboutwin, b_icon( "bersirc" ) );
		c_new_event_handler( aboutwin, C_EVENT_DESTROY, b_aboutwin_killed );
		c_new_event_handler( aboutwin, C_EVENT_DIALOG_OK, b_aboutwin_close );
		
		c_new_image( aboutwin, "themes/bers_about.bmp", 68, 0, 214, 200, 0 );
		
		txt = c_new_label( aboutwin, "SQL Helper v" BERSIRC_VERSION, 90, 210, -1, -1, 0 );

		btnclose = c_new_pushbutton( aboutwin, lang_phrase_quick( "close" ), 100, 235, 150, -1, 0 );
		c_new_event_handler( btnclose, C_EVENT_BUTTON_PRESS, b_aboutwin_close );
	}
	else
	{
		c_widget_focus( aboutwin );
	}
}
