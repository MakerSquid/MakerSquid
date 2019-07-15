/*************************************************************************
$Id: events.c 106 2005-08-10 00:17:32Z terminal $

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

/* real definitions of queues */
CEvent *c_event_queue = 0;

/* internal function c_init_events callers c_clone_widget
 *
 *desc
 * Initialises an event list /e/ ( blank )
 */
void c_init_events( CEvent **e )
{
	*e = 0;
}

/* public function c_new_event_handler
 *
 *desc
 * Adds an event /id/ handler to widget /w/
 */
CEvent *c_new_event_handler( CWidget *w, int id, void (*handler)(CEvent *, void *) )
{
	CEvent *e;
	
	e = (CEvent *)malloc( sizeof(CEvent) );
	
	if ( e == 0 )
		return 0;
	
//	printf( "HANDLER : %p\n", w );
	
	e->priority = 1.0f; // FIXME: [FEATURE] Use this variable somehow..
	e->id = id;
	e->handler = handler;
	e->caller = w;
	e->data = 0;
	
	// because it's easier, we add handler to front of handlers list.
	
	// our next is the current head
	e->next = w->handlers;
	
	// the "head" is now us
	w->handlers = e;
	
	return e;
}

/* internal function c_queue_event
 *
 *desc
 * Queues event /e/ in the global event queue
 */
void c_queue_event( CEvent *e )
{
	CEvent *last;
	
	e->next = 0;
	
	if ( c_event_queue == 0 )
	{
		c_event_queue = e;
		return;
	}
	
	for ( last = c_event_queue; last->next != 0; last = last->next )
		;
	
	last->next = e;
}

/* public function c_send_event
 *
 *desc
 * Sends event /id/ to widget /w/ ( event queue )
 */
void c_send_event( CWidget *w, int id, void *data )
{
	CEvent *curr;
	CEvent *e;

	for ( curr = w->handlers; curr != 0; curr = curr->next )
	{
		if ( curr->id == id )
		{
			e = (CEvent *)malloc( sizeof(CEvent) );
			memcpy( e, curr, sizeof(CEvent) );
			e->data = data;
			e->caller = w;
			
//			printf( "Sending event %d handler %p\n", id, e->caller );
			
			c_queue_event( e );
			
			return;
		}
	}

#ifdef CLARO_WARNINGS
	printf( "WARNING: [MINOR] Event %d was sent to widget and no handler found.\n", id );
#endif
}

/* public function c_send_event_now
 *
 *desc
 * Sends event /id/ to widget /w/ NOW
 */
int c_send_event_now( CWidget *w, int id, void *data )
{
	CEvent *curr;
	CEvent *e;
	int a;

	for ( curr = w->handlers; curr != 0; curr = curr->next )
	{
		if ( curr->id == id )
		{
			e = (CEvent *)malloc( sizeof(CEvent) );
			memcpy( e, curr, sizeof(CEvent) );
			e->data = data;
			e->caller = w;
			e->proc_cancel = 0;
			
			(*e->handler)( e, e->data );
			
			a = e->proc_cancel;
			
			free( e );
			
			return a;
		}
	}

#ifdef CLARO_WARNINGS
	printf( "WARNING: [MINOR] Event %d was sent to widget and no handler found.\n", id );
#endif

	return -1;
}

/* public function c_send_event_singular
 *
 *desc
 * Sends event /id/ to widget /w/ ( event queue ) only if that event is not already queued.
 */
void c_send_event_singular( CWidget *w, int id, void *data )
{
	CEvent *curr;

	if ( c_event_queue != 0 )
	{
		for ( curr = c_event_queue; curr != 0; curr = curr->next )
		{
			if ( curr->caller == w && curr->id == id )
			{
#ifdef CLARO_WARNINGS
				printf( "HALT on event %d because it's not singular.\n", id );
#endif
				return;
			}
		}
	}
	
	c_send_event( w, id, data );
}

/* internal function c_destroy_events callers c_destroy_widget
 *
 *desc
 * Destroys and frees event list /e/
 */
void c_destroy_events( CEvent *e )
{
	CEvent *curr, *next;
	
	if ( e == 0 )
		return;
	
	for ( curr = e; curr != 0; curr = next )
	{
		next = curr->next;
		
		if ( curr->data != 0 )
			free( curr->data );
			
		free( curr );
	}
}

/* internal function c_destroy_pending
 *
 *desc
 * Destroys and frees events in list /e/ due for widget /w/
 */
void c_destroy_pending( CEvent **e, CWidget *w )
{
	CEvent *curr, *next, *prev;
	
	if ( e == 0 )
		return;
	
	prev = next = 0;
	
	for ( curr = *e; curr != 0; curr = next )
	{
		next = curr->next;
		
		if ( curr->caller == w )
		{
			if ( curr->data != 0 )
				free( curr->data );
			
			if ( *e == curr )
				*e = next;
			
			if ( prev != 0 )
				prev->next = next;
			
			free( curr );
		}
		else
			prev = curr;
	}
}

/* internal function c_find_handler
 *
 *desc
 * Finds handler for event /id/ in event list /h/
 */
CEvent *c_find_handler( unsigned int id, CEvent *h )
{
	CEvent *curr;

//	printf("Looking for handler for %d\n", id);

	for ( curr = h; curr != 0; curr = curr->next )
	{
		if ( curr->id == id )
			return curr;
	}

//	printf("No handler found for %d\n", id);

	return 0;
}

/* internal function c_dispatch_events
 *
 *desc
 * "Dispatches" all events in the queue.
 */
void c_dispatch_events( )
{
	CEvent *curr, *next;
	CEvent *nevt;
	
	CEvent *old_queue;
	
	// allow for those times when events will make more events..
	// without this, you get links to invalid memory etc.
	old_queue = c_event_queue;
	c_event_queue = 0;
	
	for ( curr = old_queue; curr != 0; curr = next )
	{
		// save next
		next = curr->next;
		
		// is it a delay destroy?
		if ( curr->id == C_EVENT_DELAYED_DESTROY )
		{
			// it is, kill it! kill it!
			c_destroy_widget( curr->caller, 1 );
			
			// free event
			free( curr );
			continue;
		}
		
		// run the event
		if ( curr->handler == 0 )
		{
			// GRR. Event seems to have been carelessly sent.
			// We'll have to look up the event handler *LAG*
			
			nevt = c_find_handler( curr->id, curr->caller->handlers );
			
			if ( nevt == 0 )
			{
				// This means an event was sent and we don't handle it.
				// Again, this means it was also sent carelessly.
				// If we're here, someone didn't use c_send_event()! :|
				
				// ignore the bad event
				free( curr );
				continue;
			}
			
			curr->handler = nevt->handler;
			
			if ( curr->handler == 0)
			{
				// If we're here, it means not only was this event sent
				//  "carelessly", but the event doesn't even have an
				//  actual handler function to handle it!! RAWR!
				
				// die, die, die!
				free( curr );
				continue;
			}
		}
		
		// All nice. Either we had a good event or we managed to fix it.
		(*curr->handler)( curr, curr->data );
		
		if ( curr->data != 0 )
			free( curr->data );
		
		// free event
		free( curr );
	}
}
