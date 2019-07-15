/*************************************************************************
$Id: includes.h 150 2005-08-10 01:03:47Z terminal $

Bersirc - A cross platform IRC client utilizing the Claro GUI Toolkit.
Copyright (C) 2004-2005 Theo P. Julienne and Nicholas S. Copeland

This application is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This application is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this application; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>

#ifdef ENV_GTK
#include <errno.h>
#endif

#ifdef ENV_WIN32
#include <shlobj.h>

#ifndef SHGFP_TYPE_CURRENT
// MingW doesn't currently define this one
#define SHGFP_TYPE_CURRENT 0
#endif

#endif

#include "version.h"

#include <claro.h>
#include "btextview.h"
#include "net/socket.h"
#include "dcc.h"
#include "xml/xml.h"
#include "irc.h"
#include "irc_cmd.h"
#include "irc_msg.h"
#include "lang.h"
#include "profile.h"
#include "netbrowser.h"
#include "connectwin.h"
#include "taskbar.h"

#include "options.h"

#include "configdir.h"

#include "plugins.h"

#include "dccwin.h"

#include "urlwin.h"

#include "joinwin.h"

#include "aboutwin.h"

#include "autowin.h"
