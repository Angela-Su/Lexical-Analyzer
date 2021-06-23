%[
    int num_lines = 1, int num_columns = 1; 
]%

DIGIT   [0-9]
ID      [a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]
CHAR    [a-zA-Z]
E_ID_1  [a-zA-Z][a-zA-Z0-9_]*
E_ID_2  [a-zA-Z][a-zA-Z0-9_]*[_]

%%
{DIGIT}+        printf(NUMBER %s\n", yytext);
function        printf(FUNCTION\n"); num_columns += yyleng;
beginparams     printf(BEGINPARAMS\n"); num_columns += yyleng;
endparams       printf(ENDPARAMS\n"); num_columns += yyleng;
beginlocals     printf(BEGINLOCALS\n"); num_columns += yyleng;
endlocals       printf(ENDLOCALS\n"); num_columns += yyleng;
beginbody       printf(BEGINBODY\n"); num_columns += yyleng;
endbody         printf(ENDBODY\n"); num_columns += yyleng;
integer         printf(INTEGER\n"); num_columns += yyleng;
array           printf(ARRAY\n"); num_columns += yyleng;
of              printf(OF\n"); num_columns += yyleng;
if              printf(IF\n"); num_columns += yyleng;
then            printf(THEN\n"); num_columns += yyleng;
endif           printf(ENDIF\n"); num_columns += yyleng;
else            printf(ELSE\n"); num_columns += yyleng;
while           printf(WHILE\n"); num_columns += yyleng;
do              printf(DO\n"); num_columns += yyleng;
for             printf(FOR\n"); num_columns += yyleng;
beginloop       printf(BEGINLOOP\n"); num_columns += yyleng;
endloop         printf(ENDLOOP\n"); num_columns += yyleng;
continue        printf(CONTINUE\n"); num_columns += yyleng;
read            printf(READ\n"); num_columns += yyleng;
write           printf(WRITE\n"); num_columns += yyleng;
and             printf(AND\n"); num_columns += yyleng;
or              printf(OR\n"); num_columns += yyleng;
not             printf(NOT\n"); num_columns += yyleng;
true            printf(TRUE\n"); num_columns += yyleng;
false           printf(FALSE\n"); num_columns += yyleng;
return          printf(RETURN\n"); num_columns += yyleng;
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
/*___________________Identifiers(Number is above)_________________*/
{ID}           {printf("IDENT %s\n"); currPos+=yyleng;}
/*___________________Other Special Symbols___________________*/
";"            {printf("SEMICOLON\n"); currPos += yyleng;}
":"            {printf("COLON\n"); currPos += yyleng;}
","            {printf("LOMMA\n"); currPos += yyleng;}
"("            {printf("L_PAREN\n"); currPos += yyleng;}
")"            {printf("R_PAREN\n"); currPos += yyleng;}
"["            {printf("L_SQUARE_BRACKET\n");currPos+=yyleng;}
"]"            {printf("R_SQUARE_BRACKET\n");currPos+=yyleng;}
":="            {printf("ASSIGN\n");currPos+=yyleng;}