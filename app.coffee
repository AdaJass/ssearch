koa=require 'koa'
app=koa()
app.use(->
    
    this.body = 'Hello Sy.'
    yield [] 
)
app.listen(3000)
 
