%{
#include "lex.yy.c"

int yyparse(void);
void yyerror(char*);
void debug(char*);

%}
%union{
    char* str;
    int cond;
    int suffix;
}
%token <str> OPCODE RD RN OP2
%token <cond_t> COND
%token <suffix_t> SUFFIX

%%
lang :  lang inst      { }
| inst                  { }
;

inst : inst_op
| inst_op op_1
| inst_op op_1 op_2
| inst_op op_1 op_2 op_3 
;

inst_op : OPCODE
| OPCODE COND
| OPCODE COND SUFFIX
| OPCODE SUFFIX
;

op_1 : RD
;

op_2 : RN
;

op_3 : OP2
;


%%
int main()
{
    FILE *fp;
    char name[15];
    fp = fopen("input_file","r");
    while(!feof(fp))
    {
        fscanf(fp,"%s",name);
        yyin=fopen(name,"r");
        set_fvalid();
        // yyin=fopen("input.p","r");

        yyparse();
        fclose(yyin);
        // process();
    }
    fclose(fp);
    return 0;
}
void yyerror(char *s)
{
    fprintf(stderr,"%s\n",s);
}
int yywrap()
{
    return 1;
}
void debug(char* msg)
{
    printf("Parsed result: %s\n",msg);
}