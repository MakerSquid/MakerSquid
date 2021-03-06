/*************************************************************************
$Id: canvas.c 119 2005-11-02 22:02:49Z terminal $

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

int scroll_bar_dim = 15;

// default native background. real set in application.c
unsigned int c_native_background = 0xD4D0C800;

#ifdef ENV_CARBON
CGContextRef theCGContext = 0;
int theCanvasHeight;

#define CC_RED(c) (((c >> 24) & 0xFF) / 255.0f)
#define CC_GRN(c) (((c >> 16) & 0xFF) / 255.0f)
#define CC_BLU(c) (((c >> 8) & 0xFF) / 255.0f)
#define CC_ALP(c) ((c & 0xFF) / 255.0f)
#endif

#ifdef ENV_WIN32
extern int curr_classname_id;
#endif

#ifdef ENV_GTK
void c_make_native_color( unsigned int c, GdkColor *col )
{
	int r = (gushort)(   c >> 24 );
	int g = (gushort)( ( c >> 16 ) & 0xFF );
	int b = (gushort)( ( c >> 8  ) & 0xFF );

	/* Gdk doesn't use the alpha channel */
	col->pixel = c >> 8;
	col->red = r;
	col->green = g;
	col->blue = b;
}
#endif

void c_canvas_paint_line( CWidget *w, int colour, int x1, int y1, int x2, int y2 )
{
#ifdef ENV_GTK
	CCanvasWidgetInfo *cwi = (CCanvasWidgetInfo *)w->info;
	GdkColor col;

	c_make_native_color( colour, &col );
	gdk_gc_set_foreground( cwi->gc, &col );
	gdk_draw_line( GDK_PIXMAP( cwi->pm ), cwi->gc, x1, y1, x2, y2 );
#endif

#ifdef ENV_WIN32
	RECT r;
	HPEN pen, oldpen;
	HDC hdc = ((CCanvasWidgetInfo *)w->info)->hdcMem;
	
	r.top = 0;
	r.left = 0;
	r.bottom = w->info->height+10;
	r.right = w->info->width+10;
	
	pen = CreatePen( PS_SOLID, 1, RGB( (colour >> 24) & 0xFF, (colour >> 16) & 0xFF, (colour >> 8) & 0xFF ) );
	
	oldpen = SelectObject( hdc, pen );
	MoveToEx( hdc, x1, y1, 0 );
	LineTo( hdc, x2, y2 );
	SelectObject( hdc, oldpen );
	
	DeleteObject( pen );
#endif
}

void c_canvas_paint_icon( CWidget *w, ClaroIcon *icon, int x, int y )
{
	CCanvasWidgetInfo *cwi = (CCanvasWidgetInfo *)w->info;

#ifdef ENV_WIN32
	DrawIconEx( cwi->hdcMem, x, y, icon->icon, icon->bitmap->width, icon->bitmap->height, 0, NULL, DI_NORMAL );
#endif
	
#ifdef ENV_GTK
	c_gdk_render_pixbuf_to_pixmap_fc( GDK_PIXBUF( icon->bitmap->pb ), GDK_PIXMAP( cwi->pm ), cwi->gc, 0, 0, x, y, icon->bitmap->width, icon->bitmap->height );
	//gdk_draw_drawable( GDK_PIXMAP( cwi->pm ), cwi->gc, GDK_PIXMAP( icon->bitmap->pm ), 0, 0, x, y, icon->bitmap->width, icon->bitmap->height );
#endif

#ifdef ENV_CARBON
	CGRect myCGRect;
	
	myCGRect.origin.x = x;
	myCGRect.origin.y = y;
	myCGRect.size.width = icon->bitmap->width;
	myCGRect.size.height = icon->bitmap->height;
	
	myCGRect.origin.y = theCanvasHeight - myCGRect.origin.y;
	myCGRect.size.height = - myCGRect.size.height;
	
	CGContextDrawImage( theCGContext, myCGRect, icon->bitmap->imref );
#endif
}

