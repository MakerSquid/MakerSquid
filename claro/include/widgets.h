/*************************************************************************
$Id: widgets.h 119 2005-11-02 22:02:49Z terminal $

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

#ifndef _WIDGETS_H
#define _WIDGETS_H

#ifdef ENV_GTK
gint c_gtk_widget_click_handler( GtkWidget *widget, GdkEventButton *e, CWidget *w );
gint c_gtk_widget_motion_handler( GtkWidget *widget, GdkEventMotion *e, CWidget *w );
void c_windowspace_resized_handler( GtkWidget *widget, GtkAllocation *allocation, CWidget *w );
gint c_window_resized_handler( GtkWidget *widget, GdkEventConfigure *event, CWidget *w );
extern CWidget *current_child; 
#endif

/*** Some special info for widgets ***/

// maximum size for text in a textbox.
//  don't set this too big, every textbox
//  has this amount allocated!!
#ifndef CLARO_TEXTBOX_MAXIMUM
#define CLARO_TEXTBOX_MAXIMUM 0xFFFF
#endif

// only used on ENV_WIN32, specifies the
//  padding around the text in a pushbutton
//  when claro-automated sizes are used.
#ifndef CLARO_BUTTON_PADDING
#define CLARO_BUTTON_PADDING 5
#endif

/*** ***/

void c_widget_move( CWidget *wg, int x, int y, int w, int h );
void c_widget_move_info( CWidget *wg, int x, int y, int w, int h );
int c_widget_width( CWidget *w );
int c_widget_height( CWidget *w );
void c_widget_focus( CWidget *wg );
void c_widget_close( CWidget *w );
void c_widget_enable( CWidget *w );
void c_widget_disable( CWidget *w );
void c_widget_hide( CWidget *w );
void c_widget_show( CWidget *w );
void c_widget_minimize( CWidget *w );
void c_widget_maximize( CWidget *w );
void c_widget_restore( CWidget *w );
int c_widget_screen_offset_x( CWidget *w );
int c_widget_screen_offset_y( CWidget *w );
CWidget *c_find_nonaligner_parent( CWidget *w );
void c_set_widget_local_cursor_pos( CWidget *w, int x, int y );

/*** ***/

void c_widget_install( CWidget *w );

/*** Widget definitions ***/

#define CLARO_WIDGET_APPLICATION	0x00
#define CLARO_WIDGET_WINDOW			0x01
#define CLARO_WIDGET_BUTTON			0x02
#define CLARO_WIDGET_TEXTBOX		0x03
#define CLARO_WIDGET_LABEL			0x04
#define CLARO_WIDGET_PROGRESSBAR	0x05
#define CLARO_WIDGET_RADIOGROUP		0x06
#define CLARO_WIDGET_RADIOBUTTON	0x07
#define CLARO_WIDGET_STATUSBAR		0x08
#define CLARO_WIDGET_CANVAS			0x09
#define CLARO_WIDGET_MENUBAR		0x0A
#define CLARO_WIDGET_WORKSPACE		0x0B
#define CLARO_WIDGET_ALIGNER		0x0C
#define CLARO_WIDGET_LISTBOX		0x0D
#define CLARO_WIDGET_TOOLBAR		0x0E
#define CLARO_WIDGET_GROUPBOX		0x0F
#define CLARO_WIDGET_CHECKBOX		0x10
#define CLARO_WIDGET_DROPDOWN		0x11
#define CLARO_WIDGET_SYSTRAYICON	0x12
#define CLARO_WIDGET_CHOOSEFONT		0x13
#define CLARO_WIDGET_CHOOSECOLOR	0x14
#define CLARO_WIDGET_LISTVIEW		0x15
#define CLARO_WIDGET_OPENGL			0x16
#define CLARO_WIDGET_CHOOSEFILE		0x17
#define CLARO_WIDGET_IMAGE			0x18

#define CLARO_WIDGET_DEFINITION \
char *c_widget_type_names[] = { \
	"Application", \
	"Window", \
	"Button", \
	"TextBox", \
	"Label", \
	"ProgressBar", \
	"RadioGroup", \
	"RadioButton", \
	"StatusBar", \
	"Canvas", \
	"MenuBar", \
	"Workspace", \
	"Aligner", \
	"ListBox", \
	"ToolBar", \
	"GroupBox", \
	"CheckBox", \
	"DropDown", \
	"SysTrayIcon", \
	"ChooseFont", \
	"ChooseColor", \
	"ListView", \
	"OpenGL", \
	"ChooseFile", \
	"Image", \
};

extern char *c_widget_type_names[];

#define CLARO_WIDGET_NAME(type) c_widget_type_names[type]

