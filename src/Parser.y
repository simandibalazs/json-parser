%{
#include <stdio.h>
%}
%define parse.error verbose
%code requires {
    struct data {
	int noOfString;
	int noOfNum;
	int noOfBool;
	int noOfNull;
	int noOfArr;
	int noOfObj;
	int noOfElements;
	int noOfAttrs;
    };
}
// Symbols.
%union
{
    struct data data;
};

%token  __STRING_LITERAL 
%token  __BOOLEAN
%token  __UNRECOGNIZED_TOKEN
%token  __NUMBER
%token  __NULL

%type <data> value
%type <data> object
%type <data> members
%type <data> pair
%type <data> array
%type <data> elements


%start object
%%

object:   '{' '}' 			{
						printf("Empty object");
					}
	| '{' members '}' 		{
						printf("# of attributes: %d\n", $2.noOfAttrs);
						printf("Object contains: %d objects,%d arrays,%d strings,%d numbers,%d booleans,%d nulls\n\n", 							$2.noOfObj, $2.noOfArr, $2.noOfString, $2.noOfNum, $2.noOfBool, $2.noOfNull);
					}
	;

members:  pair 				{
						$$.noOfAttrs = $1.noOfAttrs;
						$$.noOfObj = $1.noOfObj;
						$$.noOfArr = $1.noOfArr;
						$$.noOfString = $1.noOfString;
						$$.noOfNum = $1.noOfNum;
						$$.noOfBool = $1.noOfBool;
						$$.noOfNull = $1.noOfNull;
					}
	| pair ',' members 		{
						$$.noOfAttrs = $1.noOfAttrs + $3.noOfAttrs;
						$$.noOfObj = $1.noOfObj + $3.noOfObj;
						$$.noOfArr = $1.noOfArr + $3.noOfArr;
						$$.noOfString = $1.noOfString + $3.noOfString;
						$$.noOfNum = $1.noOfNum + $3.noOfNum;
						$$.noOfBool = $1.noOfBool + $3.noOfBool;
						$$.noOfNull = $1.noOfNull + $3.noOfNull;
					}
	;

pair:	  __STRING_LITERAL ':' value 	{
						$$.noOfAttrs = $$.noOfAttrs + 1;
						$$.noOfObj = $3.noOfObj;
						$$.noOfArr = $3.noOfArr;
						$$.noOfString = $3.noOfString;
						$$.noOfNum = $3.noOfNum;
						$$.noOfBool = $3.noOfBool;
						$$.noOfNull = $3.noOfNull;
					}
	;

elements: value 	     	{
					$$.noOfObj = $1.noOfObj; $$.noOfElements = $1.noOfElements;
					$$.noOfArr = $1.noOfArr; 
					$$.noOfString = $1.noOfString;
					$$.noOfNum = $1.noOfNum; 
					$$.noOfBool = $1.noOfBool; 
					$$.noOfNull = $1.noOfNull; 
			     	}
	| value ',' elements 	{
					$$.noOfObj=$1.noOfObj+$3.noOfObj; $$.noOfElements = $1.noOfElements + $3.noOfElements;
					$$.noOfArr=$1.noOfArr+$3.noOfArr;
					$$.noOfString=$1.noOfString+$3.noOfString;
					$$.noOfNum=$1.noOfNum+$3.noOfNum;
					$$.noOfBool=$1.noOfBool+$3.noOfBool;
					$$.noOfNull=$1.noOfNull+$3.noOfNull;
			    	}
	;

array:	  '[' ']' 		{
					printf("# of elements: 0"); printf(", Empty array");
				}
	| '[' elements ']' 	{
					printf("# of elements: %d\n", $2.noOfElements);
					printf("Array contains: %d objects,%d arrays,%d strings,%d numbers,%d booleans,%d nulls\n\n", 							$2.noOfObj, $2.noOfArr, $2.noOfString, $2.noOfNum, $2.noOfBool, $2.noOfNull);
				}
	;


value:	  object  		{
					$$.noOfObj = $$.noOfObj + 1; $$.noOfElements = $$.noOfElements + 1;
				}
	| array 		{
					$$.noOfArr = $$.noOfArr + 1; $$.noOfElements = $$.noOfElements + 1;
				}
	| __STRING_LITERAL 	{
					$$.noOfString = $$.noOfString + 1; $$.noOfElements = $$.noOfElements + 1;
				}
	| __NUMBER		{
					$$.noOfNum = $$.noOfNum + 1; $$.noOfElements = $$.noOfElements + 1;
				}
	| __BOOLEAN		{
					$$.noOfBool = $$.noOfBool + 1; $$.noOfElements = $$.noOfElements + 1;
				}
	| __NULL		{
					$$.noOfNull = $$.noOfNull + 1; $$.noOfElements = $$.noOfElements + 1;
				}
	;
%%

int yyerror(char *s) {
  printf("\n%s\n",s);
}

int main(void) {
  if(yyparse() == 0){
    printf("Input accepted!\n");
  }else{
    printf("Input was not accepted!\n");
  }
  return 0;
}