void c_canvas_paint_fillrect( CWidget *w, int colour, int x, int y, int width, int height )
{
#ifdef ENV_GTK
	CCanvasWidgetInfo *cwi = (CCanvasWidgetInfo *)w->info;
	GdkColor col;

	c_make_native_color( colour, &col );
	gdk_gc_set_foreground( cwi->gc, &col );
	gdk_draw_rectangle( GDK_PIXMAP( cwi->pm ), cwi->gc, TRUE, x, y, width, height );
#endif

#ifdef ENV_CARBON
	CGRect myCGRect;
	
	CGContextSetRGBFillColor( theCGContext, CC_RED(colour), CC_GRN(colour), CC_BLU(colour), 1.0f );
	
	myCGRect.origin.x = x;
	myCGRect.origin.y = y;
	myCGRect.size.width = width;
	myCGRect.size.height = height;
	
	myCGRect.origin.y = theCanvasHeight - myCGRect.origin.y;
	myCGRect.size.height = - myCGRect.size.height;
	
	CGContextFillRect( theCGContext, myCGRect );
#endif

#ifdef ENV_WIN32
	RECT r;
	HBRUSH brush;
	HDC hdc = ((CCanvasWidgetInfo *)w->info)->hdcMem;
	
	r.top = y;
	r.left = x;
	r.bottom = y+height;
	r.right = x+width;
	
	brush = CreateSolidBrush( RGB( (colour >> 24) & 0xFF, (colour >> 16) & 0xFF, (colour >> 8) & 0xFF ) );
	
	FillRect( hdc, &r, brush );
	
	DeleteObject( brush );
#endif
}

void c_canvas_paint_clear( CWidget *w, int colour )
{
#ifdef ENV_GTK
	CCanvasWidgetInfo *cwi = (CCanvasWidgetInfo *)w->info;
	GdkColor col;

	c_make_native_color( colour, &col );
	gdk_gc_set_foreground( cwi->gc, &col );
	gdk_draw_rectangle( GDK_PIXMAP( cwi->pm ), cwi->gc, TRUE, 0, 0, cwi->info.width, cwi->info.height );
#endif

#ifdef ENV_CARBON
	CGRect myCGRect;
	CFont *font = (CFont *)w->font;
	
	CGContextSetRGBFillColor( theCGContext, CC_RED(colour), CC_GRN(colour), CC_BLU(colour), 1.0f );
	
	myCGRect.origin.x = 0.0f;
	myCGRect.origin.y = 0.0f;
	myCGRect.size.width = w->info->width;
	myCGRect.size.height = w->info->height;
	
	myCGRect.origin.y = theCanvasHeight - myCGRect.origin.y;
	myCGRect.size.height = - myCGRect.size.height;
	
	CGContextFillRect( theCGContext, myCGRect );
	
	CGContextSelectFont( theCGContext, font->face, font->size, kCGEncodingMacRoman );
	CGContextSetTextDrawingMode( theCGContext, kCGTextFill );
	/*CGContextSetRGBFillColor( theCGContext, 1.0f, 0.0f, 0.0f, 1.0f );
	CGContextShowTextAtPoint( theCGContext, 100, 100, "Quartz 2D", 9);*/
#endif

#ifdef ENV_WIN32
	RECT r;
	HBRUSH brush;
	HDC hdc = ((CCanvasWidgetInfo *)w->info)->hdcMem;
	
	r.top = 0;
	r.left = 0;
	r.bottom = w->info->height+10;
	r.right = w->info->width+10;
	
	brush = CreateSolidBrush( RGB( (colour >> 24) & 0xFF, (colour >> 16) & 0xFF, (colour >> 8) & 0xFF ) );
	
	FillRect( hdc, &r, brush );
	
	DeleteObject( brush );
#endif
}

