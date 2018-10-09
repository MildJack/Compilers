%{
#include <stdio.h>
#define YYSTYPE int
int yyparse(void);
void yyerror(char* s);
int yywrap();
%}
%token  NUMBER ADD MINUS MULT DEVIDE LBRA RBRA

%%
command: expr    {printf("%d\n", $1);}

expr  :   expr   ADD     term    { $$ = $1 + $3; }
      |   expr   MINUS   term    { $$ = $1 - $3; }
      |   term                   { $$ = $1; }
      ;
term  :   term   MULT    factor  { $$ = $1 * $3; }
      |   term   DEVIDE  factor  { $$ = $1 / $3; }
      |   factor                 { $$ = $1; }
      ;
factor:   NUMBER                 { $$ = $1; }
      |   LBRA   expr    RBRA    { $$ = $2; }
      ;

%%
int main(){
    return yyparse();
}
void yyerror(char* s){
    fprintf(stderr, "%s", s);
}
int yywrap(){    
    return 1;
}
