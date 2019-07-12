/*
#include <stdio.h>

#include "claro.h"

int main( int argc, char *argv[] )
{
	CWidget *win;
	
	c_init( "Claro Test Application", 0 );
	
	win = c_new_window( 0, "Hello, Claro!", 400, 600, C_TOPLEVEL );
	
	return c_mainloop( );
}
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "claro.h"

CWidget *myprog, *myprog2;
CWidget *label3, *label4;

void texttest( CEvent *e, void *data )
{
	CLabelWidgetInfo *lwi = (CLabelWidgetInfo *)e->caller->info;
	c_label_settext( label4, lwi->text );
}

void buttontest3( CEvent *e, void *data )
{/*
	CWidget *timer = 0;
	int running = 0;
	
	timer = (CWidget *)c_get_event_attrib( e, "user_data" );

	if (timer == 0)
		return;
	
	running = c_get_widget_attrib_int( timer, "running" );
		
	running = 1 - running;
	
	c_set_widget_attrib_int( timer, "running", running );
	
	if(running)
		c_set_widget_attrib_string( e->caller, "text", "Timer is running");
	if(!running)
		c_set_widget_attrib_string( e->caller, "text", "Timer isn't running");
	
	printf("A timer event just occurred!\n");
*/}
/*
void dialogtest( CEvent *e, void *data )
{
	if ( c_get_widget_attrib_int( e->caller, "result" ) != C_USER_YES )
		return;
	
	float pos = ((float)rand()/RAND_MAX);
	
	printf("Pos: %f\n", pos);
	
	c_set_widget_attrib_float( myprog, "position", pos );
}
*/
void resizeevent( CEvent *e, void *data )
{
	;
}

void radtest( CEvent *e, void *data )
{
	int result = c_radiogroup_get_value( e->caller );

	printf("Result: %d\n", result);

	if ( result == 1 )
		c_label_settext( label3, "Want choice?" );
	else if ( result == 2 )
		c_label_settext( label3, "Got choice!" );
	else
		c_label_settext( label3, "Seeing this is BAD! Report bug!" );
}

void entertest( CEvent *e, void *data )
{
	CWidget *textarea = data;
	//char *text = ((CTextBoxWidgetInfo *)e->caller->info)->text; //c_get_widget_attrib_string( e->caller, "text" );
	//c_set_widget_attrib_string( textarea, "text", text );
}

void buttontest( CEvent *e, void *data )
{
	//c_new_handler( c_dialog( c_app(), "Test Dialog", "Randomly update progress bar?", C_DIAG_YESNO, -1, -1 ), C_EVENT_BUTTON_PRESS, dialogtest, 0 );
	c_progress_change( myprog, ((float)rand()/RAND_MAX) );
}

void buttontest2( CEvent *e, void *data )
{
	char t[10];
	
	sprintf(t, "%d", rand() % 9);
	
	//c_set_widget_attrib_string( e->caller, "text", strdup(t) );
	((CButtonWidgetInfo *)e->caller->info)->text = strdup( t );
}

void exitbutton( CEvent *e, void *data )
{
	c_shutdown( );
}

void timertest( CEvent *e, void *data )
{
/*
	float pos = c_get_widget_attrib_float( myprog2, "position" );
	int dir = c_get_widget_attrib_int( myprog2, "dir" );
	
	pos += ( 0.01f * dir );
	
	if ( dir == 1 && pos >= 1.0f )
		dir = -1;
	if ( dir == -1 && pos <= 0.0f )
		dir = 1;
	
	c_set_widget_attrib_float( myprog2, "position", pos );
	c_set_widget_attrib_int( myprog2, "dir", dir );
	
	return;
	
	CWidget *im = 0;

	int impos = 0;
	
	im = (CWidget *)c_get_event_attrib( e, "user_data" );
	
	if (im == 0)
		return;
	
	impos = c_get_widget_attrib_int( im, "x" );
	
	if(impos > 390)
		impos = 10;	
	
	c_set_widget_attrib_int( im, "x", ++impos );
	
	printf("A timer event just occurred!\n");
*/
}

