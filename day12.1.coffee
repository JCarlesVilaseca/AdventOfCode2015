process.stdin.setEncoding 'utf8'

sum = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			if line.length
				json = JSON.parse(line)
				sum = acum json

process.stdin.on 'end', ->
	console.log sum

acum = (obj)->
	switch
		when Number.isInteger(obj)
			return obj

		when Array.isArray(obj)
			return obj.reduce (a,b) ->
				a + acum(b)
			, 0 
				
		when typeof obj is 'object'
			res = 0
			for mbr of obj
				res += acum(obj[mbr])
			return res
		else
			return 0
