/*************************************************************************
$Id: scrollbar.c 106 2005-08-10 00:17:32Z terminal $

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

#include "../../include/includes.h"

void c_set_scroll( CWidget *w, int bar, int min, int max, int pagesize )
{
#ifdef ENV_CARBON
	ControlHandle scroller;
	
	if ( bar == C_SCROLLING_VERT )
		scroller = w->info->vscroll;
	else
		scroller = w->info->hscroll;
	
	SetControl32BitMinimum( scroller, min );
	SetControl32BitMaximum( scroller, max - pagesize + 1 );
	SetControlViewSize( scroller, pagesize );
	//SetControl32BitValue( w->info->vscroll, display_y );
#endif

#ifdef ENV_WIN32
	SCROLLINFO si;

	si.cbSize = sizeof(SCROLLINFO);
	si.fMask  = 0;
	if ( min >= 0 && max >= 0 )
	{
		si.fMask |= SIF_RANGE;
		si.nMin   = min; 
		si.nMax   = max;
	}
	
	if ( pagesize >= 0 )
	{
		si.fMask |= SIF_PAGE;
		si.nPage  = pagesize;
	}
	
	if ( w->info->flags & C_SCROLLING_GREY_NOT_HIDE )
	{
		if ( max == 0 )
		{
			si.nMax = max = 1;
			EnableScrollBar( w->info->widget, ( bar == C_SCROLLING_VERT ? SB_VERT : SB_HORZ ), ESB_DISABLE_BOTH );
		}
		else
		{
			EnableScrollBar( w->info->widget, ( bar == C_SCROLLING_VERT ? SB_VERT : SB_HORZ ), ESB_ENABLE_BOTH );
		}
	}
	
	SetScrollInfo( w->info->widget, ( bar == C_SCROLLING_VERT ? SB_VERT : SB_HORZ ), &si, true );
	
	if ( min >= 0 )
		w->info->sci.nMin = min;
	if ( max >= 0 )
		w->info->sci.nMax = max;
	if ( pagesize >= 0 )
		w->info->sci.nPage = pagesize;
#endif

#ifdef ENV_GTK
	if ( bar == C_SCROLLING_VERT )
	{
		if ( !( w->info->flags & C_SCROLLING_VERT ) )
			return;
		
		if ( min >= 0 && max >= 0 )
		{
			//gtk_range_set_range( w->info->vscroll, min, max );
			w->info->vsa->lower = min;
			w->info->vsa->upper = max;
		}
		
		if ( pagesize >= 0 )
		{
			//gtk_range_set_increments( w->info->vscroll, 1, pagesize );
			w->info->vsa->page_size = pagesize;
		}
	}
#endif
}

int c_get_scroll_pos( CWidget *w, int bar )
{
#ifdef ENV_CARBON
	ControlHandle scroller;
	int a;
	
	if ( bar == C_SCROLLING_VERT )
		scroller = w->info->vscroll;
	else
		scroller = w->info->hscroll;
	
	a = GetControl32BitValue( scroller );
	
	return a;
#endif

#ifdef ENV_WIN32
/*	SCROLLINFO si;

	si.cbSize = sizeof(si);
	si.fMask  = SIF_TRACKPOS;
	
	GetScrollInfo( w->info->widget, ( bar == C_SCROLLING_VERT ? SB_VERT : SB_HORZ ), &si );
	
	return si.nTrackPos;*/
	return w->info->sci.nTrackPos;
#endif
#ifdef ENV_GTK
	return w->info->vsa->value;
#endif
#ifdef ENV_CARBON
	return 1;
#endif
}

void c_set_scroll_pos( CWidget *w, int bar, int pos )
{
#ifdef ENV_CARBON
	ControlHandle scroller;
	
	if ( bar == C_SCROLLING_VERT )
		scroller = w->info->vscroll;
	else
		scroller = w->info->hscroll;
	
	SetControl32BitValue( scroller, pos );
	
	Draw1Control( w->info->widget );
#endif

#ifdef ENV_WIN32
	SCROLLINFO si;

	si.cbSize = sizeof(si);
	si.fMask  = SIF_TRACKPOS | SIF_POS;
	si.nTrackPos = pos;
	
	SetScrollInfo( w->info->widget, ( bar == C_SCROLLING_VERT ? SB_VERT : SB_HORZ ), &si, true );
	
	w->info->sci.nTrackPos = pos;
	w->info->sci.nPos = pos;
#endif
	
#ifdef ENV_GTK
	if ( bar == C_SCROLLING_VERT )
	{
		if ( !( w->info->flags & C_SCROLLING_VERT ) )
			return;
		
		w->info->vsa->value = pos;
		gtk_range_set_adjustment( w->info->vscroll, w->info->vsa );
		/*gtk_range_set_value( w->info->vscroll, pos );
		gtk_adjustment_set_value( w->info->vsa, pos );*/
	}
#endif
}

void c_scroll_by( CWidget *w, int bar, int by )
{
#ifdef ENV_WIN32
	SCROLLINFO si;
	int pos;
	
	si.cbSize = sizeof( si );
	si.fMask  = SIF_ALL;
	GetScrollInfo( w->info->widget, ( bar == C_SCROLLING_VERT ? SB_VERT : SB_HORZ ), &si );
	
	pos = w->info->sci.nTrackPos;
	pos += by; //si.nPage * dir;
	si.nPos = pos;
	
	SetScrollInfo( w->info->widget, ( bar == C_SCROLLING_VERT ? SB_VERT : SB_HORZ ), &si, false );
	GetScrollInfo( w->info->widget, ( bar == C_SCROLLING_VERT ? SB_VERT : SB_HORZ ), &si );
	
	w->info->sci.nTrackPos = w->info->sci.nPos = si.nPos;
	
	c_send_event_now( w, C_EVENT_UPDATE, 0 );
#endif
}

void c_scroll_page( CWidget *w, int bar, int dir )
{
#ifdef ENV_WIN32
	c_scroll_by( w, bar, w->info->sci.nPage * dir );
#endif
}

