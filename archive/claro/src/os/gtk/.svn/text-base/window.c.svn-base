#include "../../../include/includes.h" 

#if 0

// this code doesn't work.. I left it here for reference.
// some day it would be nice if we had "real" WiW MDI,
// but for now we'll pass.

extern CWidget *app_topmost; 
extern GtkWidget *glob_mdi_client;
extern CWidget *current_child; 

GList *minlist;
int minheight=0;
int minwidth=0;
int mincount=0;

char *str_copy(char *str) {
	char *t = (char*)malloc(strlen(str)+1); memset(t,0,strlen(str)+1);
	return strcpy(t,str); 
}
Button *window_button_create(Frame *parent) {
	Button *button = (Button*)malloc(sizeof(Button)); 
	
	memset(button,0,sizeof(Button)); 

	button->parent = parent; 
	button->box = gtk_event_box_new(); 
	button->image=gtk_image_new_from_stock(GTK_STOCK_JUSTIFY_FILL,GTK_ICON_SIZE_MENU);	// default image ( stop button ) -- basically a square

	gtk_container_add(GTK_CONTAINER(button->box), button->image);

	return button; 
}

void window_button_destroy(Button *b) {
	free(b->name);
	//free(b->image_filename);
	//free(b->stock); 
	if (b->image!=0) gtk_widget_destroy(b->image); 
	gtk_widget_destroy(b->box); 
	free(b); 
}

