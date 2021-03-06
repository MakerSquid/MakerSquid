/*************************************************************************
$Id: window.c 115 2005-08-31 00:18:56Z terminal $

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

// FIXME: CLEANING?!?!?
CWidget *app_topmost = 0;

#ifdef ENV_WIN32
int curr_classname_id = 0xF0;

//HWND glob_mdi_client;

// mingw doesn't know this one
BOOL WINAPI FlashWindowEx( PFLASHWINFO );
#endif

void c_window_flash( CWidget *w, int flags, int times )
{
#ifdef ENV_WIN32
	FLASHWINFO flashw;
	
	flashw.cbSize = sizeof( FLASHWINFO );
	flashw.hwnd = w->info->widget;
	flashw.dwFlags = FLASHW_ALL;
	
	if ( times == 0 )
		flashw.dwFlags |= FLASHW_TIMERNOFG;
	
	if ( times == -1 )
		flashw.dwFlags = FLASHW_STOP;
	else
	{
		// we're starting this.. don't do it if we're the active window
		if ( w->info->widget == GetForegroundWindow( ) )
			return;
	}
	
	flashw.uCount = times;
	flashw.dwTimeout = 0;
	
	FlashWindowEx( &flashw );
#endif
}

void c_window_minsize( CWidget *w, int x, int y )
{
	CWindowWidgetInfo *wi = (CWindowWidgetInfo *)w->info;
	wi->minsize_x = x;
	wi->minsize_y = y;
}

void c_window_maxsize( CWidget *w, int x, int y )
{
	CWindowWidgetInfo *wi = (CWindowWidgetInfo *)w->info;
	wi->maxsize_x = x;
	wi->maxsize_y = y;
}

void c_window_set_icon( CWidget *w, ClaroIcon *icon )
{
#ifdef ENV_WIN32
	((CWindowWidgetInfo *)w->info)->icon = icon;

	if ( w->info->widget != 0 )
		SetClassLong( w->info->widget, GCL_HICON, (long)icon->icon );
#endif

#ifdef ENV_GTK
	CWindowWidgetInfo *wi = (CWindowWidgetInfo*)w->info;
/*	Frame *frame; 

	if (w->parent->info->type != CLARO_WIDGET_WORKSPACE ) {
		if ( w->info->widget != 0 )
			gtk_window_set_icon(GTK_WINDOW(w->info->widget), gtk_image_get_pixbuf(GTK_IMAGE(icon->bitmap->xpm)));
	} else {
		frame=wi->frame;
		
		if ( frame != 0 ) {
			if (frame->menu->image!=0)  {
				gtk_container_remove(GTK_CONTAINER(frame->menu->box), frame->menu->image);
				gtk_widget_destroy(frame->menu->image); 	
				
				frame->menu->image = gtk_image_new_from_pixbuf(GDK_DRAWABLE(icon->bitmap->xpm));
				gtk_container_add(GTK_CONTAINER(frame->menu->box), frame->menu->image); 
			}
		} else {
			// FIXME: This needs to be stored and added once it's actually created!
		}
	}
	*/
	if ( w->info->widget != 0 )
		gtk_window_set_icon(GTK_WINDOW(w->info->widget), gtk_image_get_pixbuf(GTK_IMAGE(icon->bitmap->xpm)));
#endif
}

#ifdef ENV_GTK
gint c_window_resized_handler( GtkWidget *widget, GdkEventConfigure *event, CWidget *w )
{
	int x, y, width, height;
	
	x = event->x; y = event->y;
	width = event->width;
	height = event->height;
	c_widget_move_info( w, x, y, width, height );

	return FALSE;
}

void c_windowspace_resized_handler( GtkWidget *widget, GtkAllocation *allocation, CWidget *w )
{
	CWidget *curr;
	
	if ( w->info->cspace.w == allocation->width && w->info->cspace.h == allocation->height )
		return; // no change!
	
	w->info->cspace.x = 0;
	w->info->cspace.y = 0;
	w->info->cspace.w = allocation->width; //w->info->widget->allocation.width;
	w->info->cspace.h = allocation->height; //w->info->widget->allocation.height;
	
	for ( curr = w->child_head; curr != 0; curr = curr->next )
	{
		c_send_event( curr, C_EVENT_PARENTSIZE, 0 );
	}
	
	c_send_event( w, C_EVENT_RESIZE, 0 );
}

