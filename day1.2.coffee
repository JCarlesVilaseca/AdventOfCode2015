process.stdin.setEncoding 'utf8'

floor = index = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		index = chunk.split('').findIndex (chr) ->
			floor++ if chr is '('
			floor-- if chr is ')'
		
			return floor is -1

process.stdin.on 'end', ->
	console.log index + 1 # First is 1