void window_set_style(CWidget *widget, int id) {
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;
	
	GdkColor bg;
	
	gdk_color_parse("gray", &bg);
	gtk_widget_modify_bg(frame->titlebar_middle_box, GTK_STATE_NORMAL, &bg);
	gtk_widget_modify_bg(frame->menu->box, GTK_STATE_NORMAL, &bg);
	gtk_widget_modify_bg(frame->minimize->box, GTK_STATE_NORMAL, &bg);
	gtk_widget_modify_bg(frame->maximize->box, GTK_STATE_NORMAL, &bg);
	gtk_widget_modify_bg(frame->close->box, GTK_STATE_NORMAL, &bg);
	
	gdk_color_parse("black", &bg);
	gtk_widget_modify_bg(frame->box, GTK_STATE_NORMAL, &bg);

	gdk_color_parse("#aaaaaa", &bg);
	gtk_widget_modify_bg(frame->client_area, GTK_STATE_NORMAL, &bg);
	gdk_color_parse("#ff0000", &bg);
	gtk_widget_modify_bg(frame->border_left_edge, GTK_STATE_NORMAL, &bg);
	gdk_color_parse("#00ff00", &bg);
	gtk_widget_modify_bg(frame->border_right_edge, GTK_STATE_NORMAL, &bg);
	gdk_color_parse("#0000ff", &bg);
	gtk_widget_modify_bg(frame->border_bottom_edge, GTK_STATE_NORMAL, &bg);
	gdk_color_parse("#ff00ff", &bg);
	gtk_widget_modify_bg(frame->border_top_edge, GTK_STATE_NORMAL, &bg);

	// set sizes
	printf("style, set top edge size\n"); 
	gtk_widget_set_size_request(frame->border_top_edge, widget->info->width, 5);
	gtk_widget_set_size_request(frame->border_bottom_edge, widget->info->width, 5);
	gtk_widget_set_size_request(frame->border_left_edge, 5,widget->info->height);
	gtk_widget_set_size_request(frame->border_right_edge, 5,widget->info->height);
}
Frame *window_frame_create(int flags) {
	Frame *frame = (Frame*)malloc(sizeof(Frame)); memset(frame,0,sizeof(Frame));
	GtkWidget *t;
	GdkColor bg;

	printf("window_frame_create()\n");
	
	// create titlebar
	frame->titlebar = gtk_hbox_new(FALSE,0);
	frame->minimize = window_button_create(frame);
	frame->maximize = 	window_button_create(frame);
	frame->close = window_button_create(frame);
	frame->titlebar_middle_box = gtk_event_box_new(); 
	frame->title = gtk_label_new("<unknown>");
	frame->client_area = gtk_layout_new(NULL,NULL);
	frame->box = gtk_event_box_new();
	frame->border_left_edge=gtk_event_box_new();
	frame->border_right_edge=gtk_event_box_new();
	frame->border_bottom_edge=gtk_event_box_new();
	frame->border_top_edge=gtk_event_box_new();

	if (!(flags & C_NOSYSMENU) ) frame->menu = window_button_create(frame);

	// surprising enuf with these commented out, it still works.
//	gtk_widget_set_events(frame->minimize->box, GDK_BUTTON_PRESS_MASK | GDK_ENTER_NOTIFY_MASK | GDK_LEAVE_NOTIFY_MASK);  // click, mouse enter/leave
//	gtk_widget_set_events(frame->maximize->box, GDK_BUTTON_PRESS_MASK | GDK_ENTER_NOTIFY_MASK | GDK_LEAVE_NOTIFY_MASK);  // click, mouse enter/leave
//	gtk_widget_set_events(frame->close->box, GDK_BUTTON_PRESS_MASK | GDK_ENTER_NOTIFY_MASK | GDK_LEAVE_NOTIFY_MASK);  // click, mouse enter/leave
//	gtk_widget_set_events(frame->titlebar_middle_box, GDK_BUTTON_PRESS_MASK | GDK_ENTER_NOTIFY_MASK | GDK_LEAVE_NOTIFY_MASK);  // click, mouse enter/leave
//	gtk_widget_set_events(frame->box, NULL);  // when clicked this window will become focused or movable using alt key and mouse button 1
//	gtk_widget_set_events(frame->client_area, NULL);  // when clicked this window will become focused or movable using alt key and mouse button 1
	
	gtk_container_add(GTK_CONTAINER(frame->titlebar_middle_box), frame->title);
	
	//hbox
	gtk_box_pack_start(GTK_BOX(frame->titlebar), frame->menu->box, FALSE,FALSE,0);
	gtk_box_pack_start(GTK_BOX(frame->titlebar), frame->titlebar_middle_box, TRUE,TRUE,0);
	gtk_box_pack_end(GTK_BOX(frame->titlebar), frame->close->box, FALSE,FALSE,0);
	gtk_box_pack_end(GTK_BOX(frame->titlebar), frame->maximize->box, FALSE,FALSE,0);
	gtk_box_pack_end(GTK_BOX(frame->titlebar), frame->minimize->box, FALSE,FALSE,0);

	//vbox
	t=gtk_vbox_new(FALSE,0); // to hold titlebar and client_area
	gtk_box_pack_start(GTK_BOX(t),frame->titlebar,FALSE,TRUE,0);
	gtk_box_pack_start(GTK_BOX(t),frame->client_area, TRUE,TRUE,0);

	GtkWidget *t1 = gtk_hbox_new( FALSE, 0);
	gtk_box_pack_start(GTK_BOX(t1), frame->border_left_edge, FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(t1), t, TRUE, TRUE, 0);
	gtk_box_pack_start(GTK_BOX(t1), frame->border_right_edge, FALSE, FALSE, 0);

	GtkWidget *t2 = gtk_vbox_new(FALSE,0);
	gtk_box_pack_start(GTK_BOX(t2), frame->border_top_edge, FALSE, FALSE,0);
	gtk_box_pack_start(GTK_BOX(t2), t1, TRUE,TRUE,0);
	gtk_box_pack_start(GTK_BOX(t2), frame->border_bottom_edge, FALSE,FALSE,0);
	
	frame->base = t2;
	
	gtk_container_add(GTK_CONTAINER(frame->box), frame->base);
	
	return frame;
	
}
void window_frame_destroy(Frame *frame) {
	// destroy titlebar 
	window_button_destroy(frame->menu);
	window_button_destroy(frame->minimize);
	window_button_destroy(frame->maximize);
	window_button_destroy(frame->close);

	gtk_widget_destroy(frame->title); 			// label
	gtk_widget_destroy(frame->titlebar); 		// table
	gtk_widget_destroy(frame->titlebar_middle_box); 	
	
	gtk_widget_destroy(frame->client_area); 	// layout -- destroys any children inside layout as well.
	gtk_widget_destroy(frame->base); 
	gtk_widget_destroy(frame->box); 
	
	// no need to destroy borders yet.
	free(frame); 
}

