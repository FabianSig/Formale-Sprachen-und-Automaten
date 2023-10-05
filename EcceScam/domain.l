  /* Find and add all integers and floats... */

%option noyywrap


%{
   int    mail_count = 0;
   int    webadress_count = 0;

%}

STR         [A-Za-z0-9_.∼-]+

DOMAIN      ({STR}.)?{STR}.[a-zA-Z]+
PORT        (:[0-9]+)?
DIR         (\/[a-zA-Z])+

WEBADRESS   http:\/\/{DOMAIN}{PORT}{DIR}

EMAIL       {STR}@{DOMAIN}


EMAIL1    [A-Za-z0-9 .∼-]+@[A-Za-z0-9 .∼-]+.[A-Za-z0-9 .∼-]+
%%




{WEBADRESS}    { 
   printf( "Webadress: %s\n", yytext ); 
   webadress_count++;
               }

{EMAIL}    { 
   printf( "Email: %s\n", yytext ); 
   mail_count++;
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
   
   printf("\n\n TOTAL WEBADRESSES: %d\n", webadress_count);
   printf("TOTAL EMAILS: %d", mail_count);
}
