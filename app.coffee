loadmd=require './common/loadmodules'
log=require 'koa-logger'
route=require 'koa-route'
parse=require 'co-body'
koa=require 'koa'

app=koa()
#app.use log()

#------------below is router set-------------------
app.use(require('koa-static')(__dirname+'/public'))

mod=loadmd.loadmodules(__dirname+'/controllers','.js')
control=(para)->
	#this.body='i love you'	
	this.body=yield mod[para][para]()	 

app.use route.get('/:para', control)
app.use((next)->
	this.body='you can browser the page of "/shiyi"'
	yield next
	)
#+++++++++++++++++++++++++++++++++++++++++++++++++++
app.listen(3000)
console.log 'listening on port 3000'
