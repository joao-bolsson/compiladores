%{
	#include <stdio.h>
	#include <stdbool.h>
	void yyerror(char *);
	int yylex(void);
	int sym[26];
%}

%token INTEGER FLOAT VARIABLE TRUE FALSE
%left NOT
%left AND
%left OR
%left EQ NE
%left '>' '<' LE GE
%left '+' '-'
%left '*' '/'
%left '(' ')'

%%

program:
        program statement '\n'
        | /* NULL */
        ;

statement:
        exp               		{ printf("%d\n", $1);}
	| exp_bool			{
						if($1) printf("true\n");
						else printf("false\n");
					}
        | VARIABLE '=' exp		{ sym[$1] = $3; }
        ;

exp_bool:
	TRUE 				{ $$ = true; 	}
    	| FALSE 			{ $$ = false;	}
	| exp_bool EQ exp_bool		{ $$ = $1 == $3;}
	| exp_bool NE exp_bool		{ $$ = $1 != $3;}
	| exp_bool LE exp_bool		{ $$ = $1 <= $3;}
	| exp_bool GE exp_bool		{ $$ = $1 >= $3;}
	| exp_bool AND exp_bool		{ $$ = $1 && $3;}
	| exp_bool OR exp_bool		{ $$ = $1 || $3;}
	| NOT exp_bool			{ $$ = !$2;     }
	| exp_bool '<' exp_bool     	{ $$ = $1 < $3; }
	| exp_bool '>' exp_bool     	{ $$ = $1 > $3; }
	| '(' exp_bool ')'            	{ $$ = $2; }
	| exp
	;

exp:
        INTEGER
        | VARIABLE        		{ $$ = sym[$1]; }
        | exp '+' exp     		{ $$ = $1 + $3; }
        | exp '-' exp     		{ $$ = $1 - $3; }
        | exp '*' exp     		{ $$ = $1 * $3; }
        | exp '/' exp     		{ $$ = $1 / $3; }
        | '(' exp ')'            	{ $$ = $2; }	
        ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
}
