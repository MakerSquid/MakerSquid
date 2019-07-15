/*************************************************************************
$Id: images.c 114 2005-08-30 06:32:39Z terminal $

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

#ifdef ENV_CARBON
static void c_c_cdata_release(void *info, const void *data, size_t size) {}
#endif

CBitmap *c_image_bitmap_create( int width, int height )
{
	CBitmap *b;
#ifdef ENV_WIN32
	HDC sdc;
#endif
	
	// get some memory allocated
	b = (CBitmap *)malloc( sizeof( CBitmap ) );
	memset( b, 0, sizeof( CBitmap ) );
	
#ifdef ENV_WIN32
	// get screen DC
	sdc = GetDC( NULL );
	
	// create a device context compatible with the screen
	b->dc = CreateCompatibleDC( sdc );
	
	// create a bitmap compatible with the screen
	// (not the above DC, because it's 1-bit by default)
	b->bmp = CreateCompatibleBitmap( sdc, width, height );

	// release the DC
	ReleaseDC( NULL, sdc );
#endif

	// set the size
	b->width = width;
	b->height = height;

#ifdef ENV_GTK
	b->pb = gdk_pixbuf_new( GDK_COLORSPACE_RGB, TRUE, 8, width, height );
	b->pixels = gdk_pixbuf_get_pixels( b->pb );
	b->rowstride = gdk_pixbuf_get_rowstride( b->pb );
	b->channels = gdk_pixbuf_get_n_channels( b->pb );
#endif

#ifdef ENV_CARBON
	int bpr = 4 * width;
	int sz = 4 * width * height;
	
	b->pixels = (char *)malloc( sz );
	memset( b->pixels, 0, sz );
	
	b->dp = 0;
	b->imref = 0;
	//b->dp = CGDataProviderCreateWithData( 0, blankim, sz, c_c_cdata_release );
	//b->imref = CGImageCreate( width, height, 8, 32, bpr, CGColorSpaceCreateDeviceRGB( ), kCGImageAlphaLast, b->dp, 0, 0, kCGRenderingIntentDefault );
	//b->ctx = CGBitmapContextCreate( blankim, width, height, 8, bpr, CGColorSpaceCreateDeviceRGB( ), kCGImageAlphaPremultipliedLast );
#endif

	return b;
}

void c_image_bitmap_select( CBitmap *b )
{
#ifdef ENV_WIN32
	b->oldbmp = SelectObject( b->dc, b->bmp );
#endif
#ifdef ENV_CARBON
	// clear data provider
	if ( b->dp != 0 )
		CGDataProviderRelease( b->dp );
	
	// clear image
	if ( b->imref != 0 )
		CGImageRelease( b->imref );
#endif
}

void c_image_bitmap_deselect( CBitmap *b )
{
#ifdef ENV_WIN32
	SelectObject( b->dc, b->oldbmp );
#endif
#ifdef ENV_CARBON
	//b->imref = CGBitmapContextCreateImage( b->ctx );
	int sz = 4 * b->width * b->height;
	int bpr = 4 * b->width;
	
	// re-create data provider
	b->dp = CGDataProviderCreateWithData( 0, b->pixels, sz, c_c_cdata_release );
	
	// re-create image
	b->imref = CGImageCreate( b->width, b->height, 8, 32, bpr, CGColorSpaceCreateDeviceRGB( ), kCGImageAlphaLast, b->dp, 0, 0, kCGRenderingIntentDefault );
#endif
}

typedef struct
{
	int r;
	int g;
	int b;
	int a;
} XPMColour;

void c_image_setpixel( CBitmap *bmp, int x, int y, unsigned int col )
{
#ifdef ENV_WIN32
	SetPixel( bmp->dc, x, y, RGB((col>>24)&0xFF,(col>>16)&0xFF,(col>>8)&0xFF) );
#endif
	
#ifdef ENV_GTK
	guint *pix, np;
	pix = (bmp->pixels + y * bmp->rowstride + x * bmp->channels);
	np = (col>>8) + ((col&0xFF)<<24);
	*pix = np;
#endif
	
#ifdef ENV_CARBON
	unsigned int *pix, np;
	int bpr = 4 * bmp->width;
	
	// each '4' is a pixel
	pix = ( bmp->pixels + ( y * bpr ) + ( x * 4 ) );
	np = col;//(col>>8) + ((col&0xFF)<<24);
	*pix = np;
#endif
}

CBitmap *c_image_bitmap_load_xpm( char *path )
{
	CBitmap *bmp;
	FILE *file;
	char line[1024];
	char col[20];
	int w, h, c, s;
	int a;
	int x, y;
	unsigned char z;
	XPMColour cols[256];
	
	if ( !( file = fopen( path, "rb" ) ) )
	{
		printf( "Error loading XPM (%s)!\n", path );
		return NULL;
	}
	
	// skip 2 header lines
	fgets( line, 1024, file );
	fgets( line, 1024, file );
	
	// def line
	fscanf( file, "\"%d %d %d %d\",\n", &w, &h, &c, &s );

	// get colours from xpm
	for ( a = 0; a < c; a++ )
	{
		fscanf( file, "\"%c\tc %[^\"]\",\n", &z, col );
		cols[z].a = 255;
		if ( col[0] != '#' )
		{
			cols[z].r = C_NATIVE_BACKGROUND>>24&0xFF;
			cols[z].g = C_NATIVE_BACKGROUND>>16&0xFF;
			cols[z].b = C_NATIVE_BACKGROUND>>8&0xFF;
			cols[z].a = 0;
		} else
			sscanf( col, "#%2x%2x%2x", &cols[z].r, &cols[z].g, &cols[z].b );
	}
	
	// create bitmap
	bmp = c_image_bitmap_create( w, h );
	
	// prepare to write
	c_image_bitmap_select( bmp );
	
	// copy image data 
	for ( y = 0; y < h; y++ )
	{
		while ( !feof( file ) && fgetc( file ) != '"' );
		 
		for ( x = 0; x < w; x++ )
		{
			z = fgetc( file );
			
			c_image_setpixel( bmp, x, y, ((cols[z].r<<24) + (cols[z].g<<16) + (cols[z].b<<8) + (cols[z].a)) );
		}
		
		while ( !feof( file ) && fgetc( file ) != '\n' );
	}
	
	// finished writing
	c_image_bitmap_deselect( bmp );
	
#ifdef ENV_GTK
	//bmp->pm = gdk_pixmap_create_from_data( NULL, pixels, bmp->width, bmp->height, depth, &fg, &bg );
	bmp->xpm = gtk_image_new_from_pixbuf( bmp->pb );
#endif
	
	return bmp;
}

#ifdef ENV_GTK

#define CLARO_DEBUG_CODE __FUNCTION__, __FILE__, __LINE__, d_func, d_file, d_line

#define C_GDK_R(x) ((x>>16)&0xFF)
#define C_GDK_G(x) ((x>>8)&0xFF)
#define C_GDK_B(x) (x&0xFF)

void c_gdk_render_pixbuf_to_pixmap_fc_r(
	GdkPixbuf *src, GdkPixmap *dst, GdkGC *gc, 
	int srcx, int srcy, int dstx, int dsty,
	int width, int height,
	char *d_file, int d_line, char *d_func )
{
	// Simple error checking
	
	if ( src == 0 || dst == 0 )
	{
		printf( "Claro *WARNING* %s:%s:%d from %s:%s:%d: Rendering failed because either src (=%p) or dst (=%p) were NULL.\n", CLARO_DEBUG_CODE, src, dst );
		return;
	}
	
	if ( !GDK_IS_PIXMAP( dst ) )
	{
		printf( "Claro *WARNING* %s:%s:%d from %s:%s:%d: dst (=%p) is not GDK_PIXMAP\n", CLARO_DEBUG_CODE, dst );
		return;
	}
	
	if ( !GDK_IS_PIXBUF( src ) )
	{
		printf( "Claro *WARNING* %s:%s:%d from %s:%s:%d: src (=%p) is not GDK_PIXBUF\n", CLARO_DEBUG_CODE, src );
		return;
	}
	
	if ( gdk_pixbuf_get_bits_per_sample( GDK_PIXBUF( src ) ) != 8 || gdk_pixbuf_get_n_channels( GDK_PIXBUF( src ) ) != 4 )
	{
		printf( "Claro *WARNING* %s:%s:%d from %s:%s:%d: Rendering failed because src pixbuf was not 32bit RGBA as expected.\n", CLARO_DEBUG_CODE );
		return;
	}
	
	if ( gdk_pixbuf_get_width( GDK_PIXBUF( src ) ) < srcx+width ||
		 gdk_pixbuf_get_height( GDK_PIXBUF( src ) ) < srcy+height )
	{
		printf( "Claro *WARNING* %s:%s:%d from %s:%s:%d: Rendering failed because src pixbuf was not big enough!\n", CLARO_DEBUG_CODE );
		return;
	}
	
	gint dw, dh;
	
	gdk_drawable_get_size( GDK_PIXMAP( dst ), &dw, &dh );
	
	if ( dw < dstx+width || dh < dsty+height )
	{
		printf( "Claro *WARNING* %s:%s:%d from %s:%s:%d: Rendering failed because dst pixmap was not big enough!\n", CLARO_DEBUG_CODE );
		return;
	}
	
	// Convert destination region to GdkImage (client side, so we can edit)
	GdkImage *img;
	
	img = gdk_drawable_get_image( GDK_PIXMAP( dst ), dstx, dsty, width, height );
	
	if ( img == 0 )
	{
		printf( "Claro *WARNING* %s:%s:%d from %s:%s:%d: img is NULL when trying to get image from drawable\n", CLARO_DEBUG_CODE );
		return;
	}
	
	// Start rendering to the image.
	int x, y;
	guint32 dstpix, newpix;
	guint32 srcpix;
	float alpha;
	int rowstride, channels;
	guchar *pixels;
	
	channels = gdk_pixbuf_get_n_channels( GDK_PIXBUF( src ) );
	pixels = gdk_pixbuf_get_pixels( GDK_PIXBUF( src ) );
	rowstride = gdk_pixbuf_get_rowstride( GDK_PIXBUF( src ) );
	
	for ( y = 0; y < height; y++ )
	{
		for ( x = 0; x < width; x++ )
		{
			// Retrieve the current value of the destination pixel
			dstpix = gdk_image_get_pixel( GDK_IMAGE( img ), x, y );
			
			// Retrieve the current value of the source pixel
			srcpix = *(guint32 *)(pixels + (srcy+y) * rowstride + (srcx+x) * channels);
			
			// Extract alpha, make them the same format
			alpha = (float)( ( srcpix >> 24 ) & 0xFF ) / 255.0f;
			
			// Calculate the new value
			newpix  = ( C_GDK_R( dstpix ) + (uint)( ( C_GDK_R( srcpix ) - C_GDK_R( dstpix ) ) * alpha ) ) << 16;
			newpix += ( C_GDK_G( dstpix ) + (uint)( ( C_GDK_G( srcpix ) - C_GDK_G( dstpix ) ) * alpha ) ) << 8;
			newpix += ( C_GDK_B( dstpix ) + (uint)( ( C_GDK_B( srcpix ) - C_GDK_B( dstpix ) ) * alpha ) );
			
			// Set the destination pixel to the new value
			gdk_image_put_pixel( GDK_IMAGE( img ), x, y, newpix );
		}
	}
	
	// Now we need to render img back to the dst GdkPixmap.
	gdk_draw_image( GDK_DRAWABLE( dst ), GDK_GC( gc ), GDK_IMAGE( img ), 0, 0, dstx, dsty, width, height );
}
#endif

ClaroIcon *c_icon_from_xpm( char *path )
{
	ClaroIcon *icon;
#ifdef ENV_WIN32
	HDC anddc, xordc, cdc;
	HBITMAP maskand;
	HBITMAP maskxor;
#endif
	
	icon = (ClaroIcon *)malloc( sizeof( ClaroIcon ) );
	
	memset( icon, 0, sizeof( ClaroIcon ) );
	
	icon->bitmap = c_image_bitmap_load_xpm( path );
	
#ifdef ENV_WIN32
	icon->info.fIcon = 1;
	icon->info.xHotspot = icon->info.yHotspot = 0;
	
	cdc = GetDC( NULL );
	
	c_image_bitmap_select( icon->bitmap );
	maskxor = CreateCompatibleBitmap( icon->bitmap->dc, icon->bitmap->width, icon->bitmap->height );
	maskand = CreateBitmap( icon->bitmap->width, icon->bitmap->height, 1, 1, NULL );
	
	anddc = CreateCompatibleDC( cdc );
	xordc = CreateCompatibleDC( icon->bitmap->dc );
	
	SelectObject( anddc, maskand );
	SelectObject( xordc, maskxor );
	
	SetBkColor( icon->bitmap->dc, RGB( C_NATIVE_BACKGROUND>>24&0xFF, C_NATIVE_BACKGROUND>>16&0xFF, C_NATIVE_BACKGROUND>>8&0xFF ) );
	BitBlt( anddc, 0, 0, icon->bitmap->width, icon->bitmap->height, icon->bitmap->dc, 0, 0, SRCCOPY );
	BitBlt( xordc, 0, 0, icon->bitmap->width, icon->bitmap->height, icon->bitmap->dc, 0, 0, SRCCOPY );
	BitBlt( xordc, 0, 0, icon->bitmap->width, icon->bitmap->height, anddc, 0, 0, SRCPAINT );
	BitBlt( xordc, 0, 0, icon->bitmap->width, icon->bitmap->height, anddc, 0, 0, SRCINVERT );
	
	icon->info.hbmColor = maskxor;
	icon->info.hbmMask = maskand;
	
	DeleteObject( anddc );
	DeleteObject( xordc );
	
	if ( ( icon->icon = CreateIconIndirect( &icon->info ) ) == NULL )
	{
		MessageBox( 0, "Could not create icon", "Whoops!", 0 );
	}
	
	DeleteObject( maskxor );
	DeleteObject( maskand );
	
	c_image_bitmap_deselect( icon->bitmap );
	
	ReleaseDC( NULL, cdc );
#endif
	
	return icon;
}

//
