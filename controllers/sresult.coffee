render=require '../config/render'
config=require '../config' 

exports.main=->
    data={} 
    data.title='搜索结果' 
    data.main=config.mainAssets
    
    render('sresult' ,data) 