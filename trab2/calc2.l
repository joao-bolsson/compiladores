    /* calculator #1 */
%{
	#include "y.tab.h"
	#include <stdlib.h>
	void yyerror(char *);
%}

%%

true|TRUE		{	return TRUE;}

false|FALSE		{	return FALSE;}

"and"|"AND"		{	return AND;}

AND|OR|NOT|&		{	return *yytext;}

[-+()=/*\n]	     	{ 	return *yytext; }		

[a-z]       		{
                		yylval = *yytext - 'a';
                		return VARIABLE;
                	}

[0-9]+      		{
                		yylval = atoi(yytext);
                		return INTEGER;
            		}

[ \t]   		; /* skip whitespace */

.               	yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}
