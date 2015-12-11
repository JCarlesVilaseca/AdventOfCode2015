Immutable = require 'immutable'

process.stdin.setEncoding 'utf8'

locations = new Immutable.Set();
distances = []

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			exp  = /(\w+) to (\w+) = (\d+)/
			parts = exp.exec line

			locations = locations.add(parts[1])
			locations = locations.add(parts[2])

			distances["#{parts[1]}-#{parts[2]}"] = parseInt(parts[3])
			distances["#{parts[2]}-#{parts[1]}"] = parseInt(parts[3])


process.stdin.on 'end', ->
	console.log largest(locations,0,null)


largest = (locations,distance,origin)->
	return distance if locations.size is 0

	result = 0

	locations.forEach (location)->
		newDistance = if origin then distances["#{origin}-#{location}"] else 0
		result = Math.max(result, largest(locations.delete(location), newDistance + distance, location))

	return result