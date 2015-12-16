process.stdin.setEncoding 'utf8'

sues = []

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			exp = /Sue (\d+): (.*)/
			parts = exp.exec line

			sue = 
				number: parseInt(parts[1])
				compounds: parts[2].split(', ').reduce (acum,item)->
					exp = /(\w+): (\d+)/
					parts = exp.exec item
					acum[parts[1]] = parseInt parts[2]
					return acum
				, {}

			sues.push sue

process.stdin.on 'end', ->
	console.log solve(
		children: 3
		cats: 7
		samoyeds: 2
		pomeranians: 3
		akitas: 0
		vizslas: 0
		goldfish: 5
		trees: 3
		cars: 2
		perfumes: 1
	, sues)

Array.prototype.all = (func)->
	for elem in this
		return false if not func(elem)
	true

Array.prototype.first = (func)->
	for elem in this
		return elem if func(elem)
	null

solve = (match, sues)->
	return sues.first (sue)->
		names = Object.keys(sue.compounds)

		return true if names.all (name)->
			sue.compounds[name] == match[name]
		false