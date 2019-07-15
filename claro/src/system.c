/*************************************************************************
$Id: system.c 106 2005-08-10 00:17:32Z terminal $

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

#include "../include/includes.h"

void c_open_browser( CWidget *w, char *url )
{
#ifdef ENV_WIN32
	ShellExecute( NULL, "open", url, NULL, NULL, SW_SHOWNORMAL );
#endif
}

int c_clipboard_set_text( CWidget *w, char *text )
{
#ifdef ENV_WIN32
	HGLOBAL hglbCopy;
	LPTSTR lptstrCopy;
	
	if ( !OpenClipboard( w->info->widget ) )
		return 0;
	
	EmptyClipboard( );
	
	hglbCopy = GlobalAlloc( GMEM_MOVEABLE, strlen( text ) + 1 ); 
	
	if (hglbCopy == NULL)
	{
		CloseClipboard(); 
		return 0;
	}
	
	lptstrCopy = GlobalLock( hglbCopy );
	memcpy( lptstrCopy, text, strlen( text ) + 1 );
	GlobalUnlock( hglbCopy );
	
	SetClipboardData( CF_TEXT, hglbCopy );
	
	CloseClipboard( );
	
	return 1;
#endif
}
