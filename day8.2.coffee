process.stdin.setEncoding 'utf8'

diff = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->

			line.split('').forEach (chr)->
				switch chr
					when '\"','\\' then diff += 2
					else diff++

			diff += 2 - line.length

process.stdin.on 'end', ->
	console.log diff