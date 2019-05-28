%{
    #include <stdio.h>
    void yyerror(char *);
    int yylex(void);

    int sym[26];
%}

%token INTEGER VARIABLE TRUE FALSE
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
        | VARIABLE '=' exp		{ sym[$1] = $3; }
        ;

exp:
        INTEGER
        | VARIABLE        		{ $$ = sym[$1]; }
	| TRUE 				{ $$ = 1; 	}
    	| FALSE 			{ $$ = 0;	}
	| exp EQ exp			{ $$ = $1 == $3;}
	| exp NE exp			{ $$ = $1 != $3;}
	| exp LE exp			{ $$ = $1 <= $3;}
	| exp GE exp			{ $$ = $1 >= $3;}
	| exp AND exp			{ $$ = $1 && $3;}
	| exp OR exp			{ $$ = $1 || $3;}
	| NOT exp			{ $$ = !$2;     }
	| exp '<' exp     		{ $$ = $1 < $3; }
	| exp '>' exp     		{ $$ = $1 > $3; }
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
