 /* 
     Lexer for a minimal "scientific" calculator.

     Copyright 2014 by Stephan Schulz, schulz@eprover.org.

     This code is released under the GNU General Public Licence
     Version 2.
 */

%option noyywrap

%{
   #include "scicalcparse.tab.h"
%}

DIGIT      [0-9]
INT        {DIGIT}+
PLAINFLOAT {INT}|{INT}[.]|{INT}[.]{INT}|[.]{INT}
EXP        [eE](\+|-)?{INT}
NUMBER     {PLAINFLOAT}{EXP}?
REG        R{DIGIT}{DIGIT}?

%%

"*" {return MULT;}
"+" {return PLUS;}
"-" {return MINUS;}
"/" {return DIVI;}
"=" {return ASSIGN;}
"(" {return OPENPAR;}
")" {return CLOSEPAR;}
\n  {return NEWLINE;}

{REG}    {
            yylval.regno = atoi(yytext+1);
            return REGISTER;
         }

{NUMBER} {
            yylval.val = atof(yytext);
            return FLOAT;
        }

[ ] { /* Skip  whitespace*/ }

 /* Everything else is an invalid character. */
.    { return ERROR;}

%%