static void c_window_destroy_handler( CWidget *cw )
{
	CWidget *curr;
	
	if ( cw->info->type == CLARO_WIDGET_WINDOW && app_topmost != 0 && cw == app_topmost )
	{
		for ( curr = c_application->child_head; curr != 0; curr = curr->next )
			c_widget_enable( curr );
	}
	
	c_destroy_widget( cw, 1 );
}
#endif

#ifndef RBS_AUTOSIZE
#define RBS_AUTOSIZE 0x2000
#endif

#ifdef ENV_CARBON
void c_continue_mouse_event( CWidget *win, CWidget *w, int eid, CGPoint point, int c )
{
	CWidget *curr;
	Rect bnd;
	CGRect cgr;
	int *pos;
	RgnHandle rgn;
	Rect r;
	MouseTrackingRegionID mtr;
	
	for ( curr = w->child_head; curr != 0; curr = curr->next )
	{
		c_continue_mouse_event( win, curr, eid, point, c );
		
		GetControlBounds( curr->info->widget, &bnd );
		
		cgr.origin.x = bnd.left;
		cgr.origin.y = bnd.top;
		cgr.size.width = bnd.right - bnd.left;
		cgr.size.height = bnd.bottom - bnd.top;
		
		if ( CGRectContainsPoint( cgr, point ) )
		{
			pos = (int *)malloc( sizeof( int ) * 2 );
			pos[0] = (int)point.x;
			pos[1] = (int)point.y;
			
			pos[0] -= curr->info->x;
			pos[1] -= curr->info->y;
			
			// Request tracking...
			r.top = curr->info->y;
			r.bottom = curr->info->y + curr->info->height;
			r.left = curr->info->x;
			r.right = curr->info->x + curr->info->width;
			rgn = NewRgn( );
			RectRgn( rgn, &r );
			mtr.signature = 0xDEAD; // FIXME: wth, sleep need more
			mtr.id = time( 0 );
			CreateMouseTrackingRegion( win->info->widget, rgn, 0, kMouseTrackingOptionsLocalClip, mtr, curr, NULL, NULL );
			DisposeRgn( rgn );
			// ^^ doesn't work.. why?
			
			if ( pos[0] > curr->info->width || pos[1] > curr->info->height )
				printf( "Warning: Mouse position ended up greater than size of widget! [Carbon Port - %s:%d]\n", __FILE__, __LINE__ );
			
			c_send_event( curr, eid, pos );
		}
	}
}

