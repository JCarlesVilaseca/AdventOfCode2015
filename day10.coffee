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

solution1 = ArrayCreate(40).reduce(solve,'1113122113')

console.log solution1.length

console.log ArrayCreate(10).reduce(solve,solution1).length # 40 + 10 = 50