fs=require 'fs'
path=require 'path'
exports.loadmodules=(pathname,exten)->
	mod={}
	fs.readdirSync(pathname).forEach((file)->
		if(path.extname file)==exten
			console.log 'loading module '+file
			x=exten.length
			md=file[0...-x]
			mod[md]=require(pathname+'/'+file)
	)
	return mod 