/*************************************************************************
$Id: font.c 119 2005-11-02 22:02:49Z terminal $

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

#include "../include/includes.h"

int c_make_color_hex( char *hex )
{
	int r, g, b, a;
	
	r = g = b = a = 0;
	
	sscanf( hex, "#%2x%2x%2x", &r, &g, &b );
	
	return (r<<24) + (g<<16) + (b<<8) + (a);
}

int c_font_get_height( CWidget *w )
{
#ifdef ENV_WIN32
	TEXTMETRIC tm;
	HDC wdc, dc;
	
	wdc = dc = w->info->wdc;
		
	if ( wdc == 0 )
		dc = GetDC( (HWND)w->info->widget );
	
	GetTextMetrics( dc, &tm );
	
	if ( wdc == 0 )
		ReleaseDC( (HWND)w->info->widget, dc ); 
	
	return tm.tmHeight;
#endif

#ifdef ENV_CARBON
	// FIXME: This is NOT right!
	return ((CFont *)w->font)->size;
#endif
	
#ifdef ENV_GTK
	int h;
	PangoContext *pc = gtk_widget_create_pango_context(w->info->widget);
	PangoFontDescription *fd = pango_context_get_font_description(pc);
	PangoFontMetrics *fm = pango_context_get_metrics(pc,fd,pango_context_get_language(pc));
	h = PANGO_PIXELS( pango_font_metrics_get_ascent(fm) + pango_font_metrics_get_descent(fm) );
	
	pango_font_metrics_unref(fm);
	return h;
#endif
}

#ifdef ENV_CARBON
extern CGContextRef theCGContext;
#endif

int c_font_get_string_width( CWidget *w, char *text, int chars )
{
#ifdef ENV_WIN32
	SIZE s;
	HDC wdc, dc;
	
	wdc = dc = w->info->wdc;
		
	if ( wdc == 0 )
		dc = GetDC( (HWND)w->info->widget );
	
	SelectObject( dc, ((CFont *)w->font)->wfont );
	GetTextExtentPoint32( dc, text, chars, &s );
	
	if ( wdc == 0 )
		ReleaseDC( (HWND)w->info->widget, dc ); 
	
	return s.cx;
#endif

#ifdef ENV_CARBON
	CGrafPtr prt;
	CGContextRef ctx;
	CGPoint end;
	int a;
	
	GetPort( &prt );
	
	if ( theCGContext != 0 )
		ctx = theCGContext;
	else if ( QDBeginCGContext( prt, &ctx ) != noErr )
		printf( "ARGH! Couldn't get CGContext from CGrafPrt\n" );
	
	CGContextSetTextDrawingMode( ctx, kCGTextInvisible );
	CGContextSelectFont( ctx, ((CFont *)w->font)->face, ((CFont *)w->font)->size, kCGEncodingMacRoman );
	CGContextShowTextAtPoint( ctx, 0, 0, text, chars );
	
	end = CGContextGetTextPosition( ctx );
	
	QDEndCGContext( prt, &ctx );
	
	return end.x;
	
	/*
	Rect rect;
	
	ATSUSetTextPointerLocation( ((CFont *)w->font)->c_text_layout, text, kATSUFromTextBeginning, chars, chars );
	ATSUSetRunStyle( ((CFont *)w->font)->c_text_layout, ((CFont *)w->font)->c_text_style, kATSUFromTextBeginning, chars );
	ATSUMeasureTextImage( ((CFont *)w->font)->c_text_layout, kATSUFromTextBeginning, chars, 0, 0, &rect );
	
	return rect.right;
	*/
#endif

#ifdef ENV_GTK
	int width;
	PangoLayout *pl = gtk_widget_create_pango_layout(w->info->widget,text);
	pango_layout_get_pixel_size(pl, &width, NULL);
	
	g_object_unref(pl);
	return width; 
#endif
}

// w32_font = CreateFont( 16, 0, 0, 0, FW_NORMAL, false, false, false, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS|OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS, 0, DEFAULT_PITCH | FF_DONTCARE, NULL );

void c_font_native_destroy( CFont *font )
{
#ifdef ENV_WIN32
	DeleteObject( font->wfont );
#endif

#ifdef ENV_CARBON
	free( font->cfont );
#endif

#ifdef ENV_GTK
	pango_font_description_free(font->font);
#endif
}

void c_font_native_create( CFont *font )
{
#ifdef ENV_WIN32
	font->wfont = CreateFont( font->size, 0, 0, 0, (font->bold?FW_BOLD:FW_NORMAL), font->italic, font->underline, font->strikeout, 
	                  DEFAULT_CHARSET, OUT_DEFAULT_PRECIS|OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS, 0, DEFAULT_PITCH | FF_DONTCARE, font->face );
#endif

#ifdef ENV_CARBON
	ATSUAttributeTag aTags[] = { kATSUQDBoldfaceTag, kATSUQDItalicTag, kATSUQDUnderlineTag, kATSUFontTag, kATSUSizeTag };
	ByteCount aSizes[] = { sizeof(Boolean), sizeof(Boolean), sizeof(Boolean), sizeof(ATSUFontID), sizeof(ATSUFontID), sizeof(Fixed) };
	ATSUAttributeValuePtr aValuePtrs[] = { &font->bold, &font->italic, &font->underline, &font->c_font_id, &font->c_font_converted_size };
	
	font->cfont = (ControlFontStylePtr)malloc( sizeof( ControlFontStyleRec ) );
	font->cfont->flags = kControlUseSizeMask | kControlUseFaceMask;
	font->cfont->font = kControlFontBigSystemFont; // FIXME: use font specified instead!!
	font->cfont->size = font->size; // FIXME: Blah.. this isn't right :(
	font->cfont->style = (font->bold?1:0) | (font->italic?2:0) | (font->underline?4:0);
//	font->cfont->just = tuFlushDefault;
	
	ATSUCreateTextLayout( &font->c_text_layout );
	ATSUCreateStyle( &font->c_text_style );
	ATSUSetAttributes( font->c_text_style, 5, &aTags, &aSizes, &aValuePtrs );
#endif
	
#ifdef ENV_GTK
	char *a;
	      
	asprintf(&a,"%s %s %s%s%s%d",font->face, (font->bold>0 ? "bold" : "normal"),
	                                              (font->italic>0 ? "italic " : ""),
	                                              (font->underline>0 ? "underline " : ""),
	                                              (font->strikeout>0 ? "strikeout " : ""),
	                                   (int) (font->size * 0.65) ); // FIXME: This is a guess to make it look OK.

	font->font = pango_font_description_from_string(a);
	
	free(a);
#endif
}

