# Some standard functional helpers
# ------------------------------------

Array.prototype.find = (filter)->
	for i in [0..this.length-1]
		return i if filter(this[i], i, this)
	-1

Array.prototype.findLast = (filter)->
	for i in [this.length-1..0]
		return i if filter(this[i], i, this)
	-1

Array.prototype.exist = (filter)-> 
	this.find(filter) isnt -1


String.prototype.sliding = (count)->
	result = []
	for i in [0..this.length-3]
		slide = []
		for c in [i..i+count-1]
			slide.push this.charAt(c)
		result.push slide
	result

isPair = (chr,pos,str)->
	return pos < str.length-1 && str.charAt(pos+1) is chr

String.prototype.findLast = (fn)->
	for i in [this.length-1..0]
		return i if fn(this[i], i, this)
	-1

String.prototype.find = (fn)->
	for i in [0..this.length-1]
		return i if fn(this[i], i, this)
	-1

# Problem specific helpers
# ------------------------------------

addOne = (str)-> 
	for i in [str.length-1..0]
		if str.charAt(i) is 'z'
			str = str.substr(0, i) + 'a' + str.substr(i+1)
		else
			return str.substr(0, i) + String.fromCharCode(str.charAt(i).charCodeAt(0)+1) + str.substr(i+1)

String.prototype.hasTwoPairs = ()->
	lastPair = this.findLast(isPair)
	return false if lastPair is -1
	
	firstPair = this.find(isPair)

	return lastPair - firstPair > 1

sequence = (arr)->
	first = arr[0].charCodeAt(0)
	for i in [1..arr.length-1]
		return false if arr[i].charCodeAt(0) isnt first + i
	return true

# Solver 
# ------------------------------------

nextPassword = (pwd)->
	while true
		pwd = addOne(pwd)
		if not /[iol]/.test(pwd) and pwd.sliding(3).exist(sequence) and pwd.hasTwoPairs()
			return pwd

# Main
# ------------------------------------

next = nextPassword('vzbxkghb')

console.log next
console.log nextPassword(next)