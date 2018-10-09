%{
#include <stdlib.h>
#include "y.tab.h"
extern int yyerror(const char *);
%} 

%%
[" "; \t]           { }
(0(\.[0-9]+)?)|([1-9][0-9]*(\.[0-9]+)?)     { yylval.dv = strtod(yytext,0);return NUMBER;}  
[a-zA-Z]                                    { yylval.cv = *yytext;  return CHARA;} 

[-+*/()^%~!=\n]     {return *yytext;}
[&]                 {return AND;}
[|]                 {return OR;}
[||]                {return or;}
[&&]                {return and;}
[log]               {return LOG;}
[cos]               {return COS;}
[sin]               {return SIN;}
[tan]               {return TAN;}
[++]                {return PP;}
[--]                {return SS;}
[<<]                {return LOL;} 
[>>]              {return LOR;}
[cot]               {return COT;} 

[ans]               {return ANS;}
[drop]              {return DROP;}
[list]              {return LIST;}
[erase]             {return ERASE;}
[clear]             {return CLEAR;}
[help]              {return HELP;}
%%
int yywrap(){    
    return 1;
}
