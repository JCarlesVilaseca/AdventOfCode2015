process.stdin.setEncoding 'utf8'

ingredients = []

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			exp = /(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/
			parts = exp.exec line

			name = parts[1]

			ingredients[name] = 
				capacity: parseInt(parts[2])
				durability: parseInt(parts[3])
				flavor: parseInt(parts[4])
				texture: parseInt(parts[5])
				calories: parseInt(parts[6])

process.stdin.on 'end', ->
	console.log solve(100,ingredients)

Array.prototype.take = (x)->
	result = []
	for i in [0..x-1]
		result[i] = this[i]
	result

nextGuess = (guess)->
	for i in [guess.length-1..0]
		rest = guess.take(i).reduce( (p,x)-> 
			return p + x
		, 0)

		if guess[i] >= 100 - rest
			guess[i] = 0
		else
			guess[i] = guess[i] + 1

			return guess

	return null


solve = (qty, ingredients)->
	
	names = Object.keys(ingredients)
	guess = names.map( () -> 0)

	best = 0

	while guess

		capacity = durability = flavor = texture = 0

		for i in [0..names.length-1]
			ingredient = ingredients[names[i]]

			capacity += ingredient.capacity * guess[i]
			durability += ingredient.durability * guess[i]
			flavor += ingredient.flavor * guess[i]
			texture += ingredient.texture * guess[i]

		score = Math.max(0,capacity) * Math.max(0,durability) * Math.max(0,flavor) * Math.max(0,texture)

		best = Math.max(best, score)

		guess = nextGuess(guess)

	return best