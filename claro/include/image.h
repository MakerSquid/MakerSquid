/*************************************************************************
$Id: image.h 114 2005-08-30 06:32:39Z terminal $

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

// GetModuleHandle( NULL )

#ifdef ENV_GTK

#define c_gdk_render_pixbuf_to_pixmap_fc(src,dst,gc,srcx,srcy,dstx,dsty,width,height) \
		c_gdk_render_pixbuf_to_pixmap_fc_r(src,dst,gc,srcx,srcy,dstx,dsty,width,height,__FILE__,__LINE__,__FUNCTION__)

void c_gdk_render_pixbuf_to_pixmap_fc_r(
	GdkPixbuf *src, GdkPixmap *dst, GdkGC *gc, 
	int srcx, int srcy, int dstx, int dsty,
	int width, int height,
	char *d_file, int d_line, char *d_func );
#endif

typedef struct
{
	int width;
	int height;

#ifdef ENV_WIN32
	HDC dc;
	HBITMAP bmp;
	HBITMAP oldbmp;
#endif
#ifdef ENV_GTK
	GtkWidget *xpm;
	GdkPixbuf *pb;
	guchar *pixels;
	int rowstride;
	int channels;
	//GdkPixmap *pm;
#endif 
#ifdef ENV_CARBON
	unsigned char *pixels;
	// is used to make a:
	CGDataProviderRef dp;
	// which is then used to make a:
	CGImageRef imref;
	/*
	CGContextRef ctx;
	CGImageRef imref;
	CGDataProviderRef dp;
	CGContextRef *contextPtr;
	*/
#endif
} CBitmap;

typedef struct
{
	CBitmap *bitmap;
	
#ifdef ENV_WIN32
	HICON icon;
	ICONINFO info;
#endif
} ClaroIcon;

ClaroIcon *c_icon_from_xpm( char *path );

//
