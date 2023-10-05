  /* Find and add all integers and floats... */

%option noyywrap


%{
   int    mail_count = 0;
   int    webadress_count = 0;
   int    konto_count = 0;
   int    iban_count = 0;

%}

STR         [A-Za-z0-9_.~-]+

DOMAIN      ({STR}.)?{STR}.[a-zA-Z0-9]+
PORT        (:[0-9]+)
DIR         (\/{STR})+

WEBADRESS   http:\/\/{DOMAIN}{PORT}?{DIR}?

EMAIL       {STR}@{DOMAIN}

KONTOSTR    K((onto(nummer)?)|(to(nr)?)|(Nr))
KONTO       {KONTOSTR}.:?[ ]*[0-9]{1,10}

IBANSPACE   [0-9]{2}[ ][0-9]{4}[ ][0-9]{4}[ ][0-9]{4}[ ][0-9]{4}[ ][0-9]{2}
IBAN        DE({IBANSPACE}|[0-9]{20})

%%

{WEBADRESS}    { 
   printf( "Webadress: %s\n", yytext ); 
   webadress_count++;
               }

{EMAIL}    { 
   printf( "Email: %s\n", yytext ); 
   mail_count++;
               }

{KONTO}    { 
   printf( "Konto: %s\n", yytext ); 
   konto_count++;
               }

{IBAN}    { 
   printf( "IBAN: %s\n", yytext ); 
   iban_count++;
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
   
   printf("\n\nTOTAL WEBADRESSES: %d\n", webadress_count);
   printf("TOTAL : %d\n", mail_count);
   printf("TOTAL KONTOS: %d\n", konto_count);
   printf("TOTAL IBANS: %d\n", iban_count);
}
