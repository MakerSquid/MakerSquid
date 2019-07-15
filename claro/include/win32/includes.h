/*************************************************************************
$Id: includes.h 86 2005-07-30 23:17:03Z terminal $

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

#ifndef _WIN32_INCLUDES_H
#define _WIN32_INCLUDES_H

#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x501
#endif

#ifndef _WIN32_IE
#define _WIN32_IE 0x0600
#endif

#ifndef WINVER
#define WINVER 0x0500
#endif

#include <windows.h>
#include <commctrl.h>
/*
// MinGW doesn't know this one (yet)
#ifndef NIF_INFO_DISABLED_FOR_NOW

#if (_WIN32_IE >= 0x0500)
#define NIF_STATE       0x00000008
#define NIF_INFO        0x00000010
#endif
#if (_WIN32_IE >= 0x600)
#define NIF_GUID        0x00000020
#endif

typedef struct _NOTIFYICONDATA {
    DWORD cbSize;
    HWND hWnd;
    UINT uID;
    UINT uFlags;
    UINT uCallbackMessage;
    HICON hIcon;
    TCHAR szTip[64];
    DWORD dwState;
    DWORD dwStateMask;
    TCHAR szInfo[256];
    union {
        UINT uTimeout;
        UINT uVersion;
    };
    TCHAR szInfoTitle[64];
    DWORD dwInfoFlags;
    GUID guidItem;
} CLARO_NOTIFYICONDATA, *CLARO_PNOTIFYICONDATA;
#else
#define CLARO_NOTIFYICONDATA NOTIFYICONDATA
#endif
*/

#ifdef ENV_OPENGL
#include <windows.h>
#include <windowsx.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glext.h>
#endif

#ifdef ENV_WIN32
//d [internal] WIN32 window X border size (both sides)
#define C_W32_TOTALXOFFSET (GetSystemMetrics( SM_CXFIXEDFRAME )*2)
//d [internal] WIN32 window Y border size (both sides)
#define C_W32_TOTALYOFFSET_NOCAP GetSystemMetrics( SM_CYFIXEDFRAME )*2
//d [internal] WIN32 window Y border size + caption size
#define C_W32_TOTALYOFFSET (C_W32_TOTALYOFFSET_NOCAP + GetSystemMetrics( SM_CYCAPTION ))
#endif

#endif
