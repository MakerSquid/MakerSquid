/*************************************************************************
$Id: scrollbar.h 55 2005-05-09 00:20:13Z terminal $

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

void c_set_scroll( CWidget *w, int bar, int min, int max, int pagesize );
int c_get_scroll_pos( CWidget *w, int bar );
void c_set_scroll_pos( CWidget *w, int bar, int pos );
void c_scroll_page( CWidget *w, int bar, int dir );
void c_scroll_by( CWidget *w, int bar, int by );
