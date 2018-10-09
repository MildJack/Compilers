%{
#include <stdio.h>
%}

%%

[\n] { printf("new line\n"); }
[0-9]+ { printf("int: %d\n", atoi(yytext)); }
[0-9]*\.[0-9]+ { printf("float: %f\n", atof(yytext)); }
[a-zA-Z][a-zA-Z0-9]* { printf("var: %s\n", yytext); }
[\+\-\*\/\%] { printf("op: %s\n", yytext); }
. { printf("unknown: %c\n", yytext[0]); }

%%

int yywrap(){    
    return 1;
}
