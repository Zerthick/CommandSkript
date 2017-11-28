grammar CommandSkript;

@header {
package io.github.zerthick.commandskript;
}

script
    : block EOF
    ;

block
    : statement*
    ;

statement
    : assignment ';'
    | functionCall ';'
    | ifStatement
    | forStatement
    | whileStatement
    ;

assignment
    : Variable index? '=' expression    #variableAssignment
    | Constant '=' expression           #constantAssignment
    ;

functionCall
    : Print '(' expression ')'      #printFunctionCall
    | Check '(' expression ')'      #checkFunctionCall
    | Size '(' expression ')'       #sizeFunctionCall
    | ConsoleEx '(' exprList ')'    #consoleExFuntionCall
    | Execute '(' exprList ')'      #executeFuntionCall
    | Player '(' ')'                #playerFunctionCall
    | Rand '(' exprList ')'         #randFunctionCall
    | Round '(' expression ')'      #roundFunctionCall
    | Floor '(' expression ')'      #floorFunctionCall
    | Ceil '(' expression ')'       #ceilFunctionCall
    ;

ifStatement
    : ifStat elseIfStat* elseStat? End
    ;

ifStat
    : If expression Do block
    ;

elseIfStat
    : Else If expression Do block
    ;

elseStat
    : Else Do block
    ;

forStatement
    : For Variable '=' expression To expression Do block End
    ;

whileStatement
    : While expression Do block End
    ;

exprList
    : expression (',' expression)*
    ;

expression
    : '-' expression                           #unaryMinusExpression
    | '!' expression                           #notExpression
    | expression '^' expression                #powerExpression
    | expression '*' expression                #multiplyExpression
    | expression '/' expression                #divideExpression
    | expression '%' expression                #modulusExpression
    | expression '+' expression                #addExpression
    | expression '-' expression                #subtractExpression
    | expression '>=' expression               #gtEqExpression
    | expression '<=' expression               #ltEqExpression
    | expression '>' expression                #gtExpression
    | expression '<' expression                #ltExpression
    | expression '==' expression               #eqExpression
    | expression '!=' expression               #notEqExpression
    | expression '&&' expression               #andExpression
    | expression '||' expression               #orExpression
    | expression '?' expression ':' expression #ternaryExpression
    | expression In expression                 #inExpression
    | Number                                   #numberExpression
    | Bool                                     #boolExpression
    | Null                                     #nullExpression
    | functionCall                             #functionCallExpression
    | Variable index?                          #variableExpression
    | Constant index?                          #constantExpression
    | Special index?                           #specialExpression
    | String                                   #stringExpression
    | list index?                              #listExpression
    | '(' expression ')'                       #expressionExpression
    ;

list
    : '[' exprList? ']'
    ;

index
    : '[' expression ']'
    ;

Print       : 'print';
Check       : 'check';
Size        : 'size';
Player      : 'player';
Rand        : 'rand';
Round       : 'round';
Floor       : 'floor';
Ceil        : 'ceil';
Execute     : 'ex';
ConsoleEx   : 'qx';
If          : 'if';
Else        : 'else';
For         : 'for';
While       : 'while';
To          : 'to';
Do          : 'do';
End         : 'end';
In          : 'in';
Null        : 'null';

Or          : '||';
And         : '&&';
Equals      : '==';
NEquals     : '!=';
GTEquals    : '>=';
LTEquals    : '<=';
Pow         : '^';
Excl        : '!';
GT          : '>';
LT          : '<';
Add         : '+';
Subtract    : '-';
Multiply    : '*';
Divide      : '/';
Modulus     : '%';
OBrace      : '{';
CBrace      : '}';
OBracket    : '[';
CBracket    : ']';
OParen      : '(';
CParen      : ')';
SColon      : ';';
Assign      : '=';
Comma       : ',';
QMark       : '?';
Colon       : ':';

Bool
    : 'true'
    | 'false'
    ;

Number
    : Int ('.' Digit*)?
    ;

String
    : ['] (~['\r\n] | '\\\\' | '\\\'')* [']
    ;

Variable
    : [a-z] [a-zA-Z_0-9]*
    ;

Constant
    : [A-Z][a-zA-Z_0-9]*
    ;

Special
    : '$'[a-zA-Z_0-9]*
    ;

Comment
    : ('//' ~[\r\n]* | '/*' .*? '*/') -> skip
    ;

Space
    : [ \t\r\n\u000C] -> skip
    ;

fragment Int
    : [1-9] Digit*
    | '0'
    ;

fragment Digit
    : [0-9]
    ;