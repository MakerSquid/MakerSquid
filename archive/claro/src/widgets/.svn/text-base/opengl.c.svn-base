/*************************************************************************
$Id$

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

#ifdef ENV_OPENGL

void c_opengl_flip( CWidget *w )
{
	SwapBuffers( ((COpenGLWidgetInfo *)w->info)->dc );
}

void c_opengl_activate( CWidget *w )
{
#ifdef ENV_WIN32
	wglMakeCurrent( ((COpenGLWidgetInfo *)w->info)->dc, ((COpenGLWidgetInfo *)w->info)->hrc );
#endif
}

void c_opengl_setup( CWidget *w )
{
	// size viewport
	glViewport( w->info->x, w->info->y, w->info->width, w->info->height );
	
	// set matrix mode to projection
	glMatrixMode( GL_PROJECTION );
	glLoadIdentity( );
	
	// perspective
	gluPerspective( 50.0f, (GLfloat)w->info->width / (GLfloat)w->info->height, 0.1f, 1000.0f ); 
	
	// modelview matrix
	glMatrixMode( GL_MODELVIEW );
	glLoadIdentity( );
	
	// clear depth
	glClearDepth( 1.0f );
	
	// enable some GL features
	glEnable( GL_DEPTH_TEST );
	glDepthFunc( GL_LEQUAL );
	
	glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );

	glEnable( GL_TEXTURE_2D );
	
	glEnable( GL_ALPHA_TEST );
	glEnable( GL_BLEND );
	glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
	glAlphaFunc( GL_GEQUAL, 0.01f );
	
	//glShadeModel( GL_SMOOTH );
	
	glDisable( GL_CULL_FACE );
	/*glEnable( GL_CULL_FACE );
	glCullFace( GL_BACK );*/
	
	// smoothing
	//glEnable( GL_POLYGON_SMOOTH );
	glEnable( GL_LINE_SMOOTH );
	glEnable( GL_POINT_SMOOTH );
	
	// create fake texture as #1
	GLuint textmp;
	glGenTextures( 1, &textmp );
}

void c_opengl_handle_create( CEvent *e, void *data )
{
	COpenGLWidgetInfo *lwi = (COpenGLWidgetInfo *)e->caller->info;

#ifdef ENV_WIN32
	HWND hwnd;
	HWND hwnd_parent = e->caller->parent->info->widget;
	WNDCLASSEX wc;
	static int curr_gl_classname_id = 0;
	char clname[1024];
	GLuint pixelformat;
	
	PIXELFORMATDESCRIPTOR pfd =
	{
		sizeof( PIXELFORMATDESCRIPTOR ),
		1,
		PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER,
		PFD_TYPE_RGBA,
		0, // -1
		0,0,0,0,0,0,0,0,
		0,0,0,0,0,
		0, //
		0, //
		0,
		PFD_MAIN_PLANE,
		0,
		0,0,0
	};
	
	pfd.cColorBits = 32;//colourbits;
	pfd.cDepthBits = 32;//depthbits;
	pfd.cStencilBits = 32;//stencilbits;
	
	sprintf( clname, "claro_gl_%d", ++curr_gl_classname_id );
	
	wc.cbSize			= sizeof(WNDCLASSEX);
	wc.style			= 0;
	wc.lpfnWndProc		= c_win32_proc;
	wc.cbClsExtra		= 0;
	wc.cbWndExtra		= 0;
	wc.hInstance		= (HINSTANCE) GetModuleHandle( NULL );
	wc.hCursor			= LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground = (HBRUSH)CreateSolidBrush( RGB( 0, 0, 0 ) );
	wc.lpszMenuName		= NULL;
	wc.lpszClassName	= clname;
	wc.hIcon			= LoadIcon( NULL, IDI_APPLICATION );
	wc.hIconSm			= LoadIcon( NULL, IDI_APPLICATION );
	

	if ( !RegisterClassEx( &wc ) )
	{
		MessageBox(NULL, "Window Registration Failed!", "Error!", MB_ICONEXCLAMATION | MB_OK);
		return;
	}
	
	if ( !( hwnd = CreateWindowEx( ( e->caller->info->flags & C_BORDER_NONE ? 0 : WS_EX_CLIENTEDGE ), clname, 
	                               "OpenGL",
	                               WS_CHILD | WS_VISIBLE,
	                               lwi->info.x, lwi->info.y,
	                               lwi->info.width, lwi->info.height,
	                               hwnd_parent,
	                               NULL, (HINSTANCE) GetModuleHandle( NULL ), NULL ) ) )
		MessageBox( 0, "Could not create opengl HWND.", "Claro error", 0 );
	
	e->caller->info->widget = hwnd;
	
	if( !( lwi->dc = GetDC( hwnd ) ) )
	{
		MessageBox( 0, "Can't create a GL Device Context.", "ERROR", MB_OK | MB_ICONEXCLAMATION );
		return;
	}
	
	pixelformat = ChoosePixelFormat( lwi->dc, &pfd );

	if( !( pixelformat = ChoosePixelFormat( lwi->dc, &pfd ) ) )
	{
		MessageBox( 0, "Can't find a suitable PixelFormat.", "ERROR", MB_OK | MB_ICONEXCLAMATION );
		return;
	}

	if( !( SetPixelFormat( lwi->dc, pixelformat, &pfd ) ) )
	{
		MessageBox( 0, "Can't set the PixelFormat.", "ERROR", MB_OK | MB_ICONEXCLAMATION );
		return;
	}
	
	if( !( lwi->hrc = wglCreateContext( lwi->dc ) ) )
	{
		MessageBox( 0, "Can't create a GL Rendering Context.", "ERROR", MB_OK | MB_ICONEXCLAMATION );
		return;
	}
	
	if( !( wglMakeCurrent( lwi->dc, lwi->hrc ) ) )
	{
		MessageBox( 0, "Can't activate the GL Rendering Context.", "ERROR", MB_OK | MB_ICONEXCLAMATION );
		return;
	}
	
	ShowWindow( hwnd, SW_SHOW );
	SetForegroundWindow( hwnd );
	SetFocus( hwnd );
	/*
	c_font_fix( e->caller );
	
	ShowWindow( hwnd, SW_SHOW );
	UpdateWindow( hwnd );
	
	c_widget_update_enable( e->caller );
	*/
	c_send_event( e->caller, C_EVENT_UPDATE, 0 );
#endif

	c_widget_install( e->caller );

	printf("c_opengl_handle_create( )\n");
}

void c_opengl_handle_resize( CEvent *e, void *data )
{
	c_opengl_setup( e->caller );
}

/*void c_opengl_handle_update( CEvent *e, void *data )
{
	COpenGLWidgetInfo *lwi = (COpenGLWidgetInfo *)e->caller->info;
	
	printf( "c_opengl_handle_update( )\n" );
	
	c_send_event( e->caller, C_EVENT_DRAW, 0 );
}*/

CWidget *c_new_opengl( CWidget *parent, int x, int y, int width, int height, int flags )
{
	CWidget *w;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( COpenGLWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_OPENGL;
	w->info->x = x;
	w->info->y = y;
	w->info->visible = 1;
	w->info->width = width;
	w->info->height = height;
	w->info->flags = flags;
	
	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_opengl_handle_create );
	c_new_event_handler( w, C_EVENT_RESIZE, c_opengl_handle_resize );
	//c_new_event_handler( w, C_EVENT_UPDATE, c_opengl_handle_update );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}

#endif

//
