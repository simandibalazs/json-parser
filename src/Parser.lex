%{
#include "Parser.h"
%}

blanks          [ \t\n\r]+
VALID_ESCAPE_CHARACTER \\n|\\b|\\\"|\\\\|\\\/|\\f|\\r|\\t|\\u[0-9]{4}
VALID_CHARACTER [^\\\"]
LC \{
RC \}
CN :
CM ,
LS \[
RS \]
STRING_LITERAL \"({VALID_CHARACTER}|{VALID_ESCAPE_CHARACTER})*\"
BOOLEAN true|false|TRUE|FALSE
NUMBER (-)?0(\.[0-9]*)?([e|E][+|-][0-9]*)?|(-)?[1-9][0-9]*(\.[0-9]*)?([e|E][+|-][0-9]*)?
NULL null|NULL

%%

{blanks}        { /* ignore */ }
{LC} {printf("\n--------- OBJECT BEGIN ---------\n");return '{';}
{RC} {printf("\n---------- OBJECT END ----------\n");return '}';}
{STRING_LITERAL} {printf("%s", yytext); return(__STRING_LITERAL); /* matches string-literal on a single line; */}
{CN} {printf(" : "); return ':';}
{CM} {printf(",\n"); return ',';}
{LS} {printf("\n---------- ARRAY BEGIN ---------\n"); return '[';}
{RS} {printf("\n----------- ARRAY END ----------\n"); return ']';}
{BOOLEAN} {printf("%s", yytext); return(__BOOLEAN);/*matches boolean values*/}
{NUMBER} {printf("%s", yytext); return(__NUMBER); }
{NULL} {printf("%s", yytext); return(__NULL); }
[^{blanks}{LS}{RS}{LC}{RC}{CN}{CM}{STRING_LITERAL}{BOOLEAN}{NUMBER}{NULL}] {return(__UNRECOGNIZED_TOKEN);}
