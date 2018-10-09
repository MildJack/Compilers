%{
#define Pi 3.14159265358979
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int yylex();
int yyerror(char *);
void convert(int num ,int mode);
double vars[26]={0};
double last=0;
long var;
int i;
int flag=1;
%}
%token ANS
%token <dv> NUMBER
%token <cv> CHARA
%type <dv> expr
%type <cv> cmdline

%union
{

  double dv;
  char cv;
}
%token DROP HELP CLEAR LIST ERASE
%token '+' '-' '*' '/' '^' '%' '`' '~' '!' '='
%token COS SIN TAN OR AND PP SS LOR LOL COT or and
%token LOG

%left '='
%left '+' '-'
%left '*' '/' '%'
%left AND OR and or
%left COS SIN TAN LOG PP SS LOR LOL COT
%left '^'
%left '~' '!'
%right '(' ')'

%%
program:
        program expr '\n' {
                if(flag)
                {
                    printf( "你的结果是:\t=%g\n" , $2 );
                      last = $2;
                }
                else
                    {printf("");}
                  flag=1;
                }
          | program cmdline '\n'
          | program stat '\n'
          |
          ;

stat   :
                  CHARA '=' expr
                  {
                      if(islower($1))
                        i = $1 - 'a';
                      else
                      i = $1 - 'A';
              vars[i] = $3;
              flag =1;
      }

      expr    :
              NUMBER        { $$ = $1; }
              | ANS         { $$ = last; }
              | CHARA
                      {
                      if(islower($1))
                   i = $1 - 'a';
                           else
                    i = $1 - 'A';
                    $$ = vars[i];
                }
        | expr '+' expr  { $$ = $1 + $3; }
        | expr '-' expr  { $$ = $1 - $3; }
        | expr '*' expr  { $$ = $1 * $3; }
        | expr '/' expr  { $$ = $1 / $3; }
        | expr '^' expr  { $$ = pow($1, $3);}
        | '~' expr   {
                   $$=~(int)$2;
             }
             | '!' expr   {
                if(!(int)$2)
                 printf("true\n");
                else
                printf("false\n");
                 flag=0;
             }
             | expr '%' expr  { $$ = (int)$1 % (int)$3; }
        | '-' expr    { $$ = -$2; }
            | '(' expr ')'  { $$ = $2; }
            | COS expr  { $$ = cos($2 * Pi /180); }
        | SIN expr  { $$ = sin($2 * Pi /180); }
        | TAN expr  { $$ = tan($2 * Pi /180); }
        | COT expr  { $$ =1/sin($2 * Pi /180);}
        | expr LOG expr     { $$ = log($1)/log($3); }
        | expr AND expr {
        printf("与前的二进制($1):\n");
                             convert($1,2);
                             printf("\n");
                                  printf("与前的二进制($3):\n");
                                          convert($3,2);
                                          printf("\n");
                                   $$=(int)$1&(int)$3;
                                   printf("结果的二进制($$):\n");
                                   convert($$,2);
                            printf("\n");
                            }
                  | expr OR  expr {
                                       printf("或前的二进制($1):\n");
                                       convert($1,2);
                            printf("\n");
                            printf("或前的二进制($3):\n");
                            convert($3,2);
                     printf("\n");
                     $$ =(int)$1|(int)$3;
                     printf("结果的二进制($$):\n");
                            convert($$,2);
                            printf("\n");
                            }
                    | expr and expr {
                        if( (int)$1 && (int)$3)
                          printf("true\n");
                          else
                        printf("false\n");
                               flag=0;
                      }
                      | expr or  expr {
                    if( (int)$1 || (int)$3)
                                      printf("true\n");
                                      else
                                                    printf("false\n");
                                  flag=0;
                                  }
                    | expr PP   {   $$ =$1+1;}
                    | expr SS   {   $$ =$1-1;}
                    | expr LOL expr {
                            printf("移位前的二进制:");
                            convert($1,2);
                            printf("\n");
                                  $$ =(int)$1<<(int)$3;
                                  printf("移位后的二进制:");
                                  convert($$,2);
                                        printf("\n");
                                    }
                                    | expr LOR expr {
                                      printf("移位前的二进制:");
                                      convert($1,2);
                                      printf("\n");
                                        $$ =(int)$1>>(int)$3;
                                        printf("移位后的二进制:");
                                        convert($$,2);
                                      printf("\n");
                                  }
                                  ;
      cmdline :  DROP  { exit(0);}
              |  CLEAR  {
              system("clear");
        }
 | LIST   {
 for(i=0;i<26;i++)
            printf("\t%c=%g\n",'a'+i,vars[i]);
         }
         | ERASE    { for(i=0;i<26;i++) vars[i]=0; printf("已经清空所有的寄存器的值!\n");}
          | HELP     {
                     printf("命令:\n");
                     printf(">>help :获取帮助.\n");
                               printf(">>ans  :列出上次计算的结果.\n");
                               printf(">>list :列出寄存器中所有的值 'a'/'z'.\n");
                                     printf(">>erase:重置寄存器.\n");
                                     printf(">>clear:清屏.\n");
                               printf(">>drop :退出程序.\n");
                               }
                               ;
%%
  int yyerror(char *s)
  {
  printf("%s\n", s);
    return 1;
  }
  void convert(int num ,int mode)
    {
         if(num/mode==0)
         {
         printf("\t%d",num);return;}
                else
               {
                 convert(num/mode,mode);
                 printf("%d",num%mode);
                   }
             }
             int main(int argc,char **argv)
           {
        printf("\t |                      HeFei Noraml University                          |\n");
                yyparse();
}
