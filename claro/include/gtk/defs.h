/*************************************************************************
$Id: defs.h 44 2005-04-30 04:25:57Z terminal $

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

#include "includes.h"
#ifndef _GTK_DEFS_H
#define _GTK_DEFS_H

//#define STYLE_DIR_FALLBACK		"/usr/share/themes"
//#define DEFAULT_STYLE	"Simple"			// styles are first checked in user's from users' home directory   ~/.claro/styles and then in system's shared theme directory

typedef GtkWidget *CNativeWidget;

typedef enum { 
	fs_MINIMIZED			= 1 << 0, 
	fs_NORMAL				= 1 << 1, 
	fs_MAXIMIZED			= 1 << 2,
	fs_SHADED				= 1 << 3 
} FrameState; 

typedef struct _frame Frame; 
typedef struct _button Button; 
	
struct _frame {
	CNativeWidget parent; 
	FrameState state; 	
	//saved location,size
	int x,y,width,height; 
			
	CNativeWidget titlebar_middle_box; // holds label
	CNativeWidget titlebar; 	// table 
		
	CNativeWidget titlebar_top_edge,titlebar_left_edge, title, titlebar_right_edge, titlebar_bottom_edge; 
	Button *menu, *minimize, *maximize, *close;	

	CNativeWidget box; 		// eventbox 
	CNativeWidget base;		// gtktable  
	CNativeWidget client_area; 	// gtklayout 
	CNativeWidget border_left_edge, border_right_edge, border_bottom_edge;
	CNativeWidget border_top_edge; 
};


struct _button { 
	char *name; 
	int x,y,width, height;
	
	char *image_filename, *stock_id;
		
	CNativeWidget box;
	CNativeWidget image; 				// linux GtkImage
	Frame *parent; 
	
	//events  
//	void (*mouse_click)(CNativeWidget *);	// mouse click call back
//	void (*mouse_enter)(CNativeWidget *); 	// for prelight style
//	void (*mouse_leave)(CNativeWidget *); 	// for prelight style 
};


  /*
char *str_copy(char *str);
Button *window_button_create(Frame *parent);
void window_button_destroy(Button *b);
void window_frame_create(CWidget *widget);
void window_frame_destroy(Frame *frame);
void window_save_state(CWidget *widget);
void window_recall_state(CWidget *widget);
void window_set_state(CWidget *widget);
void window_maximize(CWidget *widget);
void window_minimize(CWidget *widget);
void window_normalize(CWidget *widget);
void window_shade(CWidget *widget);
void window_unshade(CWidget *widget);
void window_close(CWidget *cw);
*/
gint window_move_event(GtkWidget *widget, GdkEvent *event, gpointer data);
gint window_minimize_event(GtkWidget *widget, GdkEventButton *e, gpointer data);
gint window_maximize_event(GtkWidget *widget, GdkEventButton *e, gpointer data);
gint window_close_event(GtkWidget *widget, GdkEventButton *e, gpointer data);
gint window_resize_ev(GtkWidget *widget, GdkEvent *e, gpointer data); 
#endif
