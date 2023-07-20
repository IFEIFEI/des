%{
#include "y.tab.h"
#include "cond_s.h"

#include <stdio.h>
#include <string.h>
%}
numbers     ([0-9])+
opname      [ADD]
cond        [EQ|NE|CS|CC|MI|PL|VS|VC|HI|LS|GE|LT|GT|LE|AL]
suffix      S
opnamec     {opname}{cond}
opnames     {opname}{suffix}
opnamecs    {opname}{cond}{suffix}


delim       [ \t]
sep         ;
whitespace  {delim}+
lmp         \[
lsp         \(
rmp         \]
rsp         \)
undefined   .*
%%
{opname}      { return OPCODE; }
{opnamec}     { yylval.suffix = parse_cond(yytext); return OPCODE; }
{opnames}     { yylval.suffix = parse_s(yytext); return OPCODE; }
{opnamecs}    { yylval.suffix = parse_s(yytext); yylval.suffix = parse_cond_s(yytext,1); return OPCODE; }
\n            {  }
%%
