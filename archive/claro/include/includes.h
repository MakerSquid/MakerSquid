/*************************************************************************
$Id: includes.h 107 2005-08-10 00:26:55Z terminal $

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

#ifndef _INCLUDES_H
#define _INCLUDES_H

// if using MSVC and no env set, default to win32
#if defined(_MSC_VER) && !defined(ENV_WIN32)  && !defined(ENV_GTK) && !defined(ENV_CARBON)
#define ENV_WIN32
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <math.h>

#ifdef ENV_WIN32
#include "win32/includes.h"
#endif

#ifdef ENV_GTK
#include "gtk/includes.h"
#endif

#ifdef ENV_CARBON
#include "osx/includes.h"
#endif

#include "table.h"

#include "events.h"
#include "input.h"
#include "dialog.h"
#include "claro.h"
#include "flags.h"
#include "font.h"
#include "scrollbar.h"
#include "system.h"
#include "image.h"
#include "canvas.h"

// really, last.
#include "widgets.h"

#endif
