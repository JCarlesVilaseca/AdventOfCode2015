process.stdin.setEncoding 'utf8'

house = {}

santa = 0

x = y = 0

house[0 + '.' + 0] = true

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('').forEach (chr) ->
	  		switch chr 
	  			when '^' then y -= 1
	  			when '<' then x -= 1
	  			when 'v' then y += 1
	  			when '>' then x += 1

	  		pos = x + '.' + y

	  		house[pos] = true

process.stdin.on 'end', ->
	console.log Object.keys(house).length