pascal OSStatus cWindowHandler( EventHandlerCallRef nextHandler, EventRef theEvent, CWidget *widget )
{
	unsigned int whatHappened = GetEventKind( theEvent );
	RgnHandle theRgn;
	Rect bounds;
	CWidget *curr;
	CGPoint pnt;
	EventMouseButton mbtn;
	int eid;
	unsigned int cc;
	
	switch ( whatHappened )
	{
		case kEventWindowBoundsChanged:
			theRgn = NewRgn();
			GetWindowRegion( widget->info->widget, kWindowContentRgn, theRgn );
			GetRegionBounds( theRgn,&bounds );
			DisposeRgn( theRgn );
			
			bounds.right -= bounds.left;
			bounds.bottom -= bounds.top;
			
			c_widget_move_info( widget, bounds.left, bounds.top, bounds.right, bounds.bottom );
			
			widget->info->cspace.y = 0;
			widget->info->cspace.x = 0;
			widget->info->cspace.w = bounds.right;
			widget->info->cspace.h = bounds.bottom;
			
			c_send_event( widget, C_EVENT_RESIZE, 0 );
			
			for ( curr = widget->child_head; curr != 0; curr = curr->next )
			{
				c_send_event_now( curr, C_EVENT_PARENTSIZE, 0 );
			}
			
			break;
		case kEventControlBoundsChanged:
			exit( 0 );
			break;
		case kEventMouseDown:
			GetEventParameter( theEvent, kEventParamWindowMouseLocation, typeHIPoint, NULL, sizeof(HIPoint), NULL, &pnt );
			GetEventParameter( theEvent, kEventParamMouseButton, typeMouseButton, NULL, sizeof(EventMouseButton), NULL, &mbtn );
			GetEventParameter( theEvent, kEventParamClickCount, typeUInt32, NULL, sizeof(int), NULL, &cc );
			
			pnt.y -= 25; // FIXME: H A C K ! ! !
			
			if ( cc == 1 )
			{
				if ( mbtn == kEventMouseButtonPrimary )
					eid = C_EVENT_MOUSE_LEFT_CLICK;
				else
					eid = C_EVENT_MOUSE_RIGHT_CLICK;
			}
			else
			{
				if ( mbtn == kEventMouseButtonPrimary )
					eid = C_EVENT_MOUSE_LEFT_DBLCLK;
				else
					eid = C_EVENT_MOUSE_RIGHT_DBLCLK;
			}
			
			c_continue_mouse_event( widget, widget, eid, pnt, 0 );
			
			break;
		case kEventMouseUp:
			GetEventParameter( theEvent, kEventParamWindowMouseLocation, typeHIPoint, NULL, sizeof(HIPoint), NULL, &pnt );
			GetEventParameter( theEvent, kEventParamMouseButton, typeMouseButton, NULL, sizeof(EventMouseButton), NULL, &mbtn );
			
			pnt.y -= 25; // FIXME: H A C K ! ! !
			
			if ( mbtn == kEventMouseButtonPrimary )
				eid = C_EVENT_MOUSE_LEFT_RELEASE;
			else
				eid = C_EVENT_MOUSE_RIGHT_RELEASE;
			
			c_continue_mouse_event( widget, widget, eid, pnt, 0 );
			break;
		case kEventMouseMoved:
			GetEventParameter( theEvent, kEventParamWindowMouseLocation, typeHIPoint, NULL, sizeof(HIPoint), NULL, &pnt );
			pnt.y -= 25; // FIXME: H A C K ! ! !
			c_continue_mouse_event( widget, widget, C_EVENT_MOUSE_MOVE, pnt, 0 );
			break;
		case kEventMouseExited:
			exit( 0 );
			break;
	}
	
	return eventNotHandledErr;
}
#endif

#ifdef ENV_WIN32
void c_window_border_size( CWidget *w, int *w_t, int *h_t, int *w_f, int *h_f, int *h_c )
{
	int smx, smy, scy;;
	
	// FIXME: C?SIZEFRAME not right for fixed size windows....
	smx = GetSystemMetrics( SM_CXSIZEFRAME );
	smy = GetSystemMetrics( SM_CYSIZEFRAME );
	
	scy = GetSystemMetrics( SM_CYCAPTION );
	
	if ( w_t != 0 )
		*w_t = smx+smx;
	
	if ( h_t != 0 )
		*h_t = smy+smy+scy;
	
	if ( w_f != 0 )
		*w_f = smx;
	
	if ( h_f != 0 )
		*h_f = smy;
	
	if ( h_c != 0 )
		*h_c = scy;
}
#endif

#ifdef ENV_CARBON
void c_workspace_do_resize( CWidget *w );
#endif

