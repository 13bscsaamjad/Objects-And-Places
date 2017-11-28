all:		run

lex.yy.c:	lex.l
		lex lex.l

y.tab.c:	parse.y		
		yacc -d parse.y

run:		lex.yy.c y.tab.c
		cc lex.yy.c y.tab.c -o start
