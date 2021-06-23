   /* cs152-fall08 */
   /* A flex scanner specification for the calculator language */
   /* Written by Dennis Jeffrey */

%{   
   int currLine = 1, currPos = 1;

%}

DIGIT    [0-9]
ID       [a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]
char     [a-zA-Z]
E_ID_1   [0-9_][a-zA-Z0-9_]*
E_ID_2   [a-zA-Z][a-zA-Z0-9_]*[_]   
%%
/*__________________Arithmetic Operators_____________________*/
"-"            {printf("SUB\n"); currPos += yyleng;} 
"+"            {printf("ADD\n"); currPos += yyleng;}
"*"            {printf("MULT\n"); currPos += yyleng;}
"/"            {printf("DIV\n"); currPos += yyleng;}
"%"            {printf("MOD\n"); currPos += yyleng;}
/*__________________Comparison Operators_____________________*/
"="            {printf("EQ\n"); currPos += yyleng;}
"<>"           {printf("NEQ\n"); currPos += yyleng;}
"<"            {printf("LT\n"); currPos += yyleng;}
">"            {printf("GT\n"); currPos += yyleng;}
"<="            {printf("LTE\n"); currPos += yyleng;}
">="            {printf("GTE\n"); currPos += yyleng;}
/*___________________Identifiers and Numbers_________________*/
{ID}           {printf("IDENT %s\n"); currPos+=yyleng;}
{DIGIT}+       {printf("NUMBER %s\n"); currPos+=yyleng};
/*___________________Other Special Symbols___________________*/
";"            {printf("SEMICOLON\n"); currPos += yyleng;}
":"            {printf("COLON\n"); currPos += yyleng;}
","            {printf("LOMMA\n"); currPos += yyleng;}
"("            {printf("L_PAREN\n"); currPos += yyleng;}
")"            {printf("R_PAREN\n"); currPos += yyleng;}
"["            {printf("L_SQUARE_BRACKET\n");currPos+=yyleng;}
"]"            {printf("R_SQUARE_BRACKET\n");currPos+=yyleng;}
":="            {printf("ASSIGN\n");currPos+=yyleng;}

(\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?[0-9]+)?)   {printf("NUMBER %s\n", yytext); currPos += yyleng;}

[ \t]+         {/* ignore spaces */ currPos +=4;}

"\n"           {currLine++; currPos = 1;}

/*.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}*/
/*I think we can get rid of this line above*/
%%

int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
      yyin = fopen(argv[1], "r");
      if(yyin == NULL)
      {
         yyin = stdin;
      }
   }
   else
   {
      yyin = stdin;
   }
   
   yylex();
   
   printf("# Numbers: %d\n", numNumbers);
   printf("# Operators: %d\n", numOperators);
   printf("# Parentheses: %d\n", numParens);
   printf("# Equal Signs: %d\n", numEquals);
}
