%{
    #include <stdio.h>
    void yyerror(char *);
    int yylex(void);

    int sym[26];
%}

%token INTEGER VARIABLE TRUE FALSE
%left '+' '-'
%left '*' '/'

%%

program:
        program statement '\n'
        | /* NULL */
        ;

statement:
        exp               		{ printf("%d\n", $1); }
	| bool				{ 
						if ($$ == 1) printf("true\n");
						else if ($$ == 0) printf("false\n");
					}
        | VARIABLE '=' exp		{ sym[$1] = $3; }
        ;

bool: 	TRUE 				{$$ = 1;}
    	| FALSE 			{$$ = 0;}

exp:
        INTEGER
        | VARIABLE        		{ $$ = sym[$1]; }
	| exp "AND" exp			{ $$ = $1 && $3;}
	| exp "OR" exp			{ $$ = $1 || $3;}
	| "NOT" exp			{ $$ = !$2;     }
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