void c_window_handle_create( CEvent *e, void *data )
{
	printf( "%s( )\n", __FUNCTION__ );
	
#ifdef ENV_GTK
	CWindowWidgetInfo *wwi = C_WINDOW_CINFO(e->caller);
	CWidgetInfo *wi = e->caller->info;
	CNativeWidget parent = (CNativeWidget)((CWorkspaceWidgetInfo *)e->caller->parent->info)->clientwin;  // should be gtklayout?
	int flags = wi->flags;
	int w,h;
	CWidget *curr;
	GdkColor bg; 

	static int nx = 0;
	static int ny = 0;
	
	if ( flags & C_DIALOG )
	{
		printf("c_window_handle_create() -- DIALOG\n");
		app_topmost = e->caller;
		for ( curr = c_application->child_head; curr != 0; curr = curr->next )
			if ( curr != e->caller )
				c_widget_enable(curr);
	}
	
	if (flags & C_MDICHILD) {
		wwi->win = gtk_layout_new( NULL, NULL );
		gtk_box_pack_end( GTK_BOX( e->caller->parent->info->widget ), GTK_WIDGET( wwi->win ), TRUE, TRUE, 0 );
		gtk_widget_show_all(wwi->win);
		/*printf("c_window_handle_create() -- mdi child\n");
		wwi->frame = window_frame_create(flags);
		printf("wwi->title=%s\n", wwi->title); 
		gtk_label_set_text(wwi->frame->title, wwi->title);
		window_set_style(e->caller, 0);
		wi->widget = wwi->frame->client_area;
		wwi->frame->state = fs_NORMAL;
		gtk_widget_set_size_request(wwi->frame->box, wi->width, wi->height);
		g_object_ref(wwi->frame->box); 
		gtk_layout_put(e->caller->parent->info->widget, wwi->frame->box,nx,ny);
		wi->x=nx; wi->y=ny; 
		
		nx+=wwi->frame->titlebar->allocation.height+3+10;
		ny+=wwi->frame->titlebar->allocation.height+3+10;
//		printf("NX %d NY %d\n", nx,ny);

		g_signal_connect(G_OBJECT(wwi->frame->minimize->box),"button_press_event",G_CALLBACK(window_minimize_event), e->caller);
		g_signal_connect(G_OBJECT(wwi->frame->maximize->box),"button_press_event",G_CALLBACK(window_maximize_event), e->caller);
		g_signal_connect(G_OBJECT(wwi->frame->close->box),"button_press_event",G_CALLBACK(window_close_event), e->caller);
		g_signal_connect(G_OBJECT(wwi->frame->titlebar_middle_box),"event",G_CALLBACK(window_move_event), e->caller);
		//g_signal_connect(G_OBJECT(wwi->frame->border_bottom_edge), "event", G_CALLBACK(window_resize_ev), e->caller);*/
	} else {
		printf("c_window_handle_create() -- toplevel\n");
		
		wwi->win = gtk_window_new(GTK_WINDOW_TOPLEVEL);
		
		//gdk_color_parse("#000000", &bg);
		//gtk_widget_modify_bg(wwi->win, GTK_STATE_NORMAL, &bg);

		wwi->vbox = gtk_vbox_new( FALSE, 0 );
		wwi->vbox2 = gtk_vbox_new( FALSE, 0 );
		wi->widget = gtk_layout_new(NULL,NULL);
		gtk_widget_set_size_request(wwi->win, wi->width, wi->height);
		gtk_window_move(GTK_WINDOW(wwi->win), wi->x,wi->y);
		gtk_window_set_title(GTK_WINDOW(wwi->win), wwi->title);
		gtk_container_add(GTK_CONTAINER(wwi->win), wwi->vbox);
		gtk_box_pack_end( GTK_BOX(wwi->vbox), wwi->vbox2, TRUE, TRUE, 0 );
		gtk_box_pack_start( GTK_BOX(wwi->vbox2), wi->widget, TRUE, TRUE, 0 );

		gtk_widget_show_all(wwi->win);

		g_signal_connect( G_OBJECT( wwi->win ), "configure_event", G_CALLBACK( c_window_resized_handler ), e->caller );
		g_signal_connect( G_OBJECT( wi->widget ), "size_allocate", G_CALLBACK( c_windowspace_resized_handler ), e->caller );
		g_signal_connect_swapped( G_OBJECT( wwi->win ), "destroy", G_CALLBACK( c_window_destroy_handler ), e->caller );
	}

	c_widget_update_enable( e->caller );
	c_send_event( e->caller, C_EVENT_POSTCREATE, 0 );
	c_send_event( e->caller, C_EVENT_CREATED, 0 );
	c_send_event( e->caller, C_EVENT_RESIZE, 0 );
#endif


#ifdef ENV_CARBON
	CWindowWidgetInfo *wi = (CWindowWidgetInfo *)e->caller->info;
	Rect bounds = { 70, 40, 70+e->caller->info->height, 40+e->caller->info->width };
	WindowAttributes theAttributes = kWindowNoAttributes;
	CFStringRef str;
	CWidget *curr, *widget = e->caller;
	
	if ( e->caller->info->x != -1 )
	{
		bounds.left = e->caller->info->x;
		bounds.right = e->caller->info->x + e->caller->info->width;
	}
	
	if ( e->caller->info->y != -1 )
	{
		bounds.top = e->caller->info->y;
		bounds.bottom = e->caller->info->y + e->caller->info->height;
	}
	
	if ( e->caller->info->flags & C_MDICHILD )
	{
		widget->info->widget = widget->parent->info->widget;
		
		bounds.left = 0;
		bounds.right = e->caller->info->width;
		bounds.top = 0;
		bounds.bottom = e->caller->info->height;
		
		CreateUserPaneControl( e->caller->parent->info->widget, &bounds, kControlSupportsEmbedding, &wi->ws_pcontrol );
		
		c_workspace_newchild( widget->parent, widget );
		
		c_workspace_popup( widget->parent, widget );
		
		/*
		c_workspace_activate( widget->parent, e->caller );
		c_workspace_do_resize( widget->parent );
		*/
		
		/*
		widget->info->cspace.y = 0;
		widget->info->cspace.x = 0;
		widget->info->cspace.w = bounds.right;
		widget->info->cspace.h = bounds.bottom;
		
		c_send_event( widget, C_EVENT_RESIZE, 0 );
		
		for ( curr = widget->child_head; curr != 0; curr = curr->next )
		{
			c_send_event( curr, C_EVENT_PARENTSIZE, 0 );
		}
		
		EventTypeSpec eventTypeList[] =  {
			{ kEventClassControl, kEventControlBoundsChanged },
		};
		
		InstallEventHandler( GetControlEventTarget( e->caller->info->widget ), NewEventHandlerUPP( cWindowHandler ), 1, eventTypeList, e->caller, NULL );
		
		ShowControl( e->caller->info->widget );
		*/
	}
	else
	{
		WindowGroupRef winGroup = NULL;
		
		theAttributes |= kWindowCloseBoxAttribute | kWindowCollapseBoxAttribute | kWindowLiveResizeAttribute;// | kWindowInWindowMenuAttribute;
		theAttributes |= kWindowStandardHandlerAttribute;
		if ( !( e->caller->info->flags & C_DIALOG ) )
			theAttributes |= kWindowResizableAttribute;
		//theAttributes |= kWindowMetalAttribute;
		theAttributes |= kWindowCompositingAttribute;
		theAttributes |= kWindowStandardDocumentAttributes;
		
		str = CFStringCreateWithCString( NULL, wi->title, strlen( wi->title ) );
		
		OSStatus theStatus = CreateNewWindow( kDocumentWindowClass, theAttributes, &bounds, &e->caller->info->widget );
		if ((theStatus != noErr) || (e->caller->info->widget == NULL)) ExitToShell();
		
		SetWindowTitleWithCFString( e->caller->info->widget, str );
		
		CFRelease( str );
		
		ControlRef rootControl;
		CreateRootControl( e->caller->info->widget, &rootControl );
		
		CreateWindowGroup( 0, &winGroup );
        SetWindowGroup( e->caller->info->widget, winGroup );
		
		EventTypeSpec eventTypeList[] =  {
			{ kEventClassWindow, kEventWindowBoundsChanged },
			{ kEventClassWindow, kEventWindowActivated },
			{ kEventClassWindow, kEventWindowDeactivated },
			{ kEventClassWindow, kEventWindowDrawContent },
			{ kEventClassWindow, kEventWindowClose },
			{ kEventClassMouse, kEventMouseDown },
			{ kEventClassMouse, kEventMouseUp },
			{ kEventClassMouse, kEventMouseMoved },
			{ kEventClassMouse, kEventMouseWheelMoved },
			{ kEventClassMouse, kEventMouseExited },
		};
		
		InstallEventHandler( GetWindowEventTarget( e->caller->info->widget ), NewEventHandlerUPP( cWindowHandler ), 10, eventTypeList, e->caller, NULL );
		
		if ( e->caller->info->flags & C_DIALOG )
			RepositionWindow( e->caller->info->widget, NULL, kWindowCenterOnMainScreen );
		ShowWindow( e->caller->info->widget );
		SelectWindow( e->caller->info->widget );
	}
#endif

#ifdef ENV_WIN32
	WNDCLASSEX wc;
	//HMENU menu;
	//MENUITEMINFO mii;
	//CLIENTCREATESTRUCT ccs;
	HWND hwnd, hwnd_parent;//, hwnd_client;
	CWindowWidgetInfo *wi = (CWindowWidgetInfo *)e->caller->info;
	char *name = wi->title;
	int flags = wi->info.flags;
	char clname[1024];
	CWidget *curr;
	REBARINFO rbi;
	int wflags, wexflags, wx, wy;
	HWND wparent;
	int txo, tyo, osx, osy, osc;
	
	if ( flags & C_DIALOG )
	{
		app_topmost = e->caller;
		for ( curr = c_application->child_head; curr != 0; curr = curr->next )
			if ( curr != e->caller )
				EnableWindow( curr->info->widget, false );
	}
	
	sprintf( clname, "claro_window_%d", ++curr_classname_id );
	
	wc.cbSize			= sizeof(WNDCLASSEX);
	wc.style			= 0;
	wc.lpfnWndProc		= c_win32_proc;
	wc.cbClsExtra		= 0;
	wc.cbWndExtra		= 0;
	wc.hInstance		= (HINSTANCE) GetModuleHandle( NULL );
	wc.hCursor			= LoadCursor(NULL, IDC_ARROW);
	if ( flags & C_MDIPARENT )
		wc.hbrBackground = (HBRUSH)COLOR_APPWORKSPACE + 1;
	else
		wc.hbrBackground = (HBRUSH)CreateSolidBrush( RGB( (C_NATIVE_BACKGROUND >> 24) & 0xFF, (C_NATIVE_BACKGROUND >> 16) & 0xFF, (C_NATIVE_BACKGROUND >> 8) & 0xFF ) );
	wc.lpszMenuName		= NULL;
	wc.lpszClassName	= clname;
	wc.hIcon			= (wi->icon==0?LoadIcon( NULL, IDI_APPLICATION ):wi->icon->icon);
	wc.hIconSm			= (wi->icon==0?LoadIcon( NULL, IDI_APPLICATION ):wi->icon->icon);
	

	if ( !RegisterClassEx( &wc ) )
	{
		MessageBox(NULL, "Window Registration Failed!", "Error!", MB_ICONEXCLAMATION | MB_OK);
		return;
	}
	
	wx = e->caller->info->x;
	wy = e->caller->info->y;
	
	c_window_border_size( e->caller, 0, 0, &osx, &osy, &osc );
	
	if ( wx == -1 )
		wx = CW_USEDEFAULT;
	else
		wx -= osx;
	
	if ( wy == -1 )
		wy = CW_USEDEFAULT;
	else
		wy -= ( osc + osy );
	
	if ( flags & C_MDICHILD )
	{
		hwnd_parent = (HWND)((CWorkspaceWidgetInfo *)e->caller->parent->info)->clientwin;
		
		c_window_border_size( e->caller, &txo, &tyo, 0, 0, 0 );
		
		hwnd = CreateMDIWindow(
				clname,
				name,
				0,
				wx, wy,
				e->caller->info->width + txo, e->caller->info->height + tyo,
				hwnd_parent,
				(HINSTANCE) GetModuleHandle( NULL ),
				MAKELPARAM( 0, 0 )
			);
		
		if ( !hwnd )
			MessageBox( hwnd_parent, "MDI Child creation failed.", "Uh-Oh...", MB_ICONEXCLAMATION | MB_OK );
		
		c_send_event( e->caller, C_EVENT_RESIZE, 0 );
	}
	else
	{
		wflags = WS_OVERLAPPEDWINDOW - (flags&C_NOSYSMENU?WS_SYSMENU:0);
		wexflags = ( flags & C_TOPMOST ? WS_EX_TOPMOST : 0 );
		
		wparent = 0;

		if ( flags & C_DIALOG && e->caller->parent->info->type == CLARO_WIDGET_WINDOW )
		{
			wflags = WS_POPUPWINDOW | WS_DLGFRAME | WS_THICKFRAME | WS_OVERLAPPED | WS_CLIPSIBLINGS | DS_MODALFRAME;
			wexflags = WS_EX_DLGMODALFRAME | WS_EX_WINDOWEDGE | WS_EX_CONTROLPARENT;
			// create a dummy invisible parent window for our window, hiding us from the taskbar.
			wparent = CreateWindowEx( 0, clname, "", WS_POPUP, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, NULL, NULL, NULL, NULL );
		}
		
		if ( flags & C_WINDOW_CENTER_TO_PARENT )
		{
			// center the window in the center of the parent (Claro) window.
			int px, py, pw, ph, mw, mh;
			
			if ( e->caller->parent != 0 && e->caller->parent->info->type == CLARO_WIDGET_WINDOW )
			{
				px = e->caller->parent->info->x;
				py = e->caller->parent->info->y;
				pw = e->caller->parent->info->width;
				ph = e->caller->parent->info->height;
			}
			else
			{
				// FIXME: screen 
				px = 0;
				py = 0;
				RECT sr;
				GetClientRect( GetDesktopWindow( ), &sr );
				pw = sr.right;
				ph = sr.bottom;
			}
			
			mw = e->caller->info->width;
			mh = e->caller->info->height;
			
			wx = px + ( pw / 2 ) - ( mw / 2 );
			wy = py + ( ph / 2 ) - ( mh / 2 );
		}
		
		/*
		txo = GetSystemMetrics( SM_CXSIZEFRAME ) * 2;
		tyo = GetSystemMetrics( SM_CYCAPTION ) + ( GetSystemMetrics( SM_CYSIZEFRAME ) * 2 );
		*/
		
		c_window_border_size( e->caller, &txo, &tyo, 0, 0, 0 );
		
		if ( wi->dock_pos != 0 )
		{
			wflags = WS_CHILD | WS_VISIBLE;
			wparent = e->caller->parent->parent->info->widget;
			txo = 0;
			tyo = 0;
			printf( "%p is my parent parent widget\n", wparent );
		}
		
		//txo = tyo = 0;
		
		hwnd = CreateWindowEx(
				wexflags,
				clname,
				name,
				wflags,
				wx, wy,
				e->caller->info->width + txo, e->caller->info->height + tyo,
				wparent, NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL
			);
		
		if ( wi->dock_pos == 0 )
		{
			((CWindowWidgetInfo *)e->caller->info)->rebar = CreateWindowEx( WS_EX_TOOLWINDOW,
							REBARCLASSNAME,
							NULL,
							WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_CLIPCHILDREN | RBS_VARHEIGHT | CCS_NODIVIDER,
							0, 0, CW_USEDEFAULT, 0,
							hwnd,
							NULL,
							(HINSTANCE) GetModuleHandle( NULL ),
							NULL );
			
			rbi.cbSize = sizeof( REBARINFO );
			rbi.fMask  = 0;
			rbi.himl   = (HIMAGELIST)NULL;
			if ( !SendMessage( ((CWindowWidgetInfo *)e->caller->info)->rebar, RB_SETBARINFO, 0, (LPARAM)&rbi ) )
			{
				MessageBox( 0, "Could not create window: RB_SETBARINFO", 0, 0 );
			}
			
			// Initialize structure members that both bands will share.
			((CWindowWidgetInfo *)e->caller->info)->rebar_info.cbSize = sizeof(REBARBANDINFO);  // Required
			((CWindowWidgetInfo *)e->caller->info)->rebar_info.fMask  = RBBIM_SIZE | RBBIM_CHILD | 
			        RBBIM_CHILDSIZE | RBBIM_ID | RBBIM_STYLE | RBBIM_TEXT | RBBIM_BACKGROUND;
			((CWindowWidgetInfo *)e->caller->info)->rebar_info.fStyle = RBBS_CHILDEDGE | RBBS_FIXEDBMP | RBS_AUTOSIZE;
		}
	}
	
	if ( hwnd == NULL )
	{
		MessageBox(NULL, "Window Creation Failed!", "Error!", MB_ICONEXCLAMATION | MB_OK);
		return;
	}
	
	// save window
	e->caller->info->widget = (CNativeWidget)hwnd;

	c_font_fix( e->caller );
	
	c_widget_update_enable( e->caller );
	
	c_send_event( e->caller, C_EVENT_POSTCREATE, 0 );
	c_send_event( e->caller, C_EVENT_CREATED, 0 );
	c_send_event( e->caller, C_EVENT_RESIZE, 0 );
#endif

	printf("c_window_handle_create( )\n");
}

