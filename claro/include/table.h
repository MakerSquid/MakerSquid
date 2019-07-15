/*************************************************************************
$Id: table.h 95 2005-08-06 00:04:03Z terminal $

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

#define C_TABLE_NOTIFY_INSERT_ROW 0x01
#define C_TABLE_NOTIFY_REMOVE_ROW 0x02
#define C_TABLE_NOTIFY_MOVE_ROW 0x03
#define C_TABLE_NOTIFY_CHANGE_CELL 0x04

typedef struct
{
	void *data;
	
	int free_on_delete;
} ClaroTableCell;

typedef struct c_tbl_row
{
	int pos;
	
	ClaroTableCell *cell;
	
	struct c_tbl_row *next;
	struct c_tbl_row *prev;
} ClaroTableRow;

typedef struct c_tbl
{
	int rows;
	int cols;
	
	ClaroTableRow *row_head;
	ClaroTableRow *row_curr;
	
	// row pointer lookup
	ClaroTableRow **lookup;
	
	// notify function
	void (*notify)( int msg, struct c_tbl *table, ClaroTableRow *row, ClaroTableCell *cell );
	
	void *ndata;
} ClaroTable;

// funcs
void c_tbl_reindex( ClaroTable *tbl );
ClaroTable *c_tbl_create( int cols );
ClaroTableRow *c_tbl_insert_row( ClaroTable *tbl, int pos );
int c_tbl_move_row( ClaroTable *tbl, int rnum, int pos );
ClaroTableCell *c_tbl_get_cell( ClaroTable *tbl, int row, int col );
void c_tbl_set_cell_data( ClaroTable *tbl, int row, int pos, void *data, int free );
void c_tbl_set_notify( ClaroTable *tbl, void (*notify)( int msg, struct c_tbl *table, ClaroTableRow *row, ClaroTableCell *cell ) );
void c_tbl_empty( ClaroTable *tbl );
void c_tbl_delete_row( ClaroTable *tbl, int rnum );

//
