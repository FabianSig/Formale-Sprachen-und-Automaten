  /* Find and add all integers and floats... */

%option noyywrap

CIBAN    DE[0-9]{20}

%%



CIBAN   {
   printf( "%s\n", yytext);
            }


\n|. { 
        /* Skip */
      }

%%

int main( int argc, char **argv )       
{
   ++argv, --argc;  /* skip over program name */
   if ( argc > 0 )
      yyin = fopen( argv[0], "r" );
   else
      yyin = stdin;
   
   yylex();
}
