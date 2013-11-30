/* lexical grammar */
%lex

%%
\s+                     /* skip whitespace */
"/*"[\s\S]*?"*/"        /* C-style comment */
"//".*                  /* C++-style comment */

/* keywords */
"var"                   return 'VAR';
"if"                    return 'IF';
"else"                  return 'ELSE';
"repeat"                return 'REPEAT';
"while"                 return 'WHILE';
"do"                    return 'DO';
"until"                 return 'UNTIL';
"for"                   return 'FOR';
"switch"                return 'SWITCH';
"case"                  return 'CASE';
"with"                  return 'WITH';
"default"               return 'DEFAULT';
"break"                 return 'BREAK';
"continue"              return 'CONTINUE';
"exit"                  return 'EXIT';
"return"                return 'RETURN';
"global"                return 'GLOBAL';
"div"                   return 'DIV';
"mod"                   return 'MOD';
"begin"                 return 'BEGIN';
"end"                   return 'END';

/* literals */
[0-9]+("."[0-9]+)?\b    return 'NUMBER';        /* 123.4 */
"$"[0-9a-fA-F]+\b       return 'HEX';           /* $FF00AA */
"\""[\s\S]*?"\""        return 'STRING';        /* "string" */
"'"[\s\S]*?"'"          return 'STRING';        /* 'string' */
[a-zA-Z_][0-9a-zA-Z_]*  return 'IDENTIFIER';    /* var_name3 */

/* punctuation */
";"                     return ';';
","                     return ',';
":"                     return ':';
"{"                     return 'BEGIN';
"}"                     return 'END';

/* operators */
"="                     return '=';
"++"                    return '++';
"--"                    return '--';
"+="                    return '+=';
"-="                    return '-=';
"*="                    return '*=';
"/="                    return '/=';
"|="                    return '|=';
"&="                    return '&=';
"^="                    return '^=';
"<<"                    return '<<';
">>"                    return '>>';
"&&"                    return '&&';
"||"                    return '||';
"^^"                    return '^^';
"<="                    return '<=';
"<"                     return '<';
"=="                    return '==';
"!="                    return '!=';
">="                    return '>=';
">"                     return '>';
"|"                     return '|';
"&"                     return '&';
"^"                     return '^';
"+"                     return '+';
"-"                     return '-';
"*"                     return '*';
"/"                     return '/';
"!"                     return '!';
"~"                     return '~';
"."                     return '.';
"["                     return '[';
"]"                     return ']';
"("                     return '(';
")"                     return ')';
<<EOF>>                 return 'EOF';

/lex

/* operator associations and precedence */

%left 'IF'
%left 'ELSE'
%left '&&' '||' '^^'
%left '<' '<=' '==' '!=' '>' '>='
%left '|' '&' '^'
%left '<<' '>>'
%left '+' '-'
%left '*' '/' 'DIV' 'MOD'
%left '!' '~' UMINUS
%left '.' '[' ']'
%left '(' ')'

%start top

%% /* language grammar */

top
    : statements EOF
        { return $1; }
    ;

statements
    : statements_unwrapped
        { $$ = yy.makeStmtList($1); }
    ;

statements_unwrapped
    : statement statements_unwrapped
        { $$ = [$1].concat($2); }
    | /* empty */
        { $$ = []; }
    ;

statement
    : statement_unwrapped
        { $$ = yy.makeStmt($1, @1); }
    ;

statement_unwrapped
    : assignment ';'
        { $$ = $1; }
    | function_call ';'
        { $$ = $1; }
    | var_statement ';'
        { $$ = $1; }
    | if_statement ';'
        { $$ = $1; }
    | repeat_statement ';'
        { $$ = $1; }
    | while_statement ';'
        { $$ = $1; }
    | do_until_statement ';'
        { $$ = $1; }
    | for_statement ';'
        { $$ = $1; }
    | switch_statement ';'
        { $$ = $1; }
    | with_statement ';'
        { $$ = $1; }
    | BEGIN statements END
        { $$ = $2; }
    | BREAK ';'
        { $$ = yy.makeBreakStmt(); }
    | CONTINUE ';'
        { $$ = yy.makeContinueStmt(); }
    | EXIT ';'
        { $$ = yy.makeExitStmt(); }
    | RETURN expression ';'
        { $$ = yy.makeReturnStmt($2); }
    | ';'
        { $$ = yy.makeNopStmt(); }
    ;

if_statement
    : IF '(' expression ')' statement
        { $$ = yy.makeIfStmt($3, $5); }
    | IF '(' expression ')' statement ELSE statement
        { $$ = yy.makeIfElseStmt($3, $5, $7); }
    ;

repeat_statement
    : REPEAT '(' expression ')' statement
        { $$ = yy.makeRepeatStmt($3, $5); }
    ;

