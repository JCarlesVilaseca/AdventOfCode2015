{
	var instructions = [];
}

start
	= circuit { return instructions; }

circuit
	= instruction ( newline instruction ) *

instruction
	= exp:assignment 	{ instructions[exp.wire] = exp; }
	/ exp:unary			{ instructions[exp.wire] = exp; }
	/ exp:binary		{ instructions[exp.wire] = exp; }

assignment
	= number:number _ "->" _ wire:variable	{ return { op: '=', term: number, wire: wire }; }
	/ term:variable _ "->" _ wire:variable	{ return { op: '=', term: term, wire: wire }; }

unary
	= "NOT" _ term:variable _ "->" _ wire:variable	{ return { op: '-', term: term, wire: wire }; }

binary
	= term1:primary _ op:operator _ term2:primary _ "->" _ wire:variable { return { op: op, term1: term1, term2: term2, wire:wire }; }

operator
	= "AND" { return '&'; }
	/ "OR" { return '|'; }
	/ "LSHIFT" { return '<'; }
	/ "RSHIFT" { return '>'; }

primary
	= number
	/ variable

variable
	= variable:[a-z]+ { return variable.join(''); }

number
	= digits:[0-9]+ { return parseInt(digits.join('')); }

newline
	= [\r\n]
_
	= [ \t]*