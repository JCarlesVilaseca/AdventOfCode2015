process.stdin.setEncoding 'utf8'

nices = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			chars = line.split ''

			vowels = 0
			repeat = false
			previous = 0

			for i in [0..chars.length - 1]
				chr = chars[i]

				vowels++ if chr is 'a' or chr is 'e' or chr is 'i' or chr is 'o' or chr is 'u'

				repeat = true if chr is previous

				return if (chr is 'b' and previous is 'a') or (chr is 'd' and previous is 'c') or (chr is 'q' and previous is 'p') or (chr is 'y' and previous is 'x')

				previous = chr
			
			nices++ if vowels >= 3 and repeat


process.stdin.on 'end', ->
	console.log nices