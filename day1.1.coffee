process.stdin.setEncoding 'utf8'

floor = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('').forEach (chr) ->
			floor++ if chr is '('
			floor-- if chr is ')'

process.stdin.on 'end', ->
	console.log floor