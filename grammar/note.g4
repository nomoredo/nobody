grammar note;
//Parser rules
script             : (task | statement| comment)* EOF ;
task               : 'task' taskIdentifier taskBody ;
identifier         : ID (PIPE ID)* ;
parameter     : '[' identifier? (PARAM) (EQUAL valuetype)? ']' ;
taskIdentifier     : identifier (identifier | parameter)* ;
variableDeclaration: LET ID EQUAL expression ;
taskBody           : '{' (statement)* '}' ;
statement          : command | loopStatement | conditionalStatement | variableDeclaration ;
command            : ID (argument)* ;
argument           : DEXP | ID | STRING | NUMBER ;
loopStatement      : FOR ID IN valuetype taskBody ;
conditionalStatement : IF condition taskBody (ELSE taskBody)? ;
condition           : idtype OPERATOR valuetype ;
expression         : valuetype (OPEXP valuetype)* ;
idtype            : ID | DEXP ;
valuetype         : NUMBER | STRING | list  | ID | DEXP ;
list               : '[' (valuetype (COMMA valuetype)*)? ']' ;
comment            : COMMENT ;

// Existing lexer rules...
COMMENT: '//' .*? LB;
PARAM: ':' ID;
DEXP : '$' ID;
PIPE: '|';
LET: 'let';
IN: 'in';
FOR: 'for';
IF: 'if';
ELSE: 'else';
COMMA: ',';
EQUAL: '=';
STRING: '"' .*? '"';
NUMBER: [0-9]+;
ID: [a-zA-Z_][a-zA-Z0-9_]*;
LB: [\r\n]+ -> skip;
WS: [ \t]+ -> skip;
OPERATOR: '==' | '!=' | '<' | '>' | '<=' | '>=';
OPEXP: '+' | '-' | '*' | '/';



/*


task wash [the:thing=car] [in | in the:place=house] {
    show "washing the $thing in the $place"
}

task show | display [:message] {
    print "$message"
}

let school = ["students", "teachers", "janitors"]

// Define a list of items
let fruits = ["apple", "banana", "cherry"]

// Task to list all items
task list_items [from:collection=fruits] {
    for $item in $collection {
        show "Item: $item"
    }
}

// Display message
task show [:message] {
    print "$message"
}

// Usage
list_items // outputs: Item: apple, Item: banana, Item: cherry

// Task to display weather condition
task weather [is:condition=sunny] {
    if $condition == sunny {
        show "It's a bright sunny day!"
    } else {
        show "It's not sunny today."
    }
}

// Show message
task show [:message] {
    print "$message"
}

// Usage
weather // outputs: It's a bright sunny day!
weather is:rainy // outputs: It's not sunny today.

// Task for adding two numbers
task add [num1:number=0] [num2:number=0] {
    let result = $num1 + $num2
    show "Result: $result"
}

// Display message
task show [:message] {
    print "$message"
}

// Usage
add num1:5 num2:3 // outputs: Result: 8

task summer [is:status=here] {
    if $status == here {
        show "summer is here"
    } else {
        show "summer is not here"
    }
}

task call everyone [from:place=school] {
    for $person in $place {
        show "calling $person"
    }
}

*/

//Parser rules
