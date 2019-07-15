#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "claro.h"

main() {

	c_init ( "Claro Test Application", 0 );

	CWidget *win;
	CWidget *child;
	int i; 
	win = c_new_window( 0, "Claro Test Window", 400, 400, C_MDIPARENT);

	for (i=0; i<=10; i++) 
		child = c_new_window(win, "mdi child", 300,300,C_MDICHILD);

	return c_mainloop(); 
			
}