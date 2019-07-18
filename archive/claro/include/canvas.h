/*************************************************************************
$Id: canvas.h 44 2005-04-30 04:25:57Z terminal $

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

#ifndef _CANVAS_H
#define _CANVAS_H

// default in canvas.c, native in application.c
extern unsigned int c_native_background;
#define C_NATIVE_BACKGROUND c_native_background

#define C_CANVAS_TEXT_CLIP 0x1

void c_canvas_paint_clear( CWidget *w, int colour );
void c_canvas_paint_text_full( CWidget *w, int x, int y, int width, int height, int colour, char *text, int flags );
void c_canvas_paint_text( CWidget *w, int x, int y, int colour, char *text );
void c_canvas_paint_line( CWidget *w, int colour, int x1, int y1, int x2, int y2 );
void c_canvas_paint_fillrect( CWidget *w, int colour, int x, int y, int width, int height );
void c_canvas_paint_icon( CWidget *w, ClaroIcon *icon, int x, int y );

#endif
