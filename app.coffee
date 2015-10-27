log=require 'koa-logger'
route=require 'koa-route'
parse=require 'co-body'
koa=require 'koa'
config= require './config/config'
config.rootpath=__dirname
setroute= require './config/setroute'
mongo = require './config/mongo'
co= require 'co'

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++
co(mongo.connect()) #connect to the database
app=koa()
#app.use log()

#------------below is router set-------------------
app.use(require('koa-static')(__dirname+'/public'))

app.use route.get('/:para', setroute.control1)
app.use route.get('/:para1/:para2', setroute.control2)
app.use route.get('/', setroute.main)
#+++++++++++++++++++++++++++++++++++++++++++++++++++
app.listen(3000)
console.log 'listening on port 3000'
