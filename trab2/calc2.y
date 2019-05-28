%{
    #include <stdio.h>
    void yyerror(char *);
    int yylex(void);

    int sym[26];
%}

%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'

%%

program:
        program statement '\n'
        | /* NULL */
        ;

statement:
        exp               		{ printf("%d\n", $1); }
        | VARIABLE '=' exp		{ sym[$1] = $3; }
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
