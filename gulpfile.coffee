gulp = require('gulp')
runSequence = require('run-sequence')
coffeelint=require ('gulp-coffeelint')
coffee = require('gulp-coffee')
gutil = require('gulp-util')
del = require('del')
nodemon = require('gulp-nodemon')
argv = require('yargs').argv
rename = require('gulp-rename')
browserSync = require('browser-sync')
reload = browserSync.reload

# 处理参数
isDebug = not (argv.r || false)

filepath={}
filepath.coffee=[  
  '*.coffee'
  'controllers/*.coffee'
  'common/*.coffee'
  'config/*.coffee'
]
filepath.js=[
  'dist/**/*.js'
  '!dist/public/**'
]

# --入口任务-----------------------------------------------------------------
gulp.task('default', (callback)->
  runSequence(
    ['clean']
    ['validate-coffee','coffee-server', 'copy-data', 'copy-client', 'coffee-client', 'copy-views']
    'serve'
    ['browserSync', 'watch']
    callback
  )
)
# --构建相关任务---------------------------------------
gulp.task('clean', (callback)->
  del(['./dist/'], callback)
)

gulp.task('validate-coffee', ->
  gulp.src(filepath.coffee)
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
)

gulp.task('coffee-server', ->
  gulp.src([
    'app.coffee'       
  ])
  .pipe(coffee({bare: true}).on('error', gutil.log))
  .pipe(gulp.dest('./dist/'))

  gulp.src([
    'controllers/*.coffee'
    ])
  .pipe(coffee({bare: true}).on('error', gutil.log))
  .pipe(gulp.dest('./dist/controllers/'))

  gulp.src([
    'config/*.coffee'
    ])
  .pipe(coffee({bare: true}).on('error', gutil.log))
  .pipe(gulp.dest('./dist/config/'))

  gulp.src([
    'common/*.coffee'
    ])
  .pipe(coffee({bare: true}).on('error', gutil.log))
  .pipe(gulp.dest('./dist/common/'))
)

gulp.task('copy-data', ->
  gulp.src([    
    'database/*.*'
  ])
  .pipe(gulp.dest('./dist/database/'))
)

gulp.task('copy-client', ->
  gulp.src([
    'public/**/*'
    'public/*'
  ])
  .pipe(gulp.dest('./dist/public/'))
)

gulp.task('coffee-client', ->
  gulp.src([
    'public/script/*.coffee'
  ])
  .pipe(coffee({bare: true}).on('error', gutil.log))
  .pipe(gulp.dest('./dist/public/js/'))
)

gulp.task('copy-views', ->
  gulp.src([    
    'views/*.html'
    ])
   .pipe(gulp.dest('./dist/views/'))
)


# --启动程序,打开浏览器任务----------------------------------------------------
nodemon_instance = undefined
gulp.task('serve', (callback)->
  called = false
  if not nodemon_instance
    nodemon_instance = nodemon({
      script: './dist/app.js'
      ext: 'none'
      execMap: 'js':'node --harmony'    
    })
    .on('restart', ->
      console.log('restart server......................')
    )
    .on('start', ->
      if not called
        called = true
        callback()
    )
  else
    nodemon_instance.emit("restart")
    callback()
  nodemon_instance
)

gulp.task('browserSync', ->
  browserSync({
    proxy: 'localhost:3000'
    port: 8888
  #files: ['./src/public/**/*']
    open: true
    notify: true
    reloadDelay: 500 # 延迟刷新
  })
)



# --监视任务------------------------------------------------
gulp.task('watch', ->
  gulp.watch([
    'views/*.*'
    'public/**/*'
  ], ['reload-client'])
  gulp.watch(filepath.coffee, ['reload-server'])
  gulp.watch(filepath.js, ['reload-server'])
)

gulp.task('reload-client', (callback) ->
  runSequence(    
    ['copy-client', 'coffee-client', 'copy-views']
    'bs-reload'
    callback
  )
)

gulp.task('reload-server', (callback) ->
  runSequence(    
    ['copy-data', 'validate-coffee','coffee-server']
    'serve'
    'bs-reload'
    callback
  )
)

gulp.task('bs-reload', ->
  browserSync.reload()
)