while_statement
    : WHILE '(' expression ')' statement
        { $$ = yy.makeWhileStmt($3, $5); }
    ;

do_until_statement
    : DO statement UNTIL '(' expression ')'
        { $$ = yy.makeDoUntilStmt($2, $5); }
    ;

for_statement
    : FOR '(' assignment ';' expression ';' assignment ')' statement
        { $$ = yy.makeForStmt($3, $5, $7, $9); }
    ;

switch_statement
    : SWITCH '(' expression ')' '{' cases '}'
        { $$ = yy.makeSwitchStmt($3, $6); }
    ;

cases
    : case cases
        { $$ = [$1].concat($2); }
    | /* empty */
        { $$ = []; }
    ;

case
    : CASE expression ':' statements
        { $$ = yy.makeCase($2, $4); }
    | DEFAULT ':' statements
        { $$ = yy.makeDefaultCase($3); }
    ;

with_statement
    : WITH '(' expression ')' statement
        { $$ = yy.makeWithStmt($3, $5); }
    ;

var_statement
    : VAR var_list
        { $$ = yy.makeVarStmt($2); }
    ;

var_list
    : IDENTIFIER ',' var_list
        { $$ = [yy.makeVarStmtItem($1)].concat($3); }
    | IDENTIFIER '=' expression ',' var_list
        { $$ = [yy.makeVarStmtItem($1, $3)].concat($5); }
    | IDENTIFIER
        { $$ = [yy.makeVarStmtItem($1)]; }
    | IDENTIFIER '=' expression
        { $$ = [yy.makeVarStmtItem($1, $3)]; }
    ;

assignment
    : variable '=' expression
        { $$ = yy.makeAssignStmt($1, $3); }
    | variable '++'
        { $$ = yy.makeCmpAssignStmt('+', $1, yy.makeNumVal('1')); }
    | variable '--'
        { $$ = yy.makeCmpAssignStmt('-', $1, yy.makeNumVal('1')); }
    | variable '+=' expression
        { $$ = yy.makeCmpAssignStmt('+', $1, $3); }
    | variable '-=' expression
        { $$ = yy.makeCmpAssignStmt('-', $1, $3); }
    | variable '*=' expression
        { $$ = yy.makeCmpAssignStmt('*', $1, $3); }
    | variable '/=' expression
        { $$ = yy.makeCmpAssignStmt('/', $1, $3); }
    | variable '|=' expression
        { $$ = yy.makeCmpAssignStmt('|', $1, $3); }
    | variable '&=' expression
        { $$ = yy.makeCmpAssignStmt('&', $1, $3); }
    | variable '^=' expression
        { $$ = yy.makeCmpAssignStmt('^', $1, $3); }
    ;

expression
    : NUMBER
        { $$ = yy.makeNumVal(yytext); }
    | HEX
        { $$ = yy.makeHexVal(yytext); }
    | STRING
        { $$ = yy.makeStringVal(yytext); }
    | expression '&&' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '||' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '^^' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '<' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '<=' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '==' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '!=' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '>' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '>=' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '|' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '&' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '^' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '<<' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '>>' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '+' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '-' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '*' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '/' expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression DIV expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression MOD expression
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | '!' expression
        { $$ = yy.makeUnaryOp($1, $2); }
    | '~' expression
        { $$ = yy.makeUnaryOp($1, $2); }
    | '-' expression %prec UMINUS
        { $$ = yy.makeUnaryOp($1, $2); }
    | function_call
        { $$ = $1; }
    | variable
        { $$ = $1; }
    | '(' expression ')'
        { $$ = $2; }
    ;

function_call
    : identifier '(' ')'
        { $$ = yy.makeFunctionCall($1, []); }
    | identifier '(' function_call_arguments ')'
        { $$ = yy.makeFunctionCall($1, $3); }
    ;

function_call_arguments
    : expression ',' function_call_arguments
        { $$ = [$1].concat($3); }
    | expression
        { $$ = [$1]; }
    ;

variable
    : identifier
        { $$ = $1; }
    | expression '.' IDENTIFIER
        { $$ = yy.makeBinaryOp($2, $1, $3); }
    | expression '[' expression ']'
        { $$ = yy.makeIndex($1, [$3]); }
    | expression '[' expression ',' expression ']'
        { $$ = yy.makeIndex($1, [$3, $5]); }
    ;

/*
  Only used for lvalues (variables above)
  subscripting, property access, & bare identifiers
 */
identifier
    : IDENTIFIER
        { $$ = yy.makeIdentifier(yytext); }
    | GLOBAL '.' IDENTIFIER
        { $$ = yy.makeGlobalIdentifier(yytext); }
    ;
