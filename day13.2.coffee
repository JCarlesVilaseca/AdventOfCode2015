Immutable = require 'immutable'

process.stdin.setEncoding 'utf8'

attendees = new Immutable.Set();
happinessBetween = []

process.stdin.on 'readable', ->
	chunk = process.stdin.read()
  
	if chunk
		chunk.split('\n').forEach (line) ->
			exp = /(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)\./
			parts = exp.exec line

			attendees = attendees.add(parts[1])
			attendees = attendees.add(parts[4])

			happinessBetween["#{parts[1]}-#{parts[4]}"] = if parts[2] is 'gain' then parseInt(parts[3]) else -parseInt(parts[3])

process.stdin.on 'end', ->
	attendees = attendees.add 'me'
	console.log optimalArrangement(attendees,new Immutable.OrderedSet(),0,0)

getHappinessBetween = (from,to)->
	return 0 if from is 'me' or to is 'me'
	happinessBetween["#{from}-#{to}"]

optimalArrangement = (attendees,arrangement,acum,best)->
	if attendees.size is 0
		acum += getHappinessBetween arrangement.first(), arrangement.last()
		acum += getHappinessBetween arrangement.last(), arrangement.first()
		
		return Math.max(best, acum)

	attendees.forEach (attendee)->
		newArrangement = arrangement.add(attendee)

		newAcum = acum
		if arrangement.size
			newAcum += getHappinessBetween arrangement.last(), attendee
			newAcum += getHappinessBetween attendee, arrangement.last()

		best = Math.max(best, optimalArrangement(attendees.delete(attendee), newArrangement,newAcum,best))

	return best