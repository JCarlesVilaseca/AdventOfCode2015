Array.prototype.last = ()-> 
	if this.length then this[this.length-1] else null
 
ArrayCreate = (length)->
	Array.apply(null, Array(length))

group = (prev,item)->
	if prev.last() and prev.last()[0] is item
		prev.last().push item
	else
		prev.push [item]
	return prev

say = (prev, item)->
	(prev + item.length) + item[0]

solve = (input)->
	input.split('').reduce(group,[]).reduce(say,'')

sequence = '1113122113'

iteration = 1
start = new Date().getTime()

while true
	sequence = solve(sequence)

	end = new Date().getTime()

	time = end - start

	console.log "#{iteration++}: #{sequence.length} (#{time/1000}s)"