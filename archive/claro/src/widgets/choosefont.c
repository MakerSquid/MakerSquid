/*************************************************************************
$Id: choosefont.c 106 2005-08-10 00:17:32Z terminal $

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
  LONG lfHeight; 
  LONG lfWidth; 
  LONG lfEscapement; 
  LONG lfOrientation; 
  LONG lfWeight; 
  BYTE lfItalic; 
  BYTE lfUnderline; 
  BYTE lfStrikeOut; 
  BYTE lfCharSet; 
  BYTE lfOutPrecision; 
  BYTE lfClipPrecision; 
  BYTE lfQuality; 
  BYTE lfPitchAndFamily; 
  TCHAR lfFaceName[LF_FACESIZE]; 
*/

void c_choosefont_set_font_face( CWidget *w, char *face )
{
	CChooseFontWidgetInfo *cfwi = (CChooseFontWidgetInfo *)w->info;
	
#ifdef ENV_WIN32
	strncpy( cfwi->wlf.lfFaceName, face, 32 );
	cfwi->wlf.lfFaceName[31] = 0;
#endif
}

void c_choosefont_set_font_size( CWidget *w, int size )
{
	CChooseFontWidgetInfo *cfwi = (CChooseFontWidgetInfo *)w->info;
	
#ifdef ENV_WIN32
	int a;
	double b;
	HDC dc;
	
	dc = GetDC( 0 );
	a = GetDeviceCaps( dc, LOGPIXELSY );
	ReleaseDC( 0, dc );
	
	b = -size;
	b *= (double)a;
	b /= 72.0f;
	
	cfwi->wlf.lfHeight = b;
#endif
}

char *c_choosefont_get_font_face( CWidget *w )
{
	CChooseFontWidgetInfo *cfwi = (CChooseFontWidgetInfo *)w->info;
	
#ifdef ENV_WIN32
	return cfwi->wlf.lfFaceName;
#endif
	
	return "";
}

int c_choosefont_get_font_size( CWidget *w )
{
	CChooseFontWidgetInfo *cfwi = (CChooseFontWidgetInfo *)w->info;

#ifdef ENV_WIN32
	int a;
	double b;
	double c;
	HDC dc;
	
	dc = GetDC( 0 );
	a = GetDeviceCaps( dc, LOGPIXELSY );
	ReleaseDC( 0, dc );
	
	b = cfwi->wlf.lfHeight;
	b *= 72;
	b /= (double)a;
	
	b = -b;
	
	c = floor( b + 0.5 );
	
	return c;
#endif
	
	return 0;
}

int c_choosefont_display( CWidget *w )
{
	CChooseFontWidgetInfo *cfwi = (CChooseFontWidgetInfo *)w->info;
	int a = 0;
	
#ifdef ENV_WIN32
	a = ChooseFont( &cfwi->wcfd );
#endif
	
	return a;
}

void c_choosefont_handle_create( CEvent *e, void *data )
{
	CChooseFontWidgetInfo *cfwi = (CChooseFontWidgetInfo *)e->caller->info;
	
#ifdef ENV_WIN32
	cfwi->wcfd.hwndOwner = e->caller->parent->info->widget;
#endif
	
	printf("c_choosefont_handle_create( )\n");
}

void c_choosefont_handle_destroy( CEvent *e, void *data )
{
	//CChooseFontWidgetInfo *cfwi = (CChooseFontWidgetInfo *)e->caller->info;
}

CWidget *c_new_choosefont( CWidget *parent )
{
	CWidget *w;
	CChooseFontWidgetInfo *cfwi;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CChooseFontWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_CHOOSEFONT;
	w->info->x = 0;
	w->info->y = 0;
	w->info->width = 0;
	w->info->height = 0;
	w->info->flags = 0;
	w->info->visible = 1;
	
	cfwi = (CChooseFontWidgetInfo *)w->info;
	
#ifdef ENV_WIN32
	cfwi->wcfd.lStructSize = sizeof( CHOOSEFONT );
	cfwi->wcfd.lpLogFont = &cfwi->wlf;
	cfwi->wcfd.Flags = CF_INITTOLOGFONTSTRUCT | CF_SCREENFONTS;
	
	memset( &cfwi->wlf, 0, sizeof( LOGFONT ) );
#endif

	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_choosefont_handle_create );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
