loadmd=require '../common/loadmodules'
config=require './index'
#------------load router moudle--------------------------

mod=loadmd.loadModules(config.rootpath+'/controllers','.js')
mood=loadmd.loadDeepModules(config.rootpath+'/controllers','.js')

exports.main=(next)->
    this.body=yield mod['login'].main()
    yield next
exports.control1=(para)->
    if !mod[para]
        this.body='page no found'        
    else
        this.body=yield mod[para].main()
exports.control2=(para1,para2)->
    if !mood[para2]
        this.body='page no found'        
    else
        this.body=yield mood[para2].main()