/*************************************************************************
$Id: claro.c 106 2005-08-10 00:17:32Z terminal $

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

// root widget ;/
CWidget *c_application;

int c_nfirst_loop = 0;

/* This file contains main loop functions..
 * Actual platform-specific code is included from
 * claro.c in the appropriate platform source folder.
 */
 
/*
 * 
 * Can't do it here.. has to be done in Makefile!
 * 
 * #ifdef ENV_WIN32
 * 	#include "os/win32/claro.c"
 * #else
 * 	#ifdef ENV_GTK
 * 		#include "os/gtk/claro.c"
 * 	#endif
 * #endif
 */
 
void c_proccess_carbon_events( );

#ifdef ENV_WIN32
int c_win32_check_special_msg( CWidget *w, PMSG msg );
#endif

void c_get_native_messages( )
{
#ifdef ENV_WIN32
	MSG msg;
	CWidget *w;
	
	while ( PeekMessage( &msg, 0, 0, 0, PM_REMOVE ) )
	{
		w = c_get_window_by_handle( c_application, msg.hwnd, 0 );
		
		if ( w != 0 && c_win32_check_special_msg( w, &msg ) != 0 )
			continue;
		
		if ( w != 0 && w->info->type != CLARO_WIDGET_WINDOW && w->parent != 0 )
		{
			w = c_get_window_by_handle( c_application, w->parent->info->widget, 0 );
		}
		
		if ( w != 0 && w->info->widget != 0 && w->info->type == CLARO_WIDGET_WINDOW && IsDialogMessage( w->info->widget, &msg ) != 0 )
			continue;
		
		TranslateMessage( &msg );
		DispatchMessage( &msg );
	}
#endif

#ifdef ENV_CARBON
	c_proccess_carbon_events( );
#endif

	/* GTK messages are handled by a signal handler, run below in main it. */
}

void c_crash_handler( int signal )
{
	printf( "Crashed on signal %d\n", signal );
	
	exit( 1 );
}

void c_create_custom_widgets( );

int c_init( char *name, int flags )
{
	printf( "Welcome to '%s' using Claro alpha\n", name );
	
	signal( SIGSEGV, &c_crash_handler );

	c_application = c_new_application( flags );

#ifdef ENV_GTK
	gtk_init (NULL, NULL);
#endif

#ifdef ENV_CARBON
	FlushEvents( everyEvent, 0 );
	InitCursor( );
	
	c_create_custom_widgets( );
#endif

	return 1;
}

int c_gt_loop_it( )
{
	c_get_native_messages( );

	c_dispatch_events( );

	if ( c_application->child_head == 0 )
	{
		if ( !( c_application->info->flags == C_FLAG_NONDESTRUCTIVENULLCHILD ) )
			return -1;
	}

	// NOTE: gtk main iteration already above in native_messages

#ifdef ENV_GTK
	gtk_main_iteration_do(FALSE);
#endif

	return 1;
}

typedef struct c_lp_func
{
	int (*func)();
	
	struct c_lp_func *next;
} CLoopFunction;

CLoopFunction *lfuncs_head = 0;

void c_add_mainloop( int (*func)() )
{
	CLoopFunction *curr, *last;
	
	curr = (CLoopFunction *) malloc( sizeof( CLoopFunction ) );
	curr->next = 0;
	curr->func = func;
	
	if ( lfuncs_head == 0 )
	{
		lfuncs_head = curr;
	}
	else
	{
		last = lfuncs_head;
		
		while ( last->next != 0 )
			last = last->next;
		
		last->next = curr;
	}
}

int c_running = 1;

void c_shutdown( )
{
	c_running = 0;
}

int c_mainloop( )
{
	CLoopFunction *curr;
	int g_loop_ms = 50;
	
	c_add_mainloop( c_gt_loop_it );
	
	printf( "Entering main loop...\n" );
	
	c_running = 1;
	
	while ( c_running )
	{
		curr = lfuncs_head;

		while ( curr )
		{
			if ( (curr->func)() < 0 )
				c_running = 0;

			curr = curr->next;
		}
		
		c_nfirst_loop = 1;
		
		// give other proccesses a chance to work
#ifdef ENV_WIN32
		Sleep( g_loop_ms );
#elif defined(ENV_GTK)
		usleep( g_loop_ms * 100 );
#else
		usleep( g_loop_ms * 1000 );
#endif
	}
	
	printf( "Exiting main loop...\n" );
	
	return 0;
}

void c_cleanup( )
{
	CLoopFunction *curr, *next;
	
	curr = lfuncs_head;
	while ( curr )
	{
		next = curr->next;
		free( curr );
		curr = next;
	}
	
	lfuncs_head = 0;
	
	c_destroy_widget( c_application, 1 );
	c_application = 0;
	
	printf( "c_cleanup( ): All widgets destroyed. Bye! :)\n" );
}
