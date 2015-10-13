gulp = require('gulp')
runSequence = require('run-sequence')

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

# --入口任务-----------------------------------------------------------------
gulp.task('default', (callback)->
  runSequence(
    ['clean']
    ['coffee-server', 'copy-server', 'copy-client', 'coffee-client', 'copy-views']
    'serve'
    ['browserSync', 'watch']
    callback
  )
)
# --构建相关任务---------------------------------------
gulp.task('clean', (callback)->
  del(['./dist/'], callback)
)

gulp.task('coffee-server', ->
  gulp.src([
    './src/**/*.coffee'
    '!./src/public/**/*.coffee'
    '!./src/views/**'
  ])
  .pipe(coffee({bare: true}).on('error', gutil.log))
  .pipe(gulp.dest('./dist/'))
)

gulp.task('copy-server', ->
  gulp.src([
    './src/config*/*.json'
    './src/database*/*.*'
  ])
  .pipe(gulp.dest('./dist/'))
)

gulp.task('copy-client', ->
  gulp.src([
    './src/public*/**/*'
    '!./src/public*/**/*.coffee'
  ])
  .pipe(gulp.dest('./dist/'))
)

gulp.task('coffee-client', ->
  gulp.src([
    './src/public*/**/*.coffee'
  ])
  .pipe(coffee({bare: true}).on('error', gutil.log))
  .pipe(gulp.dest('./dist/'))
)

gulp.task('copy-views', ->
  gulp.src('./src/views/**/*.html')
  .pipe(rename({extname: '.vash'}))
  .pipe(gulp.dest('./dist/views'))
)


# --启动程序,打开浏览器任务----------------------------------------------------
nodemon_instance = undefined
gulp.task('serve', (callback)->
  called = false
  if not nodemon_instance
    nodemon_instance = nodemon({
      script: './dist/index.js'
      ext: 'none'
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
    './src/**/*.*'
    '!./src/**/*.coffee'
  ], ['reload-client'])
  gulp.watch('./src/**/*.coffee', ['reload-server'])
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
    ['copy-server', 'coffee-server']
    'serve'
    'bs-reload'
    callback
  )
)

gulp.task('bs-reload', ->
  browserSync.reload()
)
