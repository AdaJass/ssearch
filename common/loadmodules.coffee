fs=require 'fs'
path=require 'path'
exports.loadModules=(pathname,exten)->
    mod={}
    fs.readdirSync(pathname).forEach((file)->
        if(path.extname file)==exten
            console.log 'loading module '+file
            x=exten.length
            md=file[0...-x]
            mod[md]=require(pathname+'/'+file)
    )
    mod

exports.loadDeepModules=(pathname,exten)->
    mod={}
    fs.readdirSync(pathname).forEach((dir)->
        fs.stat(pathname+'/'+dir,(err,stat)->
            if(stat.isDirectory())
                fs.readdirSync(pathname+'/'+dir).forEach((file)->
                    if(path.extname file)==exten
                        console.log 'loading module '+dir+'/'+file
                        x=exten.length
                        md=file[0...-x]
                        mod[md]=require(pathname+'/'+dir+'/'+file)
                )
        )
    )    
    mod 