void c_window_handle_postcreate( CEvent *e, void *data )
{
#ifdef ENV_WIN32
	HWND hwnd = e->caller->info->widget;
	int flags = e->caller->info->flags;

	if ( flags & C_START_MAXIMISE )
		ShowWindow( hwnd, SW_SHOWMAXIMIZED );
	else if ( flags & C_START_MINIMISE )
		ShowWindow( hwnd, SW_SHOWMINIMIZED );
	else
		ShowWindow( hwnd, SW_SHOW );
	
	UpdateWindow( hwnd );
#endif
#ifdef ENV_GTK
	CWindowWidgetInfo *wi = (CWindowWidgetInfo *)e->caller->info;
	
	printf("c_handle_postcreate()\n"); 
	
	//CNativeWidget widget = e->caller->info->widget; 
	if (wi->info.flags & C_START_MAXIMISE) {
		//if (! (wi->info.flags & C_MDICHILD)) {
			gtk_window_maximize(GTK_WINDOW(wi->win)); 
			gtk_widget_show_all(wi->win); 
		/*} else {
			window_maximize(e->caller); 
			gtk_widget_show_all(wi->frame->box); 
		}*/
	} else if (wi->info.flags & C_START_MINIMISE) {
		//if (!(wi->info.flags & C_MDICHILD)) {
			gtk_window_iconify(GTK_WINDOW(wi->win)); 
			gtk_widget_show_all(wi->win);
		/*} else {
			window_minimize(e->caller);   // this already at this point, shades as well.
			//window_shade(e->caller); 
		}*/
	} else {
		//if (!(wi->info.flags & C_MDICHILD)) 
			gtk_widget_show_all(wi->win); 
		/*else {
			window_save_state(e->caller);
			window_normalize(e->caller);
			gtk_widget_show_all(wi->frame->box);
		}*/
	}
#endif
}

