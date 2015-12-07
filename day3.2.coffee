process.stdin.setEncoding 'utf8'

house = {}

numSantes = 2
current = 0

x = [ 0, 0 ]
y = [ 0, 0 ]

house[0 + '.' + 0] = true

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('').forEach (chr) ->
	  		switch chr 
	  			when '^' then y[current] -= 1
	  			when '<' then x[current] -= 1
	  			when 'v' then y[current] += 1
	  			when '>' then x[current] += 1

	  		pos = x[current] + '.' + y[current]

	  		house[pos] = true
	  		current = (current + 1) % numSantes

process.stdin.on 'end', ->
	console.log Object.keys(house).length