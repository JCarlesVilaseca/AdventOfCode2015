process.stdin.setEncoding 'utf8'

diff = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			state = 'start'

			line.split('').forEach (chr)->

				switch state
					when 'start'
						switch chr
							when '"' then state = 'chars'
							else throw 'Syntax error'
					when 'chars'
						switch chr
							when '\\' then state = 'backslash'
							when '"' then state = 'end'
							else diff--
					when 'backslash'
						switch chr
							when '\\', '\"'
								state = 'chars'
								diff--
							when 'x'
								state = 'hex1'
							else throw 'Syntax error'
					when 'hex1'
						switch
							when /[0-9a-f]/i.test(chr)
								state = 'hex2'
							else throw 'Syntax error'
					when 'hex2'
						switch
							when /[0-9a-f]/i.test(chr)
								state = 'chars'
								diff--
							else throw 'Syntax error'
					when 'end' then throw 'Syntax error'

			throw 'Syntax error' if state isnt 'end'

			diff += line.length

process.stdin.on 'end', ->
	console.log diff