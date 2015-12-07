parser = require './day7.1.parser.js'

process.stdin.setEncoding 'utf8'

instructions = []

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		instructions = parser.parse(chunk)

process.stdin.on 'end', ->
	instructions['b'] = 
		op: '='
		term: 3176 # from solve(a)
		
	console.log solve('a')


solve = (wire)->
	exp = instructions[wire]

	switch exp.op
		when '=' then value = solveTerm exp.term
			
		when '&', '|', '<', '>'
			t1 = solveTerm exp.term1
			t2 = solveTerm exp.term2
			value = binary exp.op, t1, t2
			
		when '-'
			t1 = solveTerm exp.term
			value = Math.pow(2, 16) + ~t1

		else throw "Invalid operation"

	
	instructions[wire] = 
		op: '='
		term: value
		wire: wire

	return value

solveTerm = (term)->
	if typeof term is 'number' then term else solve term

binary = (op, term1, term2)->
	switch op
		when '&' then value = term1 & term2
		when '|' then value = term1 | term2
		when '<' then value = term1 << term2
		when '>' then value = term1 >> term2

	throw "overflow" if value < 0 or value > 65535
	return value