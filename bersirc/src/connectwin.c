/*************************************************************************
$Id: connectwin.c 134 2005-08-06 00:55:06Z terminal $

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

#include "includes.h"

CWidget *ctwin = 0;
int ctwintype = 0;

extern CWidget *mainwin;

extern XMLFile *servers;

// server
CWidget *ct_lbl_servername, *ct_txt_servername;
CWidget *ct_lbl_password, *ct_txt_password;
CWidget *ct_lbl_port, *ct_txt_port;

// network
CWidget *ct_lbl_network, *ct_ddn_network;
CWidget *ct_lbl_server, *ct_ddn_server;

CWidget *ct_cbx_newwin;
CWidget *ct_btn_connect, *ct_btn_cancel;

XMLItem *ct_curr_network_sel;

void b_conto_killed( )
{
	ctwin = 0;
}

void b_ct_srv_txtchanged( CEvent *e, void *data )
{
	char *server=0, *sport=0;
	int port;
	
	server = ((CTextBoxWidgetInfo *)ct_txt_servername->info)->text;
	sport = ((CTextBoxWidgetInfo *)ct_txt_port->info)->text;
	
	port = atoi( sport );
	
	if ( port == 0 || !strcasecmp( server, "" ) )
		c_widget_disable( ct_btn_connect );
	else
		c_widget_enable( ct_btn_connect );
}

void b_ct_connect( CEvent *e, void *data )
{
	char *server=0, *sport=0;
	int port;
	char sbak[1024];
	BServerWindow *sw = 0;
	int newserv;
	XMLItem *xserver;
	char *srvdesc;
	char *text;
	int a;
	
	if ( ctwintype == 0 )
	{
		server = ((CTextBoxWidgetInfo *)ct_txt_servername->info)->text;
		sport = ((CTextBoxWidgetInfo *)ct_txt_port->info)->text;
		
		if ( !strcmp( server, "" ) || !strcmp( sport, "" ) )
			return;
	}
	else
	{
		if ( ((CDropDownWidgetInfo *)ct_ddn_server->info)->selected == 0 )
			return;

		text = ((CDropDownWidgetInfo *)ct_ddn_server->info)->selected->text;
		a = 0;
		
		for ( xserver = ct_curr_network_sel->child_head; xserver != 0; xserver = xserver->next )
		{
			srvdesc = c_xml_attrib_get( xserver, "description" );
			
			if ( srvdesc == 0 )
				continue;
			
			if ( !strcasecmp( srvdesc, text ) )
			{
				server = c_xml_attrib_get( xserver, "name" );
				sport = c_xml_attrib_get( xserver, "ports" );
				
				if ( server == 0 || sport == 0 )
					continue;
				
				// FIXME: port should be figured out from sport..
				// and really each combination should be tried if
				// connection fails.
				sport = "6667";
				
				a = 1;
				
				break;
			}
		}
		
		if ( a == 0 )
			return;
	}
	
	port = atoi( sport );
	
	// do we have an active server?
	sw = b_server_find_active( );
	
	strcpy( sbak, server );

	// new server status...	
	newserv = ((CCheckBoxWidgetInfo *)ct_cbx_newwin->info)->checked;
	
	// disable window
	c_widget_disable( ctwin );
	
	// do we want a new server window?
	if ( newserv == 1 || sw == 0 )
	{
		sw = b_new_server_window( 0 );
	}
	
	if ( ctwintype == 0 )
		strcpy( sw->password, ((CTextBoxWidgetInfo *)ct_txt_password->info)->text );
	else
		strcpy( sw->password, "" );
	b_server_connect( sw, sbak, port );
	
	// close window
	c_widget_close( ctwin );
}

void b_ct_srv_enterpressed( CEvent *e, void *data )
{
	char *server=0, *sport=0;
	int port;
	
	server = ((CTextBoxWidgetInfo *)ct_txt_servername->info)->text;
	sport = ((CTextBoxWidgetInfo *)ct_txt_port->info)->text;
	
	port = atoi( sport );
	
	if ( port == 0 || !strcasecmp( server, "" ) )
		return;
	
	b_ct_connect( e, 0 );
}

void b_ct_cancel( CEvent *e, void *data )
{
	c_widget_close( ctwin );
}

void b_conto_load_nets( )
{
	XMLItem *netlist;
	XMLItem *network;
	char *netname;
	
	if ( servers == 0 )
	{
		servers = c_xml_create( );
		
		if ( !( c_xml_load_file( servers, "xml/servers-default.xml" ) ) )
			return;
	}
	
	netlist = c_xml_get_path( servers, "Bersirc.networklist" );
	
	if ( netlist == 0 )
		return;
	
	for ( network = netlist->child_head; network != 0; network = network->next )
	{
		netname = c_xml_attrib_get( network, "name" );
		c_dropdown_additem( ct_ddn_network, netname );
	}
}

void b_ct_net_selected( CEvent *e, void *data )
{
	char *text;
	XMLItem *netlist;
	XMLItem *network;
	XMLItem *server;
	char *srvdesc;
	char *netname;
	int a = -1, b;
	
	text = ((CDropDownWidgetInfo *)e->caller->info)->selected->text;
	
	netlist = c_xml_get_path( servers, "Bersirc.networklist" );
	
	if ( netlist == 0 )
		return;
	
	for ( network = netlist->child_head; network != 0; network = network->next )
	{
		netname = c_xml_attrib_get( network, "name" );
		
		if ( netname == 0 )
			continue;
			
		if ( !strcasecmp( netname, text ) )
		{
			ct_curr_network_sel = network;
			
			c_dropdown_clear( ct_ddn_server );
			
			for ( server = network->child_head; server != 0; server = server->next )
			{
				srvdesc = c_xml_attrib_get( server, "description" );
				
				if ( srvdesc == 0 )
					continue;
				
				b = c_dropdown_additem( ct_ddn_server, srvdesc );
				
				if ( a == -1 )
					a = b;
			}
			
			c_dropdown_select_item( ct_ddn_server, a );
			
			c_widget_enable( ct_ddn_server );
			//c_widget_disable( ct_btn_connect );
			return;
		}
	}
}

void b_ct_netsrv_selected( CEvent *e, void *data )
{
	char *text;
	
	if ( ((CDropDownWidgetInfo *)e->caller->info)->selected == 0 )
		return;
	
	text = ((CDropDownWidgetInfo *)e->caller->info)->selected->text;
	
	if ( !strcasecmp( text, "" ) )
		return;
	
	c_widget_enable( ct_btn_connect );
	return;
}

void b_open_conto( int type )
{
	int y, yi, w, h, mpos;
	
	w = 350;
	h = (type == 0 ? 155 : 125 );
	yi = 30;
	mpos = 120;
	
	if ( ctwin == 0 )
	{
		ct_lbl_servername = ct_txt_servername = 0;
		ct_lbl_password = ct_txt_password = 0;
		ct_lbl_port = ct_txt_port = 0;
		ct_lbl_network = ct_ddn_network = 0;
		ct_lbl_server = ct_ddn_server = 0;
		ct_cbx_newwin = 0;
		ct_btn_connect = ct_btn_cancel = 0;
		ct_curr_network_sel = 0;
		
		ctwintype = type;
		
		ctwin = c_new_window( mainwin, lang_phrase_quick( (type==0?"connect_to_srv":"connect_to_net") ), w, h, C_DIALOG | C_WINDOW_CENTER_TO_PARENT );
		c_window_set_icon( ctwin, b_icon( (type==0?"connect_inp":"connect") ) );
		c_window_maxsize( ctwin, w, h );
		c_window_minsize( ctwin, w, h );
		c_new_event_handler( ctwin, C_EVENT_DESTROY, b_conto_killed );
		
		y = 10;
		//lang_phrase_quick( "connectwin_" )
		if ( type == 0 )
		{
			ct_lbl_servername = c_new_label( ctwin, lang_phrase_quick( "connectwin_servername" ), 10, y, mpos, -1, 0 );
			ct_txt_servername = c_new_text( ctwin, "", mpos, y, w-mpos-10, -1, 0 );
			c_widget_focus( ct_txt_servername );
			y += 30;
			
			ct_lbl_password = c_new_label( ctwin, lang_phrase_quick( "connectwin_password" ), 10, y, mpos, -1, 0 );
			ct_txt_password = c_new_text( ctwin, "", mpos, y, 140, -1, C_TEXTBOX_PASSWORD );
			y += 30;
			
			ct_lbl_port = c_new_label( ctwin, lang_phrase_quick( "connectwin_port" ), 10, y, mpos, -1, 0 );
			ct_txt_port = c_new_text( ctwin, "6667", mpos, y, 80, -1, 0 );
			y += 30;
			
			c_new_event_handler( ct_txt_servername, C_EVENT_TEXT_ENTER, b_ct_srv_enterpressed );
			c_new_event_handler( ct_txt_port, C_EVENT_TEXT_CHANGED, b_ct_srv_txtchanged );
			c_new_event_handler( ct_txt_servername, C_EVENT_TEXT_CHANGED, b_ct_srv_txtchanged );
		}
		else
		{
			ct_lbl_network = c_new_label( ctwin, lang_phrase_quick( "connectwin_network" ), 10, y, mpos, -1, 0 );
			ct_ddn_network = c_new_dropdown( ctwin, mpos, y, w-mpos-10, 200, 0 );
			c_widget_focus( ct_ddn_network );
			y += 30;
			
			ct_lbl_server = c_new_label( ctwin, lang_phrase_quick( "connectwin_server" ), 10, y, mpos, -1, 0 );
			ct_ddn_server = c_new_dropdown( ctwin, mpos, y, w-mpos-10, 200, 0 );
			c_widget_disable( ct_ddn_server );
			y += 30;
			
			c_new_event_handler( ct_ddn_network, C_EVENT_ITEM_SELECTED, b_ct_net_selected );
			c_new_event_handler( ct_ddn_server, C_EVENT_ITEM_SELECTED, b_ct_netsrv_selected );
		}
		
		ct_cbx_newwin = c_new_checkbox( ctwin, lang_phrase_quick( "connectwin_newwin" ), 10, y, w-40, -1, 0 );
		c_checkbox_checked( ct_cbx_newwin, 1 );
		y += 25;
		
		ct_btn_connect = c_new_pushbutton( ctwin, lang_phrase_quick( "connect" ), w-220, y, 100, -1, 0 );
		c_widget_disable( ct_btn_connect );
		ct_btn_cancel = c_new_pushbutton( ctwin, lang_phrase_quick( "cancel" ), w-110, y, 100, -1, 0 );
		y += 30;
		
		c_new_event_handler( ct_btn_cancel, C_EVENT_BUTTON_PRESS, b_ct_cancel );
		c_new_event_handler( ct_btn_connect, C_EVENT_BUTTON_PRESS, b_ct_connect );
		
		c_new_event_handler( ctwin, C_EVENT_DIALOG_OK, b_ct_connect );
		
		if ( type == 1 )
			b_conto_load_nets( );
	}
	else
	{
		c_widget_focus( ctwin );
	}
}
