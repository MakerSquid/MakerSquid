/*************************************************************************
$Id: flags.h 87 2005-07-31 00:59:32Z terminal $

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

#ifndef _FLAGS_H
#define _FLAGS_H

//d If used when initialising, main loop wont exit when
//d all windows are closed ( by default, it will )
#define C_FLAG_NONDESTRUCTIVENULLCHILD 0x1

//d rawr? :-)
#define C_DONTCARE -1


//d Top-level window, nothing to do with MDI
#define C_TOPLEVEL			0x0001
//d Top-level window with MDI frame ( "client area" - Win32 )
#define C_MDIPARENT			0x0002
//d MDI Child window ( parent should be C_MDIPARENT )
#define C_MDICHILD			0x0004

//d Window stays on top
#define C_TOPMOST			0x0008
//d Window is a dialog (Other windows in thread can't be focused on)
#define C_DIALOG			0x0010
//d Window has no system menu
#define C_NOSYSMENU			0x0020

//d (default) a normal border ( 3d on most OSs )
#define C_BORDER_NORMAL		0x0000
//d No border at all ( not all widgets support this )
#define C_BORDER_NONE		0x0010

//d (default) no scroll bars
#define C_SCROLLING_NONE	0x0100
//d Scroll bars horiz
#define C_SCROLLING_HORIZ	0x0200
//d Scroll bars vertical
#define C_SCROLLING_VERT	0x0400
//d Scroll bars should be disabled when max is set to 0
#define C_SCROLLING_GREY_NOT_HIDE	0x0800

//d (c_window only) Starts window maximised
#define C_START_MAXIMISE	0x0100
//d (c_window only) Starts window minimised
#define C_START_MINIMISE	0x0200
//d (c_window only) Starts window at it's defined size
#define C_START_RESTORE		0x0400
//d (c_window only) - INTERNAL ONLY - Specifies that a statusbar is shown on the window
#define C_WINDOW_HAS_STATUS	0x0800
//d (c_window only) Window is dockable (can be docked to parent workspace)
#define C_WINDOW_CAN_DOCK	0x1000
//d (c_window only) - INTERNAL ONLY - Specifies that a menubar is shown on the window
#define C_WINDOW_HAS_MENUBAR	0x2000
//d (c_window only) Centers the window to it's parent
#define C_WINDOW_CENTER_TO_PARENT 0x4000

//d (workspace docking) Dock window to left
#define C_DOCK_LEFT			0x1
//d (workspace docking) Dock window to right
#define C_DOCK_RIGHT		0x2
//d (workspace docking) Dock window to top
#define C_DOCK_TOP			0x4
//d (workspace docking) Dock window to bottom
#define C_DOCK_BOTTOM		0x8

//d Aligner widget: organise children horizontally
#define C_ALIGNER_HORIZONTAL 0x1000
//d Aligner widget: organise children vertically
#define C_ALIGNER_VERTICAL 0x2000

#define C_WORKSPACE_TILE_VERT 0x0
#define C_WORKSPACE_TILE_HORIZ 0x1


/*
//d Anchor to top. Ignored unless widget is inside aligner widget.
#define C_WIDGET_ANCHOR_TOP	0x1000
//d Anchor to bottom. Ignored unless widget is inside aligner widget.
#define C_WIDGET_ANCHOR_BOTTOM	0x2000
//d Anchor to left. Ignored unless widget is inside aligner widget.
#define C_WIDGET_ANCHOR_LEFT	0x4000
//d Anchor to right. Ignored unless widget is inside aligner widget.
#define C_WIDGET_ANCHOR_RIGHT	0x8000
*/

// and just for those americans out there ;)
//d AmericaniZed; see C_START_MAXIMISE
#define C_START_MAXIMIZE	0x0100
//d AmericaniZed; see C_START_MINIMISE
#define C_START_MINIMIZE	0x0200

//d Popup menu?
#define C_MENU_POPUP 0x0100

//d Passworded Textbox
#define C_TEXTBOX_PASSWORD 0x0100

//d Send keypress events
#define C_WANT_KEYPRESS 0x1000

#endif