int main( int argc, char **argv )
{
	CWidget *labels[10];
	CWidget *buttons[5];
	CWidget *texts[5];
	CWidget *progress[5];
	CWidget *radgroup;
	CWidget *radbuts[2];
	CWidget *ptimer;
	CWidget *mywin;
	int a, b, c, d, e;
	int tx, sx, sl, bw;
	
	c_init ( "Claro Test Application", 0 );
	
	mywin = c_new_window( 0, "Claro Test Window", 400, 400, 0);
	c_window_minsize( mywin, 400, 400 );
	c_window_maxsize( mywin, 400, 400 );

	c_new_statusbar( mywin, "Ready", 0 );
	
	a = b = c = d = e = 0;
	
	// starting y position
	a = 10;
	
	// x positions
	tx =  40; // for labels
	sx = 150; // for the widgets
	
	// other values
	sl = 400 - sx - tx;
	bw = 20;
	
	// preamble
	labels[b++] = c_new_label( mywin, "Claro supports many standard widgets, such as:", 10, a, -1, -1, 0 );
	a += 30;
	
	// buttons
	labels[b++] = c_new_label( mywin, "Buttons", tx, a, -1, -1, 0 );
	buttons[0] = c_new_pushbutton( mywin, "Update Progress Bar #2", sx, a, sl, -1, 0 );
	a += 30;
	buttons[1] = c_new_pushbutton( mywin, "Close Claro test application", sx, a, sl, -1, 0 );
	a += 30;
	
	// space
	a += bw;
	
	// textbox
	labels[b++] = c_new_label( mywin, "Labels", tx, a, -1, -1, 0 );
	label3 = c_new_label( mywin, "I am linked to the radio buttons ;-)", sx, a, sl, 20, 0 );
	a += 20;
	label4 = c_new_label( mywin, "Type in the text box below :)", sx, a, sl, 20, 0 );
	a += 20;

	// space
	a += bw;
	
	// textbox
	labels[b++] = c_new_label( mywin, "Text boxes", tx, a, -1, -1, 0 );
	texts[0] = c_new_text( mywin, "Type in me, please :-)", sx, a, sl, 20, 0 );
	a += 20;
	
	// space
	a += bw;
	
	// textbox
	labels[b++] = c_new_label( mywin, "Progress Bar", tx, a, -1, -1, 0 );
	progress[0] = c_new_progress( mywin, 0.5f, sx, a, sl, -1, 0 );
	myprog2 = progress[0];
	a += 30;
	progress[1] = c_new_progress( mywin, 0.25f, sx, a, sl, -1, 0 );
	myprog = progress[1];
	a += 30;
	
	// space
	a += bw;
	
	// textbox
	labels[b++] = c_new_label( mywin, "Radio buttons", tx, a, -1, -1, 0 );
	radgroup = c_new_radiogroup( mywin, sx, a, 0 );
	radbuts[0] = c_new_radiobutton( radgroup, "No choice!", 1, sx, a, sl, -1, 0 );
	a += 20;
	radbuts[1] = c_new_radiobutton( radgroup, "1 choice!", 2, sx, a, sl, -1, 0 );
	a += 20;
	
	
	// actions

	// timer to move progress bar up and down
/*	ptimer = c_timer( mywin, 100, 1 );
	c_new_handler( ptimer, C_EVENT_TIMER, timertest, 0  );
*/
	// random progress bar
	srand( time( 0 ) );

	c_new_event_handler( buttons[0], C_EVENT_BUTTON_PRESS, buttontest );
	c_new_event_handler( buttons[1], C_EVENT_BUTTON_PRESS, exitbutton );
	c_new_event_handler( radgroup, C_EVENT_RADIO_CHANGE, radtest );
	c_new_event_handler( texts[0], C_EVENT_TEXT_CHANGED, texttest );
	
	return c_mainloop();
}
