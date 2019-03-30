%{
/*Variables to count number of open and close parentesis and others*/
int openP = 0, closeP = 0;
%}

/* Rules Section */
D		[0-9]
IDENTIFIER	[A-Za-z][A-Za-z0-9]*
%%

" "			;
[\t]			printf(" ");
[\n]			{
				if (openP != closeP) {
					printf(" <Erro Parenteses>");
				}
				openP = 0; closeP = 0; printf("\n");
			}
\(			{openP++;}
\)			{closeP++;}
true|TRUE|false|FALSE	printf(" <Expressão Lógica> ");
AND|OR|NOT		printf(" <Operador Lógico> ");
\+|\-|\/|\*		printf(" <Operador Aritmético> ");
{D}+			printf(" <Nº Inteiro> ");
{D}+\.{D}		printf(" <Nº Float> ");
{IDENTIFIER}		printf(" <Identificador> ");
>=?|<=?|==		printf(" <Operador Lógico Aritmético> ");
=			printf(" <Operador Atribuição> ");
.			printf(" <Erro> ");

%%