void c_gtk_widget_post_resize_events( CWidget *w )
{
	GtkAllocation allc;
	
	allc.width = w->info->width;
	allc.height = w->info->height;
	
	c_windowspace_resized_handler( w->info->widget, &allc, w );
}

#define MINSPACING			3
#define MINWIDTHSIZE    	150
#define HIDETITLEBARONMIN	1

void reorder_min_item(gpointer data, gpointer ud) {
	CWidget *widget = (CWidget*)data;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;

	printf("reorder_min_item()\n"); 
	
	if (minheight==0) {
		minheight = widget->parent->info->height-frame->titlebar->allocation.height-MINSPACING;
	}
	if (minwidth+MINWIDTHSIZE>widget->parent->info->width) {
		minheight -= frame->titlebar->allocation.height+MINSPACING;
		minwidth=0; 
	}
	//window_set_size(widget, MINWIDTHSIZE,widget->titlebar->allocation.height+MINSPACING);
	printf("reorder move to: %d %d\n", minwidth, minheight); 	
	window_move(widget, minwidth, minheight);
	minwidth=minwidth+MINWIDTHSIZE;
}

void mins_remove(CWidget *widget) {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;


	minlist=g_list_remove(minlist, widget);
	mincount-=1;
	minwidth=0; minheight=0; 
	if (mincount>0 )  g_list_foreach(minlist, &reorder_min_item, NULL);
}

void mins_add(CWidget *widget) {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;

	int w,h; 
	minlist=g_list_append(minlist, widget);
	mincount+=1;
	minwidth=0; minheight=0; 
	g_list_foreach(minlist, &reorder_min_item, NULL);
}

void window_move(CWidget *widget, int x, int y) {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;
	GtkWidget *layout = widget->parent->info->widget;

	// printf("window_move()\n"); 
	gtk_layout_move(GTK_LAYOUT(layout),frame->box,x, y);
	widget->info->x=x;  widget->info->y=y; 
}

void window_set_size(CWidget *widget, int width, int height)  {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;

	// printf("window_set_size()\n"); 
	widget->info->width=width;  widget->info->height=height;
	gtk_widget_set_size_request(frame->box,wi->width,wi->height);
	
	c_gtk_widget_post_resize_events( widget );
}

void window_save_state(CWidget *widget) {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;
	
	// printf("window_save_state()\n");
	
	frame->x 		= wi->x; 		frame->y 		= wi->y;
	frame->width	= wi->width;	frame->height	= wi->height;
}

void window_recall_state(CWidget *widget) {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;
	
	// printf("window_recall_state()\n");

	wi->x 			= frame->x; 	wi->y 			= frame->y;
	wi->width 		= frame->width; wi->height		= frame->height;
}

void window_set_state(CWidget *widget) {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;
	GtkWidget *layout = widget->parent->info->widget;
	
	printf("window_set_state()\n");
	
	gtk_widget_set_size_request(frame->box,wi->width,wi->height);
	gtk_layout_move(GTK_LAYOUT(layout),frame->box,wi->x, wi->y);
	
	c_gtk_widget_post_resize_events( widget );
}

