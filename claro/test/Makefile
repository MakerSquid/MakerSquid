CLARODIR=/usr/local/claro

CFLAGS=-I$(CLARODIR)/include -DENV_GTK -L$(CLARODIR)/lib -lclarogt `pkg-config --cflags gtk+-2.0` -g3

all: test test1
#	copy $(CLARODIR)\lib\libclarogt.dll .
#	test

test: test1.o
	gcc  -o test test.c $(CFLAGS)
	
test1: test1.o
	gcc  -o test1 test1.c $(CFLAGS) 
	