// 0x00
CWidget *c_new_application( int flags );

// 0x01
CWidget *c_new_window( CWidget *parent, char *title, int width, int height, int flags );
void c_window_set_icon( CWidget *w, ClaroIcon *icon );
void c_window_settitle( CWidget *w, char *title );
void c_window_flash( CWidget *w, int flags, int times );

// 0x02
CWidget *c_new_pushbutton( CWidget *parent, char *text, int x, int y, int width, int height, int flags );
void c_pushbutton_settext( CWidget *w, char *text );

// 0x03
CWidget *c_new_text( CWidget *parent, char *text, int x, int y, int width, int height, int flags );
void c_text_settext( CWidget *w, char *text );
void c_text_setsel( CWidget *w, int start, int end );

// 0x04
CWidget *c_new_label( CWidget *parent, char *text, int x, int y, int width, int height, int flags );
void c_label_settext( CWidget *who, char *text );

// 0x05
CWidget *c_new_progress( CWidget *parent, float pos, int x, int y, int width, int height, int flags );
void c_progress_set_value( CWidget *prog, float pos );
int c_progress_get_value( CWidget *prog );

// 0x06
CWidget *c_new_radiogroup( CWidget *parent, int x, int y, int flags );
int c_radiogroup_get_value( CWidget *group );

// 0x07
CWidget *c_new_radiobutton( CWidget *parent, char *text, int opval, int x, int y, int width, int height, int flags );

// 0x08
CWidget *c_new_statusbar( CWidget *parent, char *text, int flags );

// 0x09
CWidget *c_new_canvas( CWidget *parent, int x, int y, int width, int height, int flags );
void c_canvas_invalid( CWidget *w );

// 0x0A
CWidget *c_new_menubar( CWidget *parent, int flags );
// see below

// 0x0B
CWidget *c_new_workspace( CWidget *parent, int x, int y, int width, int height, int flags );
CWidget *c_workspace_get_active( CWidget *w );
void c_workspace_dock( CWidget *ws, CWidget *win, int pos );
void c_workspace_tile( CWidget *w, int dir );
void c_workspace_cascade( CWidget *w );

// 0x0C
CWidget *c_new_aligner( CWidget *parent, int flags );
void c_aligner_set_stretchable_child( CWidget *me, CWidget *child );

// 0x0D
CWidget *c_new_listbox( CWidget *parent, int x, int y, int width, int height, int flags );
void c_listbox_attach_table( CWidget *w, ClaroTable *tbl, int cell );
// DEPRECATED
int c_listbox_additem_at( CWidget *w, char *text, int pos );
int c_listbox_additem( CWidget *w, char *text );
void c_listbox_delitem( CWidget *w, int item );
void c_listbox_clear( CWidget *w );
int c_listbox_selected( CWidget *w );
void c_listbox_set_select( CWidget *w, int a );
int c_listbox_get_item_pos( CWidget *w, int item );
int c_listbox_get_item_count( CWidget *w );
// see below

// 0x0E
CWidget *c_new_toolbar( CWidget *parent, int flags );

// 0x0F
CWidget *c_new_groupbox( CWidget *parent, char *text, int x, int y, int width, int height, int flags );
void c_groupbox_settext( CWidget *who, char *text );

// 0x10
CWidget *c_new_checkbox( CWidget *parent, char *text, int x, int y, int width, int height, int flags );
void c_checkbox_checked( CWidget *w, int checked );

// 0x11
CWidget *c_new_dropdown( CWidget *parent, int x, int y, int width, int height, int flags );
int c_dropdown_additem( CWidget *w, char *text );
void c_dropdown_delitem( CWidget *w, int item );
void c_dropdown_clear( CWidget *w );
int c_dropdown_selected( CWidget *w );
void c_dropdown_select_item( CWidget *w, int item );

// 0x12
CWidget *c_new_systrayicon( CWidget *parent, char *tooltip, ClaroIcon *icon, int flags );
#define C_WM_SYSTRAYICON_ACTION (WM_USER + 1024)

// 0x13
CWidget *c_new_choosefont( CWidget *parent );
int c_choosefont_display( CWidget *w );
void c_choosefont_set_font_face( CWidget *w, char *face );
void c_choosefont_set_font_size( CWidget *w, int size );
int c_choosefont_get_font_size( CWidget *w );
char *c_choosefont_get_font_face( CWidget *w );

// 0x14

// 0x15
CWidget *c_new_listview( CWidget *parent, int x, int y, int width, int height, int flags );
void c_listview_attach_table( CWidget *w, ClaroTable *tbl );
void c_listview_add_table_column( CWidget *w, char *title, int table_col, int dest_col );
int c_listview_selected( CWidget *w );

