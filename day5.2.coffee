process.stdin.setEncoding 'utf8'

nices = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			chars = line.split ''

			twice = between = false

			for i in [0..chars.length - 1]
				chr = chars[i]

				if not twice and i <= chars.length - 4
					part = line.substring i, i + 2

					twice = true if line.indexOf(part, i + 2) >= 0

				between = true if not between and i <= chars.length - 3 and chars[i] is chars[i+2]

				return nices++ if twice and between

process.stdin.on 'end', ->
	console.log nices