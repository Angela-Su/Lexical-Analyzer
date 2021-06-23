%{
    int num_lines = 1, num_columns = 1; 
%}

DIGIT   [0-9]
ID      [a-zA-Z][a-zA-Z0-9_]*
CHAR    [a-zA-Z]
E_ID_1  [0-9_][a-zA-Z0-9_]*
E_ID_2  [a-zA-Z][a-zA-Z0-9_]*[_]

%%
{DIGIT}+        printf("NUMBER %s\n", yytext);
function        printf("FUNCTION\n"); num_columns += yyleng;
beginparams     printf("BEGINPARAMS\n"); num_columns += yyleng;
endparams       printf("ENDPARAMS\n"); num_columns += yyleng;
beginlocals     printf("BEGINLOCALS\n"); num_columns += yyleng;
endlocals       printf("ENDLOCALS\n"); num_columns += yyleng;
beginbody       printf("BEGINBODY\n"); num_columns += yyleng;
endbody         printf("ENDBODY\n"); num_columns += yyleng;
integer         printf("INTEGER\n"); num_columns += yyleng;
array           printf("ARRAY\n"); num_columns += yyleng;
enum            printf("ENUM\n"); num_columns += yyleng;
of              printf("OF\n"); num_columns += yyleng;
if              printf("IF\n"); num_columns += yyleng;
then            printf("THEN\n"); num_columns += yyleng;
endif           printf("ENDIF\n"); num_columns += yyleng;
else            printf("ELSE\n"); num_columns += yyleng;
while           printf("WHILE\n"); num_columns += yyleng;
do              printf("DO\n"); num_columns += yyleng;
for             printf("FOR\n"); num_columns += yyleng;
beginloop       printf("BEGINLOOP\n"); num_columns += yyleng;
endloop         printf("ENDLOOP\n"); num_columns += yyleng;
continue        printf("CONTINUE\n"); num_columns += yyleng;
read            printf("READ\n"); num_columns += yyleng;
write           printf("WRITE\n"); num_columns += yyleng;
and             printf("AND\n"); num_columns += yyleng;
or              printf("OR\n"); num_columns += yyleng;
not             printf("NOT\n"); num_columns += yyleng;
true            printf("TRUE\n"); num_columns += yyleng;
false           printf("FALSE\n"); num_columns += yyleng;
return          printf("RETURN\n"); num_columns += yyleng;

"-"             {printf("SUB\n"); num_columns += yyleng;} 
"+"             {printf("ADD\n"); num_columns += yyleng;}
"*"             {printf("MULT\n"); num_columns += yyleng;}
"/"             {printf("DIV\n"); num_columns += yyleng;}
"%"             {printf("MOD\n"); num_columns += yyleng;}

"="             {printf("EQ\n"); num_columns += yyleng;}
"<>"            {printf("NEQ\n"); num_columns += yyleng;}
"<"             {printf("LT\n"); num_columns += yyleng;}
">"             {printf("GT\n"); num_columns += yyleng;}
"<="            {printf("LTE\n"); num_columns += yyleng;}
">="            {printf("GTE\n"); num_columns += yyleng;}

{ID}            {printf("IDENT %s\n", yytext); num_columns+=yyleng;}

";"             printf("SEMICOLON\n"); num_columns += yyleng;
":"             {printf("COLON\n"); num_columns += yyleng;}
","             {printf("COMMA\n"); num_columns += yyleng;}
"("             {printf("L_PAREN\n"); num_columns += yyleng;}
")"             {printf("R_PAREN\n"); num_columns += yyleng;}
"["             {printf("L_SQUARE_BRACKET\n");num_columns+=yyleng;}
"]"             {printf("R_SQUARE_BRACKET\n");num_columns+=yyleng;}
":="            {printf("ASSIGN\n");num_columns+=yyleng;}
[ ]             num_columns++;
\t              num_columns+=4;
\n           {num_lines++; num_columns = 1;}
<<EOF>>         exit(0);
{E_ID_1}        {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n",
                 num_lines, num_columns, yytext); exit(-1);}
{E_ID_2}        {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n",
                 num_lines, num_columns, yytext); exit(-1);}
.               {printf("Error at line $d, column %d: unrecognized symbol \"%s\"\n", num_lines, num_columns, yytext); exit(-1);}


            
%%
int main(int argc, char **argv){
    ++argv, --argc;

    if(argc > 0){
        yyin = fopen(argv[0], "r");
    }
    else{
        yyin = stdin;
    }
    yylex();
}
