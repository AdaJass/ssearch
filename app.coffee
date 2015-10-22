loadmd=require './common/loadmodules'
log=require 'koa-logger'
route=require 'koa-route'
parse=require 'co-body'
koa=require 'koa'
setroute= require './config/setroute'
#------------load router moudle--------------------------
mod=loadmd.loadModules(__dirname+'/controllers','.js')
mood=loadmd.loadDeepModules(__dirname+'/controllers','.js')
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++
app=koa()
#app.use log()

#------------below is router set-------------------
app.use(require('koa-static')(__dirname+'/public'))

app.use route.get('/:para', setroute.control1)
app.use route.get('/:para1/:para2', setroute.control2)
app.use route.get('/', setroute.index)
#+++++++++++++++++++++++++++++++++++++++++++++++++++
app.listen(3000)
console.log 'listening on port 3000'