void c_canvas_paint_text_full( CWidget *w, int x, int y, int width, int height, int colour, char *text, int flags )
{
#ifdef ENV_GTK
	CCanvasWidgetInfo *cwi = (CCanvasWidgetInfo *)w->info;
	PangoLayout *pl;
	GdkColor col;
	
	c_make_native_color( colour, &col );
	gdk_gc_set_foreground( cwi->gc, &col );
	
	pl = gtk_widget_create_pango_layout( cwi->gimg, text );
	
	gdk_draw_layout( GDK_PIXMAP( cwi->pm ), cwi->gc, x, y, pl );
	
	free( pl );
#endif

#ifdef ENV_CARBON
	CFont *font = (CFont *)w->font;
	
	CGContextSetRGBFillColor( theCGContext, CC_RED(colour), CC_GRN(colour), CC_BLU(colour), 1.0f );
	
	CGContextSetTextDrawingMode( theCGContext, kCGTextFill );
	CGContextSelectFont( theCGContext, font->face, font->size, kCGEncodingMacRoman );
	CGContextShowTextAtPoint( theCGContext, x, theCanvasHeight - y - font->size, text, strlen( text ) ); 
	
	/*
	ATSUSetTextPointerLocation( font->c_text_layout, text, kATSUFromTextBeginning, strlen( text ), strlen( text ) );
	ATSUSetRunStyle( font->c_text_layout, font->c_text_style, kATSUFromTextBeginning, strlen( text ) );
	ATSUDrawText( font->c_text_layout, kATSUFromTextBeginning, kATSUToTextEnd, x, theCanvasHeight - y - font->size );
	*/
#endif

#ifdef ENV_WIN32
	HDC dc = ((CCanvasWidgetInfo *)w->info)->hdcMem;
	RECT r;
	int flg;
	
	SetBkMode( dc, TRANSPARENT );
	
	SelectObject( dc, ((CFont *)w->font)->wfont );
	SetTextColor( dc, RGB( (colour >> 24) & 0xFF, (colour >> 16) & 0xFF, (colour >> 8) & 0xFF ) );
	
	r.left = x;
	r.top = y;
	r.right = x+width;
	r.bottom = y+height;
	
	flg = DT_LEFT | DT_NOPREFIX;
	
	if ( !( flags & C_CANVAS_TEXT_CLIP ) )
		flg |= DT_NOCLIP;
	else
		flg |= DT_END_ELLIPSIS;
	
	DrawText( dc, text, strlen( text ), &r, flg );
#endif
}

void c_canvas_paint_text( CWidget *w, int x, int y, int colour, char *text )
{
	c_canvas_paint_text_full( w, x, y, 0, 0, colour, text, 0 );
}

#ifdef ENV_CARBON
/*EventHandlerUPP        StandardEventHandlerUPP = NULL;
EventTypeSpec          standardEvents[] = { { kEventClassControl, kEventControlClick } };*/
ToolboxObjectClassRef  canvasControl = NULL;

CWidget *c_get_window_by_handle( CWidget *from, ControlRef win, int sect )
{
	CWidget *c;
	CWidget *a;
	
	for ( c = from->child_head; c != 0; c = c->next ) {
		if ( c->info->widget == win && c->info->type != CLARO_WIDGET_ALIGNER )
			return c;
	
		a = c_get_window_by_handle( c, win, sect );
		if ( a != 0 )
			return a;
	}
	
	return 0;
}

int c_carbon_predraw_real = 0;

OSStatus ClaroCanvasControlHandler( EventHandlerCallRef myHandler, EventRef theEvent, void *userData )
{
	ControlRef	theControl;
	UInt32		whatHappened;
	OSStatus	internalResult, result = eventNotHandledErr;
	GrafPtr		savedPort, controlPort;
	Rect bounds;
	CWidget *cw;
	CEvent *e2;

	whatHappened = GetEventKind (theEvent);

	GetEventParameter( theEvent, kEventParamDirectObject, typeControlRef, NULL, sizeof(ControlRef), NULL, &theControl );
	
	cw = (CWidget *)userData;
	
	if ( userData == 0 )
		cw = c_get_window_by_handle( c_application, theControl, 0 );

	switch (whatHappened)
	{
		case kEventControlInitialize:
			/*GetEventParameter( theEvent, kEventParamDirectObject, typeControlRef, NULL, sizeof(ControlRef), NULL, &theControl );
        	internalResult = InstallControlEventHandler(theControl, StandardEventHandlerUPP, GetEventTypeCount(standardEvents),
														standardEvents, NULL, NULL );*/
			result = noErr;
			break;
		case kEventControlDraw:
			c_carbon_predraw_real = 1;
			c_send_event_now( cw, C_EVENT_PREDRAW, 0 );
			c_carbon_predraw_real = 0;
			result = noErr;
			break;
		case kEventControlTrack:
			break;
	}
	
	return result;
}

