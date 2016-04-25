render=require '../config/render'
config=require '../config' 


exports.main=->
    data={}
    data.title='chatRoom'
    data.main=config.mainAssets
    render('chatRoom',data)