
#database
exports.docName=['my1','my2']
exports.dburl='mongodb://localhost:27017/ssearch'

#client assets
mainAssets=exports.mainAssets={}
mainAssets.headerjs=[
	'/jquery/dist/jquery.min.js'
    '/js/avalon/avalon.mobile.min.js'
    '/bootstrap/dist/js/bootstrap.min.js'    
]

mainAssets.footerjs=[]

mainAssets.css=[
    '/bootstrap/dist/css/bootstrap.min.css'    
    '/bootstrap/dist/css/bootstrap-theme.min.css'
]