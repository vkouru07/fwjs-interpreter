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

function_definition : FUNCTION '(' definition_params ')' block 
	| FUNCTION '()' block ; 

function_call : FUNCTION '(' call_params ')' 
	| FUNCTION '()' 

definition_params : 
	| ID
	| ID ',' ID
	; 

call_params :
	| ID 
	| expr
	| param ',' param
	; 

var_declaration : 'var' assignment ; 
assignment : ID '=' expr ; 
var_reference : ID ; 

// added while, print, and seperator

stat: expr SEPARATOR                                    # bareExpr
    | IF '(' expr ')' block ELSE block                  # ifThenElse
    | IF '(' expr ')' block                             # ifThen
    | WHILE '(' expr ')' block                          # while
    | PRINT '(' expr ')' SEPARATOR?                     # print
    | SEPARATOR                                         # empty 
    ;

// added AddSub and compare
expr: expr op=( '*' | '/' | '%' ) expr                  # MulDivMod
    | expr op=( '+' | '-' ) expr                        # AddSub          
    | expr op=( '<' | '>' | '<=' | '>=' | '==' ) expr   # Compare
    | INT                                               # int
    | '(' expr ')'                                      # parens
	| function_definition								# functionDefinition
	| function_call										# functionCall
	| var_declaration									# variableDeclaration
	| var_reference										# variableReference
	| assignment										# assignment
    ;

block: '{' stat* '}'                                    # fullBlock
     | stat                                             # simpBlock
     ;





