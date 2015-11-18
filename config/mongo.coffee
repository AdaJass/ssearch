'use strict'
###
 * MongoDB configuration using generators (with the help of co-mongo package).
 * You can require this config file in your controllers and start using named collections directly.
 * See /controllers directory for sample usage.
 ###

comongo = require('co-mongo')
connect = comongo.connect
config = require('./index')

#extending and exposing top co-mongo namespace like this is not optimal but it saves the user from one extra require();
module.exports = comongo;

#Opens a new connection to the mongo database, closing the existing one if exists. 
comongo.connect = ->    
    if (comongo.db) 
        yield comongo.db.close() 
    #export mongo db instance
    db = comongo.db = yield connect(config.dburl)
    # export default collections    
    for name in config.docName
        comongo[name] = yield db.collection(name)