void c_font_bind_native( CFont *font, CWidget *widget )
{
	if ( widget->info->widget != 0 )
	{
#ifdef ENV_WIN32
		SendMessage( (HWND)widget->info->widget, WM_SETFONT, (WPARAM)font->wfont, true );
#endif
#ifdef ENV_CARBON
		SetControlFontStyle( (ControlRef)widget->info->widget, font->cfont );
#endif
#ifdef ENV_GTK
		gtk_widget_modify_font(widget->info->widget, font->font);
#endif 
	}
}

void c_font_bind_all( CFont *font )
{
	CFontClient *curr;
	
	for ( curr = font->fc_head; curr != NULL; curr = curr->next )
		c_font_bind_native( font, curr->w );
}

CFont *c_font_create( char *face, int size )
{
	CFont *font;
	
	if ( !( font = (CFont *)malloc( sizeof(CFont) ) ) )
		return NULL;
	
	memset( font, 0, sizeof(CFont) );
	strncpy( font->face, face, 255 );
	
	font->size = size;
	font->fc_head = 0;
	
#ifdef ENV_CARBON
	font->size = (int) ( ((float)font->size / 96.0f) * 72.0f );
	
	font->c_font_converted_size = font->size;
	font->c_font_str = CFStringCreateWithCString( NULL, font->face, strlen( font->face ) );
	font->c_font_id = ATSFontFindFromName( font->c_font_str, kATSOptionFlagsDefault );
#endif
	
	c_font_native_create( font );
	
	c_font_bind_all( font );
	
	return font;
}

CFont *c_font_clone( CFont *fontsrc )
{
	CFont *font;
	
	if ( !( font = (CFont *)malloc( sizeof(CFont) ) ) )
		return NULL;
	
	// copy entire old fone
	memcpy( font, fontsrc, sizeof( CFont ) );
	
	font->fc_head = 0;
	
	// recreate the native font
	c_font_native_create( font );
	
	return font;
}

void c_font_destroy( CFont *font )
{
	CFontClient *curr, *next;
	
	c_font_native_destroy( font );
	
	for ( curr = font->fc_head; curr != NULL; curr = next )
	{
		next = curr->next;
		free( curr );
	}
	
	free( font );
}

// destroys and re-creates the native font
void c_font_regenerate( CFont *font )
{
	c_font_native_destroy( font );
	c_font_native_create( font );
}

// syncs all style (b,u,i) changes to the native font.
void c_font_sync( CFont *font )
{
	c_font_regenerate( font );
}

void c_font_widget_gone( CFont *font, CWidget *widget )
{
	CFontClient *curr, *next;
	
	for ( curr = font->fc_head; curr != NULL; curr = next )
	{
		next = curr->next;
		if ( curr->w == widget )
		{
			if ( curr->prev == 0 )
				font->fc_head = curr->next;
			
			if ( curr->next != 0 )
				curr->next->prev = curr->prev;
			if ( curr->prev != 0 )
				curr->prev->next = curr->next;
			
			free( curr );
		}
	}
}

void c_font_bind_widget( CFont *font, CWidget *widget )
{
	CFontClient *fc;
	
	widget->font = font;
	
	
	if ( !( fc = (CFontClient *)malloc( sizeof(CFontClient) ) ) )
		return;
	
	fc->w = widget;
	fc->next = font->fc_head;
	if ( fc->next != 0 )
		fc->next->prev = fc;
	fc->prev = 0;
	font->fc_head = fc;
	
	if ( widget->parent != 0 ) // hack: application (only non-parent widget) doesn't have a native widget
		c_font_bind_native( font, widget );
}

void c_font_fix( CWidget *widget )
{
	c_font_bind_widget( (CFont *)widget->font, widget );
}

void c_font_set_bold( CFont *font, short enabled )
{
	font->bold = enabled;
	
	c_font_sync( font );
}

void c_font_set_italic( CFont *font, short enabled )
{
	font->italic = enabled;
	
	c_font_sync( font );
}

void c_font_set_underline( CFont *font, short enabled )
{
	font->underline = enabled;
	
	c_font_sync( font );
}

void c_font_set_strikeout( CFont *font, short enabled )
{
	font->strikeout = enabled;
	
	c_font_sync( font );
}

short c_font_is_bold( CFont *font ) { return font->bold; }
short c_font_is_italic( CFont *font ) { return font->italic; }
short c_font_is_underline( CFont *font ) { return font->underline; }
short c_font_is_strikeout( CFont *font ) { return font->strikeout; }

//
