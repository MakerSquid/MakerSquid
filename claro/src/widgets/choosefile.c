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

/*

	CWidget *n = c_new_choosefile( mainwin );
	c_choosefile_set_filter( n, "C Sources (*.c)\0*.C\0Header files (*.h)\0*.H\0\0" );
	if ( c_choosefile_save( n ) == 0 ) {
		// Fine, just cancel me like that! :(
	} else {
		// :D
		// filename is in:
		//   c_choosefile_get_filename( n )
	}
	
*/

void c_choosefile_set_filter( CWidget *w, char *filter )
{
	CChooseFileWidgetInfo *cfwi = (CChooseFileWidgetInfo *)w->info;

#ifdef ENV_WIN32
	cfwi->ofn.lpstrFilter = filter;
#endif
}

char *c_choosefile_get_filename( CWidget *w )
{
	CChooseFileWidgetInfo *cfwi = (CChooseFileWidgetInfo *)w->info;

#ifdef ENV_WIN32
	return cfwi->ofn.lpstrFile;
#endif
}

int c_choosefile_open( CWidget *w )
{
	CChooseFileWidgetInfo *cfwi = (CChooseFileWidgetInfo *)w->info;
	int a = 0;
	
#ifdef ENV_WIN32
	char moo[128];
	
	getcwd( moo, 128 );
	
	a = GetOpenFileName( &cfwi->ofn );
	
	chdir( moo );
#endif
	
	return a;
}

int c_choosefile_save( CWidget *w )
{
	CChooseFileWidgetInfo *cfwi = (CChooseFileWidgetInfo *)w->info;
	int a = 0;
	
#ifdef ENV_WIN32
	char moo[128];
	
	getcwd( moo, 128 );
	
	a = GetSaveFileName( &cfwi->ofn );
	
	chdir( moo );
#endif
	
	return a;
}

void c_choosefile_handle_create( CEvent *e, void *data )
{
	//CChooseFileWidgetInfo *cfwi = (CChooseFileWidgetInfo *)e->caller->info;
	
	printf("c_choosefile_handle_create( )\n");
}

void c_choosefile_handle_destroy( CEvent *e, void *data )
{
	CChooseFileWidgetInfo *cfwi = (CChooseFileWidgetInfo *)e->caller->info;
	
#ifdef ENV_WIN32
	free( cfwi->ofn.lpstrFile );
#endif
	
	printf( "c_choosefile_handle_destroy( )\n" );
}

CWidget *c_new_choosefile( CWidget *parent )
{
	CWidget *w;
	CChooseFileWidgetInfo *cfwi;
	
	if ( parent == 0 )
		parent = c_application;
	
	w = c_clone_widget( 0, parent );
	
	c_init_widget_info( w, sizeof( CChooseFileWidgetInfo ) );
	
	w->info->type = CLARO_WIDGET_CHOOSEFILE;
	w->info->x = 0;
	w->info->y = 0;
	w->info->width = 0;
	w->info->height = 0;
	w->info->flags = 0;
	w->info->visible = 1;
	
	cfwi = (CChooseFileWidgetInfo *)w->info;
	
#ifdef ENV_WIN32
	memset( &cfwi->ofn, 0, sizeof( OPENFILENAME ) );
	cfwi->ofn.lStructSize = sizeof( OPENFILENAME );
	cfwi->ofn.lpstrFile = malloc( 1024 );
	cfwi->ofn.nMaxFile = 1024;
	strcpy( cfwi->ofn.lpstrFile, "" );

	cfwi->ofn.hwndOwner = w->parent->info->widget;
#endif

	// add event handler
	c_new_event_handler( w, C_EVENT_CREATE, c_choosefile_handle_create );
	c_new_event_handler( w, C_EVENT_DESTROY, c_choosefile_handle_destroy );
	
	// actually SEND the create event
	c_send_event( w, C_EVENT_CREATE, 0 );
	
	return w;
}