// 0x16
CWidget *c_new_opengl( CWidget *parent, int x, int y, int width, int height, int flags );
void c_opengl_flip( CWidget *w );
void c_opengl_activate( CWidget *w );

// 0x17
CWidget *c_new_choosefile( CWidget *parent );
void c_choosefile_set_filter( CWidget *w, char *filter );
int c_choosefile_open( CWidget *w );
int c_choosefile_save( CWidget *w );
char *c_choosefile_get_filename( CWidget *w );

// 0x18
CWidget *c_new_image( CWidget *parent, char *filename, int x, int y, int width, int height, int flags );

/* Application Info */

typedef struct
{
	CWidgetInfo info;
} CApplicationWidgetInfo;

/* Window Info */

typedef struct
{
	CWidgetInfo info;
	
	char title[1024];
	
	ClaroIcon *icon;
	
	int dock_pos;
	CWidget *dock_helpers[2];

	CNativeWidget statusbar;
	CNativeWidget menubar;
	
#ifdef ENV_WIN32
	CNativeWidget clientwin;
	WNDPROC w32_window_proc; // the system proc for the mdi client
	
	CNativeWidget rebar;
	REBARBANDINFO rebar_info;
#endif
#ifdef ENV_GTK
	Frame *frame;
	CNativeWidget win;
	CNativeWidget vbox;
	CNativeWidget vbox2;
	int focused; 
#endif
#ifdef ENV_CARBON
	int ws_order_num;
	ControlRef ws_pcontrol;
#endif

	int minsize_x, minsize_y;
	int maxsize_x, maxsize_y;
	
	CWidget *workspace;
} CWindowWidgetInfo;

/* Button Info */

typedef struct
{
	CWidgetInfo info;
	
	char *text;
} CButtonWidgetInfo;

/* TextBox Info */

typedef struct
{
	CWidgetInfo info;
	
	char *text;
} CTextBoxWidgetInfo;

/* Label Info */

typedef struct
{
	CWidgetInfo info;
	
	char *text;
} CLabelWidgetInfo;

/* Progress Bar Info */

typedef struct
{
	CWidgetInfo info;
	
	float position;
} CProgressBarWidgetInfo;

/* Radio Group Info */

typedef struct
{
	CWidgetInfo info;

#ifdef ENV_GTK
	CNativeWidget lastitem;
#endif

	int value;
} CRadioGroupWidgetInfo;

/* Radio Button Info */

typedef struct
{
	CWidgetInfo info;
	
	char *text;
	int val;
} CRadioButtonWidgetInfo;

/* Status Bar Info */

typedef struct
{
	CWidgetInfo info;
	
	char *text;
} CStatusBarWidgetInfo;

/* Canvas Info */

typedef struct
{
	CWidgetInfo info;
	
	int valid;

#ifdef ENV_WIN32
	// double buffering
	HDC hdcMem;
	HBITMAP hbmMem;
	HANDLE hOld;
	
	PAINTSTRUCT ps;
	HDC hdc;
	
	int buff_w, buff_h, buff;
#endif
#ifdef ENV_GTK
	GdkPixmap *pm;
	GdkGC *gc;
	GtkWidget *gimg;
#endif
} CCanvasWidgetInfo;

/* Menu Bar Info */

typedef struct cmitem
{
	int id;
	
	CWidget *widget;
	
	char *text;
	ClaroIcon *icon;
	
	void *appdata;
	
	// sub menu items
	int hassubs;
	struct cmitem *items;
#ifdef ENV_WIN32
	// save our HMENU
	HMENU menu;
#endif
#ifdef ENV_GTK
	GtkWidget *menu;
	GtkWidget *me;
#endif
#ifdef ENV_CARBON
	MenuRef menu;
	MenuItemIndex index;
#endif

	void (*onclick)( );
	
	struct cmitem *parent;
	
	struct cmitem *next;
} CMenuItem;

typedef struct
{
	CWidgetInfo info;
		
	CMenuItem menubar;
} CMenuBarWidgetInfo;

// 0x0A
CMenuItem *c_menubar_add_item_text( CWidget *m, CMenuItem *p, char *text );
void c_menubar_attach( CMenuItem *i, void (*onclick)( CMenuItem *i ) );
void c_menubar_set_item_icon( CWidget *w, CMenuItem *i, ClaroIcon *icon );
CMenuItem *c_menubar_add_item_text_icon( CWidget *m, CMenuItem *p, char *text, ClaroIcon *icon );
CMenuItem *c_menubar_add_separator( CWidget *m, CMenuItem *p );
void c_menubar_disable_item( CWidget *m, CMenuItem *i );
void c_menubar_enable_item( CWidget *m, CMenuItem *i );
void c_menubar_popup( CWidget *w, int x, int y );

