%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
place                                   return PLACETOK;
green|yellow|black|white|blue|red       yylval=strdup(yytext); return COLOR;
ball|pen|eraser|phone|wallet            yylval=strdup(yytext); return OBJECT;
in                                      return INTOK;
on                                      return ONTOK;
pocket|bag|drawer                       yylval=strdup(yytext); return CONTAINER;
shelf|desktop|floor                     yylval=strdup(yytext); return SURFACE;
clear                                   return CLEARTOK;
move                                    return MOVETOK;
to                                      return TOTOK;
show                                    return SHOWTOK;
dump                                    return DUMPTOK;
reset                                   return RESETTOK;
\n                                      /* ignore end of line */;
[ \t]+                                  /* ignore whitespace */;
%%
