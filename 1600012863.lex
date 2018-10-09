%{
#include "y.tab.h"
extern int yylval;
%} 

/* regular definitions*/
delim   [ \t\n]
ws      {delim}+
digit   [0-9]
number  {digit}+(\.{digit}+)?
add     [+]
minus   [-]
mult    [*]
devide  [/]
lbra    [(]
rbra    [)]

%%

{ws}      {}
{number}  {sscanf(yytext, "%d", &yylval); return NUMBER;}
{add}     {return ADD;}
{minus}   {return MINUS;}
{mult}    {return MULT;}
{devide}  {return DEVIDE;}
{lbra}    {return LBRA;}
{rbra}    {return RBRA;}
.         {printf("Input Error!\n"); exit(1);}

%%
