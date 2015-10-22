exports.main=(next)->
    this.body='welcom to my page, you can browse "/shiyi" page'
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