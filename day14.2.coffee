process.stdin.setEncoding 'utf8'

reindeers = []

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			exp = /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./
			parts = exp.exec line

			name = parts[1]

			reindeers[name] = 
				kms: parseInt(parts[2])
				secs: parseInt(parts[3])
				rest: parseInt(parts[4])
				distance: 0
				points: 0

process.stdin.on 'end', ->
	console.log solve(2503, reindeers)

solve = (seconds, reinders)->
	for second in [0..seconds-1]

		bestDistance = 0

		for name of reindeers
			reindeer = reindeers[name]

			state = second % (reindeer.secs + reindeer.rest)

			if state < reindeer.secs
				reindeer.distance += reindeer.kms

			bestDistance = Math.max(bestDistance, reindeer.distance)

		for name of reindeers
			reindeer = reindeers[name]
			reindeer.points += 1 if reindeer.distance is bestDistance

	return Object.keys(reindeers).reduce( (best, name) -> 
		return Math.max(best,reindeers[name].points)
	,0)