void window_maximize(CWidget *widget) {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;
	
	printf("window_maximize()\n");
	
	if (frame->state & fs_MAXIMIZED) {
		window_normalize(widget);
	} else if ((frame->state & fs_MINIMIZED) || (frame->state & fs_NORMAL)) {
		if (frame->state & fs_NORMAL)   { window_save_state(widget); }
		if (frame->state & fs_MINIMIZED) { mins_remove(widget); }
		frame->state = fs_MAXIMIZED;
		wi->x=0; 									wi->y=0;
		wi->width= widget->parent->info->width;     wi->height = widget->parent->info->height;
		window_set_state(widget);		
	}
}

void window_minimize(CWidget *widget) {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;
	int h,w;
	
	printf("window_minimize() %d\n", frame->state);
	
	if (frame->state & fs_MINIMIZED) {
		window_normalize(widget);
	} else if((frame->state & fs_MAXIMIZED) || (frame->state & fs_NORMAL)) {
		if (frame->state & fs_NORMAL) { window_save_state(widget); }
		frame->state = fs_MINIMIZED;

		w=MINWIDTHSIZE; h=frame->titlebar->allocation.height;
	
		wi->width=w; wi->height=h;
		window_set_size(widget,w,h);
		
		mins_add(widget); 
	}
}

void window_normalize(CWidget *widget) {
	CWidgetInfo *wi = widget->info;
	Frame *frame = ((CWindowWidgetInfo*)widget->info)->frame;
	
	printf("window_normalize()\n");

	if ((frame->state & fs_MAXIMIZED) || (frame->state & fs_MINIMIZED)) {
		if (frame->state & fs_MINIMIZED) { mins_remove(widget); }
		
		frame->state = fs_NORMAL;
		window_recall_state(widget);
		window_set_state(widget);
	}

}

/*
void window_shade(CWidget *widget) {
	CWidgetInfo *wi = widget->info;
	CWindowWidgetInfo *wwi = ((CWindowWidgetInfo*)widget->info);
	Frame *frame = wwi->frame;
	GtkWidget *layout = frame->parent;
	printf("window_shade()\n");
	if (! (frame->state & fs_SHADED)) { 
		window_save_state(widget); 

		//wi->x = 0; wi->y = layout->allocation.height - 66; 
		frame->state |= fs_SHADED; 
		wi->height = 64; 
	
		window_set_state(widget); 
	}
}
void window_unshade(CWidget *widget) { 
	CWindowWidgetInfo *wi = (CWindowWidgetInfo*)widget->info;
	Frame *frame = wi->frame;
	printf("window_unshade()\n");
	if (frame->state & fs_SHADED) {
		window_recall_state(widget); 
		window_set_state(widget); 
		frame->state -= fs_SHADED;
	}
}
*/

void window_close(CWidget *cw) {
	CWidgetInfo *wi = cw->info;
	CWindowWidgetInfo *wwi = ((CWindowWidgetInfo*)cw->info);
	Frame *frame = wwi->frame;
	CWidget *curr; 
	printf("window_close()\n");
	if ( wi->type == CLARO_WIDGET_WINDOW && app_topmost != 0 && cw == app_topmost ) {
		for ( curr = c_application->child_head; curr != 0; curr = curr->next )	{
				c_widget_enable( curr );
		}
	}

	if ( wi->type == CLARO_WIDGET_WINDOW && wi->flags & C_MDICHILD ) {
		window_frame_destroy(frame); 
	}

	c_destroy_widget( cw, 1 );
}

