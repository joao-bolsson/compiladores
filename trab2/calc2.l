    /* calculator #1 */
%{
	#include "y.tab.h"
	#include <stdlib.h>
	void yyerror(char *);
%}

D			[0-9]

%%

true|TRUE		{	return TRUE;		}

false|FALSE		{	return FALSE;		}

"and"|"AND"		{	return AND;		}

"or"|"OR"		{	return OR;		}

"not"|"NOT"		{	return NOT;		}

">="			{	return GE;		}

"<="			{	return LE;		}

"=="			{	return EQ;		}

"!="			{	return NE;		}

[-+()=/*><\n]	     	{ 	return *yytext; }		

[a-z]       		{
                		yylval = *yytext - 'a';
                		return VARIABLE;
                	}

{D}+      		{
                		yylval = atoi(yytext);
                		return INTEGER;
            		}

[ \t]   		; /* skip whitespace */

.               	yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}
