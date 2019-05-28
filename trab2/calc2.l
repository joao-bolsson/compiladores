    /* calculator #1 */
%{
	#include "y.tab.h"
	#include <stdlib.h>
	void yyerror(char *);
%}

OP_L	[AND|OR|NOT]
OP_A	[-+()=/*\n]

%%

true|TRUE		{	return TRUE;}

false|FALSE		{	return FALSE;}

[a-z]       		{
                		yylval = *yytext - 'a';
                		return VARIABLE;
                	}

[0-9]+      		{
                		yylval = atoi(yytext);
                		return INTEGER;
            		}

{OP_L}|{OP_A}     	{ 	return *yytext; }

[ \t]   		; /* skip whitespace */

.               	yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}
