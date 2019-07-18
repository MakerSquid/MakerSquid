/*************************************************************************
$Id: events.h 86 2005-07-30 23:17:03Z terminal $

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

#ifndef _EVENTS_H
#define _EVENTS_H

//d Null event, not used
#define C_EVENT_NULL 0
//d Sent when a widget needs to be repainted
#define C_EVENT_DRAW 1
//d Sent when a widget has just been created
#define C_EVENT_CREATE 2
//d Sent just before a widget is invalidated
#define C_EVENT_DESTROY 3
//d Sent when a widget has been resized
#define C_EVENT_RESIZE 4
//d Sent when a widget has been moved
#define C_EVENT_MOVE 5
//d Sent when a button is pressed
#define C_EVENT_BUTTON_PRESS 6
//d Sent when text in a text box has been edited
#define C_EVENT_TEXT_CHANGED 7
//d Sent when one or more widget attributes have changed
#define C_EVENT_UPDATE 8
//d Sending this message to c_application will cause a widget to
//d be destroyed *next* loop, after all other events associated
//d with that widget have been sent.
#define C_EVENT_DELAYED_DESTROY 9
//d Sent after a widget has been created
#define C_EVENT_CREATED 10
//d Sent when a timer has reached run-point
#define C_EVENT_TIMER 11
//d Sent when enter is pressed inside a text box
#define C_EVENT_TEXT_ENTER 12
//d Sent whenever a radiogroup changes (ie, the user selects a radiobutton)
#define C_EVENT_RADIO_CHANGE 13
//d Sent only to the canvas widget, especially for doublebuffer drawing :)
#define C_EVENT_PREDRAW 14
//d Sent when the mouse moves in a widget
#define C_EVENT_MOUSE_MOVE 15
//d Sent when the left mouse button is clicked
#define C_EVENT_MOUSE_LEFT_CLICK 16
//d Sent when the left mouse button is double clicked
#define C_EVENT_MOUSE_LEFT_DBLCLK 17
//d Sent when after a widget has been created ( after native calls )
#define C_EVENT_POSTCREATE 18
//d Sent when a widget gains focus
#define C_EVENT_ONFOCUS 19
//d Sent when a widget's parent resizes
#define C_EVENT_PARENTSIZE 20
//d [internal] Sent when a widget is destroyed. Use this outside of the core and DIE!
#define C_EVENT_INTERNAL_DESTROY 21
//d Sent when a listbox item selection is changed
#define C_EVENT_ITEM_SELECTED 22
//d Sent when enter is pressed in a window with dialog flag
#define C_EVENT_DIALOG_OK 23
//d Sent when the mouse leaves the widget
#define C_EVENT_MOUSE_LEAVE 24
//d Sent when the a letter key is pressed
#define C_EVENT_KEY_PRESS 25
//d Sent when the right mouse button is clicked
#define C_EVENT_MOUSE_RIGHT_CLICK 26
//d Sent when the right mouse button is double clicked
#define C_EVENT_MOUSE_RIGHT_DBLCLK 27
//d Sent when the left mouse button is released
#define C_EVENT_MOUSE_LEFT_RELEASE 28
//d Sent when the right mouse button is released
#define C_EVENT_MOUSE_RIGHT_RELEASE 29
//d Sent when a window is minimized
#define C_EVENT_MINIMIZED 30
//d Sent when a window is maximized
#define C_EVENT_MAXIMIZED 31
//d Sent when a window is resized but not minimized or maximized
#define C_EVENT_RESTORED 32
//d Sent when a mouse wheel rotates over a window
#define C_EVENT_MOUSE_WHEEL 33
//d Sent when the middle mouse button is clicked
#define C_EVENT_MOUSE_MIDDLE_CLICK 34
//d Sent when the middle mouse button is double clicked
#define C_EVENT_MOUSE_MIDDLE_DBLCLK 35
//d Sent when the middle mouse button is released
#define C_EVENT_MOUSE_MIDDLE_RELEASE 36

// rar - up to 65535 event handlers here :p
//d Start ID of user-defined events.
#define C_EVENT_USER_START 0x10000

/* Remember to add these IDs to the lookup function in events.c */

#endif

