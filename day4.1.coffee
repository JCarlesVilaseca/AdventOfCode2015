crypto = require('crypto')

secret = 'ckczppom'

for num in [0..Infinity]
	md5 = crypto.createHash('md5')

	hash = md5.update(secret + num).digest 'binary'

	break if hash.charCodeAt(0) is 0 and hash.charCodeAt(1) is 0 and hash.charCodeAt(2) < 0x10  

console.log num