/* Workspace Info */

typedef struct
{
	CWidgetInfo info;
	
#ifdef ENV_WIN32
	CNativeWidget clientwin;
#endif
#ifdef ENV_GTK
	CNativeWidget win;                      // gtkwindow -- top level
	CNativeWidget clientwin;        // gtklayout -- holds event boxes which contains self constructed mdi child
#endif
#ifdef ENV_CARBON
	CWidget *active;
	int ws_childnum;
#endif

} CWorkspaceWidgetInfo;

/* Aligner Info */

typedef struct
{
	CWidgetInfo info;
	
	CWidget *stretchchild;
} CAlignerWidgetInfo;

/* Listbox Info */

typedef struct clbitem
{
	int id;
	
	char *text;
	
#ifdef ENV_WIN32
	int winid;
#endif
	
	struct clbitem *next;
} CListBoxItem;

// 
CListBoxItem *c_listbox_get_item( CWidget *w, int item );

typedef struct
{
	CWidgetInfo info;
	
	/*CListBoxItem *items;
	CListBoxItem *icurr;
	
	CListBoxItem *selected;*/
	
	ClaroTableRow *selected;
	int selitemid;
	
	ClaroTable *table;
	int visible_cell;
	
	int count;
} CListBoxWidgetInfo;

/* ToolBar Info */

typedef struct ctitem
{
	int id;
	
	CWidget *widget;
	
	ClaroIcon *icon;
#ifdef ENV_WIN32
	int win_img_id;
#endif
	
	// sub menu items
	int hassubs;
	CMenuItem *menu;
	
	void *appdata;
	
	char tooltip[512];

	void (*onclick)( struct ctitem *i );
	
	struct ctitem *next;
} CToolItem;

typedef struct
{
	CWidgetInfo info;
	
	CToolItem *items;
} CToolBarWidgetInfo;

// 0x0E
CToolItem *c_toolbar_add_item( CWidget *m, ClaroIcon *icon, CMenuItem *menu );
void c_toolbar_attach( CToolItem *i, void (*onclick)() );

/* GroupBox Info */

typedef struct
{
	CWidgetInfo info;
	
#ifdef ENV_CARBON
	ControlRef pcontrol;
#endif
	
	char *text;
} CGroupBoxWidgetInfo;

/* CheckBox Info */

typedef struct
{
	CWidgetInfo info;
	
	int checked;
	char *text;
} CCheckBoxWidgetInfo;

/* Dropdown Info */

typedef struct cdditem
{
	int id;
	
	char *text;
	
#ifdef ENV_WIN32
	int winid;
#endif
	
	struct cdditem *next;
} CDropDownItem;

typedef struct
{
	CWidgetInfo info;
	
	CDropDownItem *items;
	CDropDownItem *icurr;
	
	CDropDownItem *selected;
	int selitemid;
	
	int count;
} CDropDownWidgetInfo;

/* SysTrayIcon Info */

typedef struct
{
	CWidgetInfo info;
	
	char *tooltip;
	
	int id;
	ClaroIcon *icon;
} CSysTrayIconWidgetInfo;

/* ChooseFont Info */

typedef struct
{
	CWidgetInfo info;
	
#ifdef ENV_WIN32
	CHOOSEFONT wcfd;
	LOGFONT wlf;
#endif
} CChooseFontWidgetInfo;

/* ChooseColor Info */

typedef struct
{
	CWidgetInfo info;
	
#ifdef ENV_WIN32
	CHOOSECOLOR wccd;
#endif
} CChooseColorWidgetInfo;

/* ListView Info */

typedef struct
{
	char *title;
	
	int table_cell;
	int listview_cell;
} CListViewCellLink;

typedef struct
{
	CWidgetInfo info;
	
	int selected;
	int selitemid;
	
	ClaroTable *table;
	
	CListViewCellLink *columns;
	int col_num;
	
	int count;
} CListViewWidgetInfo;

/* OpenGL Info */

typedef struct
{
	CWidgetInfo info;
	
#ifdef ENV_WIN32
	HDC dc;
	HGLRC hrc;
#endif
} COpenGLWidgetInfo;

/* ChooseFile Info */

typedef struct
{
	CWidgetInfo info;
	
#ifdef ENV_WIN32
	OPENFILENAME ofn;
#endif
} CChooseFileWidgetInfo;

/* Image Info */

typedef struct
{
	CWidgetInfo info;
	
#ifdef ENV_WIN32
	HANDLE im;
#endif
} CImageWidgetInfo;

#endif
