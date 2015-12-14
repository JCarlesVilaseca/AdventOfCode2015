process.stdin.setEncoding 'utf8'

best = 0

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			exp = /\w+ can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./
			parts = exp.exec line

			kms = parseInt(parts[1])
			secs = parseInt(parts[2])
			rest = parseInt(parts[3])

			best = Math.max(best, distance(2503, kms, secs, rest))

process.stdin.on 'end', ->
	console.log best

distance = (total, kms, secs, rest)->
	completeRuns = Math.floor(total / (secs + rest))

	remainder = Math.min(secs, total - completeRuns * (secs + rest))

	(completeRuns * secs  + remainder) * kms