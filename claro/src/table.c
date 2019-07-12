/*************************************************************************
$Id: table.c 106 2005-08-10 00:17:32Z terminal $

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

void c_tbl_set_notify( ClaroTable *tbl, void (*notify)( int msg, struct c_tbl *table, ClaroTableRow *row, ClaroTableCell *cell ) )
{
	tbl->notify = notify;
}

void c_tbl_notify( ClaroTable *tbl, int what, ClaroTableRow *row, ClaroTableCell *cell )
{
	if ( tbl->notify == 0 )
		return;
	
	(*tbl->notify)( what, tbl, row, cell );
}

void c_tbl_reindex( ClaroTable *tbl )
{
	ClaroTableRow *row;
	int a;
	
	if ( tbl->lookup != 0 )
		free( tbl->lookup );
	
	tbl->lookup = (ClaroTableRow **)malloc( sizeof( ClaroTableRow * ) * tbl->rows );
	
	for ( row = tbl->row_head, a = 0; row != NULL; row = row->next, a++ )
	{
		tbl->lookup[a] = row;
		row->pos = a;
	}
}

ClaroTable *c_tbl_create( int cols )
{
	ClaroTable *tbl;
	
	tbl = (ClaroTable *)malloc( sizeof( ClaroTable ) );
	
	if ( !tbl )
		return 0;
	
	memset( tbl, 0, sizeof( ClaroTable ) );
	
	tbl->rows = 0;
	tbl->cols = cols;
	
	return tbl;
}

void c_tbl_empty( ClaroTable *tbl )
{
	while ( tbl->rows > 0 )
		c_tbl_delete_row( tbl, 0 );
}

ClaroTableCell *c_tbl_get_cell( ClaroTable *tbl, int row, int col )
{
	if ( row >= tbl->rows )
	{
		printf( "Hmm. Table row requested beyond array bounds.\n" );
		return 0;
	}
	//c_tbl_reindex( tbl );
	return &tbl->lookup[row]->cell[col];
}

void c_tbl_delete_row( ClaroTable *tbl, int rnum )
{
	ClaroTableRow *row;
	int a;
	
	if ( tbl->rows <= 0 || tbl->rows <= rnum )
		return;
	
	row = tbl->lookup[rnum];
	
	if ( row->prev != 0 )
		row->prev->next = row->next;
	
	if ( row->next != 0 )
		row->next->prev = row->prev;
	
	if ( row == tbl->row_head )
		tbl->row_head = row->next;
	
	if ( row == tbl->row_curr )
		tbl->row_curr = row->prev;
	
	tbl->rows--;
	
	c_tbl_reindex( tbl );
	
	c_tbl_notify( tbl, C_TABLE_NOTIFY_REMOVE_ROW, row, 0 );
	
	for ( a = 0; a < tbl->cols; a++ )
	{
		if ( row->cell[a].free_on_delete == 1 )
			free( row->cell[a].data );
	}
	
	free( row->cell );
	free( row );
}

int c_tbl_move_row( ClaroTable *tbl, int rnum, int pos )
{
	ClaroTableRow *row, *target;
	
	if ( tbl->rows <= 0 || tbl->rows <= rnum )
		return -1;
	
	if ( tbl->rows <= pos )
		pos = tbl->rows-1; // can't go further than this. 0 rows -> 0, 1 row -> 1
	
	row = tbl->lookup[rnum];
	
	if ( pos == row->pos )
	{
		return pos; // can't move it to the same place :)
	}
	
	// first we'll remove it from the linked list and patch everything up as if deleting
	
	if ( row->prev != 0 )
		row->prev->next = row->next;
	
	if ( row->next != 0 )
		row->next->prev = row->prev;
	
	if ( row == tbl->row_head )
		tbl->row_head = row->next;
	
	if ( row == tbl->row_curr )
		tbl->row_curr = row->prev;
	
	c_tbl_reindex( tbl );
	
	if ( pos < 0 )
		target = 0;
	else
	{
		if ( pos+1 >= tbl->rows )
			target = 0;
		else
			target = tbl->lookup[pos];
	}
	
	// now we need to insert our row before target
	
	row->prev = row->next = 0;
	row->pos = -1;
	
	if ( target == 0 )
	{
		// inserting at the end of the list
		if ( tbl->row_curr == 0 )
		{
			tbl->row_head = tbl->row_curr = row;
			
			goto mover_end_now;
		}
		
		row->prev = tbl->row_curr;
		tbl->row_curr->next = row;
		
		tbl->row_curr = row;
		
		goto mover_end_now;
	}
	
	row->prev = target->prev;
	row->next = target;
	if ( target->prev != 0 )
		target->prev->next = row;
	target->prev = row;
	
	if ( target == tbl->row_head )
		tbl->row_head = row;
	
	mover_end_now:
	
	c_tbl_reindex( tbl );
	
	c_tbl_notify( tbl, C_TABLE_NOTIFY_MOVE_ROW, row, (ClaroTableCell *)rnum );
	
	return pos;
}

ClaroTableRow *c_tbl_insert_row( ClaroTable *tbl, int pos )
{
	ClaroTableRow *row, *target;
	
	if ( tbl->rows < pos )
		pos = tbl->rows; // can't go further than this. 0 rows -> 0, 1 row -> 1
	
	row = (ClaroTableRow *)malloc( sizeof( ClaroTableRow ) );
	
	if ( !row )
		return 0;
	
	memset( row, 0, sizeof( ClaroTableRow ) );
	
	row->cell = (ClaroTableCell *)malloc( sizeof( ClaroTableCell ) * tbl->cols );
	memset( row->cell, 0, sizeof( ClaroTableCell ) * tbl->cols );
	row->pos = pos;
	tbl->rows++;
	
	if ( tbl->row_head == 0 || tbl->row_curr == 0 )
	{
		// empty, so insert at the beginning.
		tbl->row_head = tbl->row_curr = row;
		
		goto insert_end_now;
	}
	
	if ( pos > 0 )
	{
		// what's the target?
		if ( pos == tbl->rows )
			target = tbl->row_curr;
		else
			target = tbl->lookup[pos-1];
		
		// attach it to the target
		
		row->prev = target;
		row->next = target->next;
		if ( row->next != 0 )
			row->next->prev = row;
		target->next = row;
		
		if ( target == tbl->row_curr )
			tbl->row_curr = row;
	}
	else
	{
		target = tbl->row_head;
		row->next = target;
		target->prev = row;
		
		tbl->row_head = row;
	}
	
	insert_end_now:
	
	c_tbl_reindex( tbl );
	
	c_tbl_notify( tbl, C_TABLE_NOTIFY_INSERT_ROW, row, 0 );
	
	return row;
}

void c_tbl_set_cell_data( ClaroTable *tbl, int row, int col, void *data, int freeme )
{
	ClaroTableCell *cell;
	
	cell = c_tbl_get_cell( tbl, row, col );
	
	if ( cell->free_on_delete == 1 )
	{
		free( cell->data );
	}
	
	cell->data = data;
	cell->free_on_delete = freeme;
	
	c_tbl_notify( tbl, C_TABLE_NOTIFY_CHANGE_CELL, tbl->lookup[row], cell );
}

//
