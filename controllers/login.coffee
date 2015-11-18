render=require '../config/render'
config=require '../config' 

exports.main=->
    data={} 
    data.title='登录' 
    data.main=config.mainAssets
    data.question='密码前5位是：'    
    render('login' ,data)