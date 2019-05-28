all:
	yacc -d calc2.y
	lex calc2.l
	gcc lex.yy.c y.tab.c -o calc.exe

