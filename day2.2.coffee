process.stdin.setEncoding 'utf8'

ribbon = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			ribbon += solveRibbon line

process.stdin.on 'end', ->
	console.log ribbon


solveRibbon = (line) ->
	dimensions = line.split 'x'

	[ width, height, deep ] = [ parseInt(dimensions[0]), parseInt(dimensions[1]), parseInt(dimensions[2]) ]

	wrap = Math.min width + height, Math.min( width + deep, height + deep )

	bow = width * height * deep

	return ( wrap * 2 ) + bow