// events
gint window_move_event(GtkWidget *widget, GdkEvent *event, gpointer data) {
	// widget = eventbox, data = CWidget 

	// preserved across function calls
	static gboolean moving = FALSE;
	static gint cx, cy; 
	static gint px, py; 
	static gint sc=0;

	gint ex, ey,wx,wy,rx,ry;
	gint dx,dy;

	CWidget *w = (CWidget*)data; 
	GtkWidget *layout = w->parent->info->widget;
	GdkModifierType modtype;
	CWidgetInfo *wi = w->info;
	CWindowWidgetInfo *wwi = (CWindowWidgetInfo*)w->info;
	Frame *frame = wwi->frame;

	switch (event->type) {
		case GDK_2BUTTON_PRESS: // titlebar action
			if ((frame->state & fs_MAXIMIZED) ) {		// make normal
				window_normalize( w );
			} else if (frame->state & fs_NORMAL) {	//maximize it
				window_maximize( w );		
			} else if (frame->state & fs_MINIMIZED) {
				window_normalize(w); 
			} break; 
		case GDK_BUTTON_PRESS:	// focus, moving
			if (event->button.button == 1) {

				if (wwi->focused==0)  {
					// set focus
					c_widget_focus(w);
				}
				
				cx=(int)event->button.x;  cy=(int)event->button.y;
				ex=event->button.x; ey=event->button.y;

				gtk_grab_add(widget);
				moving=TRUE;
				g_printf("clicked!  (%d, %d)\n", cx, cy);
				
				return TRUE;
			} break;
		case GDK_MOTION_NOTIFY:
			if (moving && (event->motion.state & GDK_BUTTON1_MASK)) {
				wx = frame->box->allocation.x; wy = frame->box->allocation.y;
				ex=event->button.x; ey = event->button.y;
				rx = wx-cx+ex; ry = wy-cy+ey;
				window_move(w, rx,ry);
				//gtk_layout_move(GTK_LAYOUT(layout),frame->box, rx, ry);

				return TRUE;
			} break;
		case GDK_BUTTON_RELEASE: 
			gtk_grab_remove(widget);
			moving=FALSE;  return TRUE;
			break;
		default: break;
	}
	return FALSE;
}
gint window_minimize_event(GtkWidget *widget, GdkEventButton *e, gpointer data) {
	window_minimize((CWidget*) data);
	printf("minimized window..\n");
	return TRUE;
}
gint window_maximize_event(GtkWidget *widget, GdkEventButton *e, gpointer data) {
	window_maximize((CWidget*) data);

	printf("maximized window..\n");
	return TRUE;
}
gint window_close_event(GtkWidget *widget, GdkEventButton *e, gpointer data) {

	window_close((CWidget*)data); 	
	return TRUE;
}

gboolean window_resize_ev(GtkWidget *w, GdkEvent *event, gpointer data) {
	CWidgetInfo *wi = ((CWidget*)data);
	CWindowWidgetInfo *wwi = ((CWindowWidgetInfo*)wi);
	Frame *frame = wwi->frame;
	
	static int ox=0;
	static int oy=0;
	static moving=0;
	int ex, ey;

//	GtkLayout *l = ((GtkLayout*)((CWindowWidgetInfo*)((CWidget*)data)->parent->info))->widget;
//      printf("event()\n");
	switch (event->type) {
		case GDK_BUTTON_PRESS:{
			if (event->button.button==1) {
				ox=event->button.x_root-w->allocation.x; oy=event->button.y_root-w->allocation.y;
				printf("bx %d  by %d\n",ox,oy);
				moving=1;
				ex=w->allocation.x; ey=w->allocation.y;
//				gtk_container_remove(l,w);
				//gtk_layout_put(l,w,ex,ey);
				gtk_grab_add(w);
			}
		} break;
		case GDK_MOTION_NOTIFY:{

//                      if (event->motion.is_hint) {
                                //gdk_window_get_pointer(event->motion.window, &gx, &gy, NULL);
                                //printf("gx %d  gy %d\n",bx,by, (int)gx, (int)gy);
                        //}

			if (moving>0)             {
				ex=event->button.x_root; ey=event->button.y_root;
				printf("rx %d ry %d   ex %d ey %d\n",ox,oy, ex,ey);
				gtk_widget_set_size_request(frame->box, ex,ey);
				
				c_gtk_widget_post_resize_events( data );
				//gtk_layout_move(l, w, ex -ox,ey-oy);
			}

		} break;
		case GDK_BUTTON_RELEASE: {
			gtk_grab_remove(w);
			moving=0;
		} break;
	}
	return FALSE;
}
//

#endif
