grammar FeatherweightJavaScript;


@header { package edu.sjsu.fwjs.parser; }

// Reserved words
IF        : 'if' ;
ELSE      : 'else' ;
WHILE     : 'while' ;              // <--
FUNCTION  : 'function' ;              // <-- 
VAR       : 'var' ;              // <--
PRINT     : 'print' ;              // <--

// Literals
INT       : [1-9][0-9]* | '0' ;
BOOL      : 'true' | 'false' ;              // <-- 
NULL      : 'null' ;               // <--

// Symbols
MUL       : '*' ;
DIV       : '/' ;
SEPARATOR : ';' ;

// added more symbols
ADD       : '+' ;
SUB       : '-' ;
MOD       : '%' ;
GT        : '>' ;
LT        : '<' ;
GE        : '>=' ;
LE        : '<=' ;
EQUAL     : '==' ;

//rules for variable names
ID        : [a-zA-Z_][a-zA-Z0-9_]* ;                 // <-- 

// Whitespace and comments
NEWLINE   : '\r'? '\n' | '\r\n' | '\n' -> skip ;                    // <--  added the | '\r\n' | '\n' part
LINE_COMMENT  : '//' ~[\n\r]* -> skip ;
WS            : [ \t]+ -> skip ; // ignore whitespace
BLOCK_COMMENT : '/*' (.)*? '*/' -> skip                        // <-- 

// ***Parsing rules ***

/** The start rule */
prog: stat+ ;

stat: expr SEPARATOR                                    # bareExpr
    | IF '(' expr ')' block ELSE block                  # ifThenElse
    | IF '(' expr ')' block                             # ifThen
    ;

expr: expr op=( '*' | '/' | '%' ) expr                  # MulDivMod
    | INT                                               # int
    | '(' expr ')'                                      # parens
    ;

block: '{' stat* '}'                                    # fullBlock
     | stat                                             # simpBlock
     ;
