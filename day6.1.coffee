process.stdin.setEncoding 'utf8'

grid = []

WIDTH = 1000
HEIGHT = 1000

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			turnOnExp  = /turn on (\d+)\,(\d+) through (\d+)\,(\d+)/g
			turnOffExp = /turn off (\d+)\,(\d+) through (\d+)\,(\d+)/g
			toggleExp = /toggle (\d+)\,(\d+) through (\d+)\,(\d+)/g

			turnOn = turnOnExp.exec line
			turnOff = turnOffExp.exec line
			toggle = toggleExp.exec line

			turnOnFn(parseInt(turnOn[1]),parseInt(turnOn[2]),parseInt(turnOn[3]),parseInt(turnOn[4])) if turnOn
			turnOffFn(parseInt(turnOff[1]),parseInt(turnOff[2]),parseInt(turnOff[3]),parseInt(turnOff[4])) if turnOff
			toggleFn(parseInt(toggle[1]),parseInt(toggle[2]),parseInt(toggle[3]),parseInt(toggle[4])) if toggle

process.stdin.on 'end', ->
	ons = 0
	for y in [0..HEIGHT-1]
		for x in [0..WIDTH-1]
			ons++ if grid[y * WIDTH + x] is true

	console.log ons		

turnOnFn = (y1,x1,y2,x2)->
	for y in [y1..y2]
		for x in [x1..x2]
			coord = y * WIDTH + x
			grid[coord] = true

turnOffFn = (y1,x1,y2,x2)->
	for y in [y1..y2]
		for x in [x1..x2]
			coord = y * WIDTH + x
			grid[coord] = false

toggleFn = (y1,x1,y2,x2)->
	for y in [y1..y2]
		for x in [x1..x2]
			coord = y * WIDTH + x

			grid[coord] = if grid[coord] then false else true