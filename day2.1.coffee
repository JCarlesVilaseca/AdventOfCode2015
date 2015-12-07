process.stdin.setEncoding 'utf8'

paper = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			paper += solvePaper line

process.stdin.on 'end', ->
	console.log paper


solvePaper = (line) ->
	dimensions = line.split 'x'

	[ width, height, deep ] = [ parseInt(dimensions[0]), parseInt(dimensions[1]), parseInt(dimensions[2]) ]

	l1 = width * height
	l2 = width * deep
	l3 = height * deep

	min = Math.min l1, Math.min(l2, l3)

	return (l1*2 + l2*2 + l3*2) + min