void initCanvasControl( )
{
	OSStatus result = noErr;
	EventTypeSpec CEventList[] = {
		{ kEventClassControl, kEventControlDraw },
		{ kEventClassControl, kEventControlInitialize },
		{ kEventClassControl, kEventControlActivate },
		{ kEventClassControl, kEventControlDeactivate },
		{ kEventClassControl, kEventControlTrack },
		{ kEventClassControl, kEventControlHitTest },
		{ kEventClassMouse, kEventMouseDown },
		{ kEventClassMouse, kEventMouseUp },
		{ kEventClassMouse, kEventMouseMoved },
		{ kEventClassMouse, kEventMouseWheelMoved },
	};

	result = RegisterToolboxObjectClass( CFSTR("com.claro.canvas"), NULL, GetEventTypeCount(CEventList),
										 CEventList, NewEventHandlerUPP( ClaroCanvasControlHandler ), NULL, &canvasControl );
}
#endif

#ifdef ENV_CARBON
pascal void c_carbon_scrolling( ControlHandle control, SInt16 part );
#endif

void c_canvas_handle_create( CEvent *e, void *data )
{
	CCanvasWidgetInfo *bwi = (CCanvasWidgetInfo *)e->caller->info;
	
#ifdef ENV_GTK
	bwi->pm = gdk_pixmap_new( NULL, bwi->info.width, bwi->info.height, 24 );
	e->caller->info->widget = gtk_event_box_new( );
	bwi->gimg = gtk_image_new_from_pixmap( bwi->pm, NULL );
	gtk_container_add(GTK_CONTAINER( e->caller->info->widget), bwi->gimg );
	bwi->gc = gdk_gc_new( bwi->pm );
	gtk_widget_show( bwi->gimg );
	gtk_widget_show( e->caller->info->widget );

	gtk_widget_set_events(e->caller->info->widget, GDK_POINTER_MOTION_MASK | GDK_BUTTON_PRESS_MASK); 		

	gtk_widget_set_events( e->caller->info->widget, 
		GDK_LEAVE_NOTIFY_MASK | GDK_BUTTON_PRESS_MASK |
		GDK_POINTER_MOTION_MASK | GDK_EXPOSURE_MASK );
	
	gtk_layout_put( GTK_LAYOUT(e->caller->parent->info->widget), e->caller->info->widget, bwi->info.x, bwi->info.y);
	
	g_signal_connect( G_OBJECT( e->caller->info->widget ), "configure_event", G_CALLBACK( c_window_resized_handler ), e->caller );
	
	g_signal_connect( G_OBJECT( e->caller->info->widget ), "button_press_event", G_CALLBACK( c_gtk_widget_click_handler ), e->caller );
	g_signal_connect( G_OBJECT( e->caller->info->widget ), "motion_notify_event", G_CALLBACK( c_gtk_widget_motion_handler ), e->caller );
	
	if ( e->caller->info->flags & C_SCROLLING_VERT )
	{
		gtk_layout_put( GTK_LAYOUT(e->caller->parent->info->widget), e->caller->info->vscroll, bwi->info.x, bwi->info.y );
		gtk_widget_show( e->caller->info->vscroll );
	}
	
	// FIXME: HORIZ scrolling!
#endif

#ifdef ENV_CARBON
	ControlDefSpec canvasControlSpec;
	Collection controlParams = NULL;
	OSStatus result;
	Rect boundsCanvas = { 0, 0, 0, 0 };
	Rect r;
	
	boundsCanvas.left = bwi->info.x;
	boundsCanvas.top = bwi->info.y;
	
	if ( bwi->info.width == -1 )
		boundsCanvas.right = boundsCanvas.left + 100;
	else
		boundsCanvas.right = boundsCanvas.left + bwi->info.width;
	
	if ( bwi->info.height == -1 )
		boundsCanvas.bottom = boundsCanvas.top + 15;
	else
		boundsCanvas.bottom = boundsCanvas.top + bwi->info.height;
	
	controlParams = NewCollection( );
	
	canvasControlSpec.defType = kControlDefObjectClass;
	canvasControlSpec.u.classRef = canvasControl;
	
	result = CreateCustomControl( e->caller->parent->info->widget, &boundsCanvas, &canvasControlSpec, controlParams, &e->caller->info->widget );
	
	if ( bwi->info.flags & C_SCROLLING_VERT )
	{
		r.left = boundsCanvas.right - scroll_bar_dim;
		r.right = boundsCanvas.right;
		r.top = boundsCanvas.top;
		r.bottom = boundsCanvas.bottom;
		CreateScrollBarControl( e->caller->parent->info->widget, &r, 0, 0, 0, 0, true, NewEventHandlerUPP( c_carbon_scrolling ), &e->caller->info->vscroll );
	}
#endif
	
#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;
	WNDCLASSEX wc;
	int flags = bwi->info.flags;
	char clname[1024];
	
	sprintf( clname, "claro_window_%d", ++curr_classname_id );
	
	wc.cbSize			= sizeof(WNDCLASSEX);
	wc.style			= 0;
	wc.lpfnWndProc		= c_win32_proc;
	wc.cbClsExtra		= 0;
	wc.cbWndExtra		= 0;
	wc.hInstance		= (HINSTANCE) GetModuleHandle( NULL );
	wc.hIcon			= LoadIcon(NULL, IDI_APPLICATION);
	wc.hCursor			= LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground    = NULL;//(HBRUSH)COLOR_WINDOW;
	wc.lpszMenuName		= NULL;
	wc.lpszClassName	= clname;
	wc.hIconSm			= LoadIcon(NULL, IDI_APPLICATION);

	if ( !RegisterClassEx( &wc ) )
	{
		MessageBox(NULL, "Window Registration Failed!", "Error!", MB_ICONEXCLAMATION | MB_OK);
		return;
	}
	
	if ( !( hwnd = CreateWindowEx( ( flags & C_BORDER_NONE ? 0 : WS_EX_CLIENTEDGE ), clname, 
	                               0,
	                               WS_CHILD | WS_VISIBLE | ( flags & C_SCROLLING_VERT ? WS_VSCROLL : 0) | ( flags & C_SCROLLING_HORIZ ? WS_HSCROLL : 0),
	                               bwi->info.x, bwi->info.y,
	                               bwi->info.width, bwi->info.height,
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create canvas HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;
	
	e->caller->info->sci.cbSize = sizeof(SCROLLINFO);
	e->caller->info->sci.fMask  = SIF_RANGE | SIF_PAGE | SIF_TRACKPOS | SIF_POS;
	SetScrollInfo( e->caller->info->widget, SB_VERT, &(e->caller->info->sci), true );
	
	ShowWindow( hwnd, SW_SHOW );
	UpdateWindow( hwnd );
	
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );
#endif

	c_widget_install( e->caller );

	printf("c_canvas_handle_create( )\n");
}

extern int c_nfirst_loop;

void c_canvas_invalid( CWidget *w )
{
	CCanvasWidgetInfo *cwi = (CCanvasWidgetInfo *)w->info;
	
	cwi->valid = 0;
}

void c_canvas_handle_predraw( CEvent *e, void *data )
{
	CEvent *e2 = c_find_handler( C_EVENT_DRAW, e->caller->handlers );
	CCanvasWidgetInfo *cwi = (CCanvasWidgetInfo *)e->caller->info;
#ifdef ENV_CARBON
	CGrafPtr controlPort;
	Rect bounds;
	CGRect crect;
	
	if ( c_carbon_predraw_real == 0 )
	{
		// not really drawing, just request it.
		
		Draw1Control( e->caller->info->widget );
		return;
	}
#endif
	
	//printf( "c_canvas_handle_predraw( )\n" );
	
	if ( e2 == NULL )
		return;
	
#ifdef ENV_CARBON
	//GetPort( &controlPort );
	controlPort = GetWindowPort( e->caller->parent->info->widget );
	GetPortBounds( controlPort, &bounds );
	QDBeginCGContext( controlPort, &theCGContext ); 
	/*
	crect.origin.x = (bounds.bottom - bounds.top) - e->caller->info->y;
	crect.origin.y = e->caller->info->x;
	crect.size.width = e->caller->info->width;
	crect.size.height = -e->caller->info->height;
	
	CGContextClipToRect( theCGContext, crect );
	*/
	theCanvasHeight = (bounds.bottom - bounds.top) - e->caller->info->y;
	
	// draw on the canvas
#endif

#ifdef ENV_WIN32
	// get the DC now, this stops the font functions from calling it each time they are called..
	e->caller->info->wdc = GetDC( e->caller->info->widget );
	
	// Windows saves to a memory DC.. if we're valid
	if ( cwi->valid == 1 )
	{
		// just redraw the image
		// FIXME: this should just be the part that needs to be drawn
		BitBlt( e->caller->info->wdc, 0, 0, cwi->buff_w, cwi->buff_h, cwi->hdcMem, 0, 0, SRCCOPY );
		
		// release wdc cache
		ReleaseDC( e->caller->info->widget, e->caller->info->wdc );
		e->caller->info->wdc = 0; // ready for other calls, we release it.
		
		return; // we're done here.
	}
	
	cwi->valid = 1; // say we've got a valid memory image
#endif

	(*e2->handler)( e2, data );
	
#ifdef ENV_CARBON
	// end drawing
	
	QDEndCGContext( controlPort, &theCGContext );
	theCGContext = 0;
	
	// redraw scrollbar
	if ( e->caller->info->flags & C_SCROLLING_VERT )
		Draw1Control( e->caller->info->vscroll );
#endif
	
#ifdef ENV_WIN32
	if ( c_nfirst_loop )
		BitBlt( e->caller->info->wdc, 0, 0, cwi->buff_w, cwi->buff_h, cwi->hdcMem, 0, 0, SRCCOPY );
	
	// release wdc cache
	ReleaseDC( e->caller->info->widget, e->caller->info->wdc );
	e->caller->info->wdc = 0; // ready for other calls, we release it.
#endif

#ifdef ENV_GTK
	gtk_widget_queue_draw_area( cwi->gimg, 0, 0, e->caller->info->width, e->caller->info->height );
#endif
}

void c_canvas_handle_resize( CEvent *e, void *data )
{
	CCanvasWidgetInfo *cwi = (CCanvasWidgetInfo *)e->caller->info;
#ifdef ENV_WIN32
	int win_width, win_height;
#endif
	
	//printf( "c_canvas_handle_resize( )\n" );
	cwi->valid = 0;

#ifdef ENV_CARBON
	if ( e->caller->info->flags & C_SCROLLING_VERT )
	{
		MoveControl( e->caller->info->vscroll, e->caller->info->x + e->caller->info->width - scroll_bar_dim, e->caller->info->y );
		SizeControl( e->caller->info->vscroll, scroll_bar_dim, e->caller->info->height );
	}
#endif

#ifdef ENV_GTK
	if ( e->caller->info->flags & C_SCROLLING_VERT )
	{
		gtk_layout_move( e->caller->parent->info->widget, cwi->info.vscroll, cwi->info.x + cwi->info.width - cwi->info.vscroll->allocation.width, cwi->info.y );
		gtk_widget_set_size_request( cwi->info.vscroll, cwi->info.vscroll->allocation.width, cwi->info.height );
		gtk_layout_move( cwi->info.widget, cwi->info.widget, cwi->info.x, cwi->info.y );
		gtk_widget_set_size_request( cwi->info.widget, cwi->info.width - cwi->info.vscroll->allocation.width, cwi->info.height );
		cwi->info.width -= cwi->info.vscroll->allocation.width;
	}
	
	GdkPixmap *npm;
	npm = gdk_pixmap_new( NULL, cwi->info.width, cwi->info.height, 24 );
	gtk_image_set_from_pixmap( cwi->gimg, npm, NULL );
	gdk_pixmap_unref( cwi->pm );
	cwi->pm = npm;
#endif
	
#ifdef ENV_WIN32
	win_width = c_widget_width( e->caller );
	win_height = c_widget_height( e->caller );
	
	if ( ((CCanvasWidgetInfo *)e->caller->info)->buff_w == win_width && ((CCanvasWidgetInfo *)e->caller->info)->buff_h == win_height )
		return;
	
	((CCanvasWidgetInfo *)e->caller->info)->buff_w = win_width;
	((CCanvasWidgetInfo *)e->caller->info)->buff_h = win_height;
	
	if ( ((CCanvasWidgetInfo *)e->caller->info)->buff == 1 ) {
		SelectObject( ((CCanvasWidgetInfo *)e->caller->info)->hdcMem, ((CCanvasWidgetInfo *)e->caller->info)->hOld );
		DeleteObject( ((CCanvasWidgetInfo *)e->caller->info)->hbmMem );
		DeleteDC    ( ((CCanvasWidgetInfo *)e->caller->info)->hdcMem );
		ReleaseDC   ( (HWND)e->caller->info->widget, ((CCanvasWidgetInfo *)e->caller->info)->hdc );
	}
	
	((CCanvasWidgetInfo *)e->caller->info)->hdc = GetDC( (HWND)e->caller->info->widget );

	((CCanvasWidgetInfo *)e->caller->info)->hdcMem = CreateCompatibleDC( ((CCanvasWidgetInfo *)e->caller->info)->hdc );
	((CCanvasWidgetInfo *)e->caller->info)->hbmMem = CreateCompatibleBitmap( ((CCanvasWidgetInfo *)e->caller->info)->hdc, win_width, win_height );
	((CCanvasWidgetInfo *)e->caller->info)->hOld = SelectObject( ((CCanvasWidgetInfo *)e->caller->info)->hdcMem, ((CCanvasWidgetInfo *)e->caller->info)->hbmMem );

	((CCanvasWidgetInfo *)e->caller->info)->buff = 1;
	
	ReleaseDC( e->caller->info->widget, ((CCanvasWidgetInfo *)e->caller->info)->hdc );
#endif

#ifdef ENV_CARBON
	Draw1Control( e->caller->info->widget );
#else
	c_send_event_now( e->caller, C_EVENT_PREDRAW, 0 );
#endif
}

void c_canvas_handle_update( CEvent *e, void *data )
{
	//CCanvasWidgetInfo *bwi = (CCanvasWidgetInfo *)e->caller->info;
	//printf( "c_canvas_handle_update( )\n" );
	
	c_canvas_invalid( e->caller );
	c_send_event( e->caller, C_EVENT_PREDRAW, 0 );
}


CWidget *c_new_canvas( CWidget *parent, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CCanvasWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_CANVAS;
	w->info->x = x;
	w->info->y = y;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_canvas_handle_create );
	c_new_event_handler( w, C_EVENT_UPDATE, c_canvas_handle_update );
	c_new_event_handler( w, C_EVENT_RESIZE, c_canvas_handle_resize );
	c_new_event_handler( w, C_EVENT_PREDRAW, c_canvas_handle_predraw );
	
#ifdef ENV_GTK
	if ( flags & C_SCROLLING_VERT )
	{
		w->info->vsa = gtk_adjustment_new( 1, 1, 1, 1, 1, 1 );
		w->info->vscroll = gtk_vscrollbar_new( w->info->vsa );
	}
#endif
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
