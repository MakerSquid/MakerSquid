/*************************************************************************
$Id: font.h 66 2005-05-15 12:04:48Z terminal $

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

typedef struct __cfc1
{
	CWidget *w;
	
	struct __cfc1 *next;
	struct __cfc1 *prev;
} CFontClient;

typedef struct
{
	char face[256];
	
	short bold;
	short italic;
	short underline;
	short strikeout;
	
	int size;
	
#ifdef ENV_WIN32
	HFONT wfont;
#endif

#ifdef ENV_CARBON
	ControlFontStylePtr cfont;
	ATSUTextLayout c_text_layout;
	ATSUStyle c_text_style;
	int c_font_converted_size;
	ATSUFontID c_font_id;
	CFStringRef c_font_str;
#endif
	
#ifdef ENV_GTK
	PangoFontDescription *font; 
#endif
	
	CFontClient *fc_head;
} CFont;

int c_make_color_hex( char *hex );

int c_font_get_height( CWidget *w );
int c_font_get_string_width( CWidget *w, char *text, int chars );

void c_font_widget_gone( CFont *font, CWidget *widget );

void c_font_fix( CWidget *widget );
void c_font_bind_widget( CFont *font, CWidget *widget );
CFont *c_font_create( char *face, int size );
CFont *c_font_clone( CFont *fontsrc );

void c_font_set_bold( CFont *font, short enabled );
void c_font_set_italic( CFont *font, short enabled );
void c_font_set_underline( CFont *font, short enabled );
void c_font_set_strikeout( CFont *font, short enabled );

short c_font_is_bold( CFont *font );
short c_font_is_italic( CFont *font );
short c_font_is_underline( CFont *font );
short c_font_is_strikeout( CFont *font );

//
