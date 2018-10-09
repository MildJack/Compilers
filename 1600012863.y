%{
#include <stdio.h>
#include "lex.yy.c"
#define YYSTYPE int
int yyparse(void);
%}
%token INTEGER PLUS MINUS TIMES DEVIDE LP RP
%%
command : exp {printf("%d\n", $1);}
exp   : exp PLUS term       { $$ = $1 + $3; }
      | exp MINUS term      { $$ = $1 - $3; }
      | term                { $$ = $1; }
      ;
term  : term TIMES factor   { $$ = $1 * $3; }
      | term DEVIDE factor  { $$ = $1 / $3; }
      | factor              { $$ = $1; }
      ;
factor: INTEGER             { $$ = $1; }
      | LP exp RP           { $$ = $2; }
      ;
%%
int main(){
    return yyparse();
}
void yyerror(char* s){
    fprintf(stderr, "%s", s);
}
int yywarp(){
    return 1;
}
