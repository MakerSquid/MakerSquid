/*************************************************************************
$Id: input.h 98 2005-08-06 02:32:45Z terminal $

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

#ifndef _INPUT_H
#define _INPUT_H

#ifdef ENV_WIN32

#define CK_A VK_A
#define CK_B VK_B
#define CK_C VK_C
#define CK_D VK_D
#define CK_E VK_E
#define CK_F VK_F
#define CK_G VK_G
#define CK_H VK_H
#define CK_I VK_I
#define CK_J VK_J
#define CK_K VK_K
#define CK_L VK_L
#define CK_M VK_M
#define CK_N VK_N
#define CK_O VK_O
#define CK_P VK_P
#define CK_Q VK_Q
#define CK_R VK_R
#define CK_S VK_S
#define CK_T VK_T
#define CK_U VK_U
#define CK_V VK_V
#define CK_W VK_W
#define CK_X VK_X
#define CK_Y VK_Y
#define CK_Z VK_Z
#define CK_0 VK_0
#define CK_1 VK_1
#define CK_2 VK_2
#define CK_3 VK_3
#define CK_4 VK_4
#define CK_5 VK_5
#define CK_6 VK_6
#define CK_7 VK_7
#define CK_8 VK_8
#define CK_9 VK_9
#define CK_UP VK_UP
#define CK_DOWN VK_DOWN
#define CK_LEFT VK_LEFT
#define CK_RIGHT VK_RIGHT
#define CK_DELETE VK_DELETE
#define CK_ENTER VK_ENTER
#define CK_PAGEUP VK_PRIOR
#define CK_PAGEDOWN VK_NEXT
#define CK_PRIOR VK_PRIOR
#define CK_NEXT VK_NEXT

#else
#ifdef ENV_GTK

#define CK_ENTER 36
#define CK_UP 98
#define CK_DOWN 104
#define CK_PAGEUP 116
#define CK_PAGEDOWN 121
// FIXME: the rest, kthx

#else

#ifdef ENV_CARBON
#define CK_ESCAPE 53
#define CK_DELETE 117
#define CK_END 119
#define CK_HOME 115
#define CK_PAGEUP 116
#define CK_PAGEDOWN 121
#define CK_PRIOR 116
#define CK_NEXT 121
#define CK_F1 122
#define CK_F2 120
#define CK_F3 99
#define CK_F4 118 
#define CK_F5 96
#define CK_F6 97
#define CK_F7 98
#define CK_F8 100
#define CK_F9 75
#define CK_F10 76
#define CK_F11 95
#define CK_F12 111
#define CK_UP 126
#define CK_RIGHT 124
#define CK_LEFT 123
#define CK_DOWN 125
#define CK_SPACE 49
#define CK_RETURN 36

#endif
#endif
#endif

#endif