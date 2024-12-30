%{ 
#include<stdio.h>    
#include<stdlib.h> 
#include<string.h>
#include<ctype.h>   

enum TOKEN {FIN=0, PV,IF, THEN, ELSE, END, REPEAT, UNTIL, ID, READ, WRITE, OPREL, OPADD, OPMUL, PARG, PARD,  ENTIER, AFFECT};
enum COPREL {INF, EGAL};
enum COPADD {PLUS, MOINS}; 
enum COPMUL {PROD, DIV};

union {
    int val; 
    char* nom;
    enum COPADD copadd; 
    enum COPMUL copmul; 
    enum COPREL coprel;
} yylval;

void erreur_lexicale();

%}
%option yylineno
blancs  [\t \n]+
lettre  [A-Za-z]
chiffre [0-9]
ident   {lettre}(-?({lettre}|{chiffre}))*
entier  {chiffre}+
%% 
{blancs}   ;
;   return PV;
if  return IF;
else    return ELSE;
then    return THEN; 
end     return END;
repeat  return REPEAT;
until   return UNTIL;
read    return READ;
write   return WRITE;
{ident} {yylval.nom=(char*)malloc(yyleng+1);
        strcpy(yylval.nom, yytext); 
        return ID;}

{entier}  {  yylval.val=atoi(yytext);
            return ENTIER;}

[<=]   { if(yytext[0] == '<') yylval.coprel = INF; 
        else yylval.coprel = EGAL;
        return OPREL;}

[+-]    {if(yytext[0]== '+') yylval.copadd = PLUS; 
        else yylval.copadd = MOINS;
        return OPADD;}

[*/]    {if(yytext[0] == '*') yylval.copmul = PROD; 
        else yylval.copmul = DIV;
        return OPMUL;}

:=      return AFFECT;

\(  return PARG;
\)  return PARD;

"{"[^}]*"}"   ; 
.   erreur_lexicale();

%%
int yywrap() {
    return 1;
}

void erreur_lexicale(){
    printf("\nligne %d : erreur lexicale,",yylineno);
    if (isprint(yytext[0]))
        printf("’%c’ ",yytext[0]);
    printf("caractère illégal.\n");
    exit(1);
}


int main(int argc, char* argv[]) {
    enum TOKEN tc; 
    if (--argc>1){
        printf("Usage:\n\t %s [nom_de_fichier]\n",argv[0]);
        exit(2);
    } else if(argc ==1) {
        if((yyin = fopen(argv[1], "r")) == NULL){
            printf("Impossible d'ouvrir le fichier <%s>.\n", argv[1]);
            exit(3);
        }
    } else printf("Taper un programme \n\n");
    while(tc= yylex()) {
        switch(tc) {
            case PV: printf("<PV, >\n"); break;
            case AFFECT: printf("<AFFECT, >\n"); break;
            case IF: printf("<IF, >\n"); break;
            case ELSE: printf("<ELSE, >\n"); break;
            case THEN: printf("<THEN, >\n"); break;
            case END: printf("<END, >\n"); break;
            case REPEAT: printf("<REPEAT, >\n"); break;
            case UNTIL: printf("<UNTIL, >\n"); break;
            case PARG: printf("<PARG, >\n"); break;
            case PARD: printf("<PARD, >\n"); break;
            case READ: printf("<READ, >\n"); break;
            case WRITE: printf("<WRITE, >\n"); break;
            case ID: printf("<ID,%s >\n", yylval.nom); break;
            case ENTIER: printf("<ENTIER, %d>\n", yylval.val); break;
            case OPADD: printf("<OPADD, ");
                        if(yylval.copadd == PLUS) printf("PLUS>\n");
                        else printf("MOINS>\n");
                        break;
            case OPREL: printf("<OPREL, ");
                        if(yylval.coprel == INF) printf("INF>\n");
                        else printf("EGAL>\n");
                        break;
            case OPMUL: printf("<OPMUL, ");
                        if(yylval.copmul == DIV) printf("DIV>\n");
                        else printf("PROD>\n");
                        break;


        }
    }
    printf("<FIN, >\n");
    return 0;


}