void c_window_handle_internal_destroy( CEvent *e, void *data )
{
	if ( e->caller == app_topmost )
	{
		app_topmost = 0;
	}
}

void c_window_settitle( CWidget *w, char *title )
{
	// first, check if we are allowed to touch this widget
	if ( w->freeze_destroy == 1 )
		return;
	
	strncpy( ((CWindowWidgetInfo *)w->info)->title, title, 1024 );
#ifdef ENV_WIN32
	SetWindowText( w->info->widget, ((CWindowWidgetInfo *)w->info)->title );
#endif
#ifdef ENV_GTK
	/*
	if (w->info->flags & C_MDICHILD)
		gtk_label_set_label(GTK_LABEL(((CWindowWidgetInfo*)w->info)->frame->title), title);
	else
	*/
		gtk_window_set_title(GTK_WINDOW(w->info->widget), title);
#endif
}

CWidget *c_new_window( CWidget *parent, char *title, int width, int height, int flags )
{
	CWidget *w;//, *curr;

	printf("Creating a window called '%s'\n", title);

	if ( parent == 0 )
		parent = c_application;

	w = c_clone_widget( 0, parent );

	c_init_widget_info( w, sizeof( CWindowWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_WINDOW;
	w->info->width = width;
	w->info->height = height;
	w->info->x = -1;
	w->info->y = -1;
	w->info->flags = flags;
	w->info->visible = 1;
	((CWindowWidgetInfo *)w->info)->dock_pos = 0;
	((CWindowWidgetInfo *)w->info)->icon = 0;
	strncpy( ((CWindowWidgetInfo *)w->info)->title, title, 1024 );

	((CWindowWidgetInfo *)w->info)->statusbar = 0;
	((CWindowWidgetInfo *)w->info)->menubar = 0;
	
	w->info->cspace.y = 0;
	w->info->cspace.x = 0;
	w->info->cspace.w = width;
	w->info->cspace.h = height;

	c_window_maxsize( w, 0xFFFFFF, 0xFFFFFF );
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_window_handle_create );
	c_new_event_handler( w, C_EVENT_POSTCREATE, c_window_handle_postcreate );
	c_new_event_handler( w, C_EVENT_INTERNAL_DESTROY, c_window_handle_internal_destroy );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
