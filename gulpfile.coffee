gulp = require('gulp')
gulp.sass = require('gulp-sass')
gulp.jade = require('gulp-jade')
gulp.coffee = require('gulp-coffee')
gulp.concat = require('gulp-concat')
webserver = require('gulp-webserver')

gulp.task('vendor:js', ->
  gulp.src(['bower_components/jquery/dist/jquery.min.js'
    'bower_components/jquery/dist/jquery.min.map'
    'bower_components/bootstrap/dist/js/bootstrap.min.js'
    'bower_components/angular/angular.min.js'
    'bower_components/angular/angular.min.js.map'
    'bower_components/angular-route/angular-route.min.js'
    'bower_components/angular-route/angular-route.min.map'
    'bower_components/angular-ui-router/release/angular-ui-router.min.js'
    'bower_components/recorderjs/recorder.js'
    'bower_components/recorderjs/recorderWorker.js'
  ])
  .pipe(gulp.dest('www/vendor/scripts/'))
)

gulp.task('vendor:css', ->
  gulp.src(['bower_components/bootstrap/dist/css/bootstrap.min.css'
    'bower_components/bootstrap/dist/fonts/*'
  ])
  .pipe(gulp.dest('www/vendor/stylesheets/'))
)

gulp.task('vendor:image', ->
  gulp.src([
    'src/images/**/*.png'
    'src/images/**/*.jpg'
    'src/images/**/*.jpeg'
    'src/images/**/*.gif'
  ])
  .pipe(gulp.dest('www/vendor/images/'))
)

gulp.task('vendor:audio', ->
  gulp.src([
    'src/audios/**/*.ogg'
  ])
  .pipe(gulp.dest('www/vendor/audios/'))
)

gulp.task('vendor:src_js', ->
  gulp.src(['src/scripts/javascripts/**/*.js'])
  .pipe(gulp.dest('www/vendor/scripts/'))
)

gulp.task('vendor:source', ['vendor:image', 'vendor:audio', 'vendor:src_js'])
gulp.task('vendor', ['vendor:css', 'vendor:js', 'vendor:source'])

gulp.task('scss', ->
  gulp.src(['src/stylesheets/style.scss'])
    .pipe(gulp.sass())
    .pipe(gulp.dest('www/vendor/stylesheets/'))
)

gulp.task('coffee', ->
  gulp.src([
    'src/scripts/no-ng/**/*.coffee'
    'src/scripts/app.coffee'
    'src/scripts/global/**/*.coffee'
    'src/scripts/factories/**/*.coffee'
    'src/scripts/directives/**/*.coffee'
    'src/scripts/modules/**/*.coffee'
  ])
    .pipe(gulp.concat('script.coffee'))
    .pipe(gulp.coffee())
    .pipe(gulp.dest('www/vendor/scripts/'))
)

gulp.task('jade', ->
  gulp.src(['src/**/*.jade'])
    .pipe(gulp.jade())
    .pipe(gulp.dest('www/'))
)

gulp.task('watch:coffee', ['coffee'], ->
  gulp.watch(['src/scripts/**/*.coffee'], ['coffee'])
)
gulp.task('watch:jade', ['jade'], ->
  gulp.watch(['src/**/*.jade'], ['jade'])
)
gulp.task('watch:scss', ['scss'], ->
  gulp.watch(['src/stylesheets/**/*.scss'], ['scss'])
)

gulp.task('server', ->
  gulp.src(['./www/'])
    .pipe(webserver({
      port: 8088,#端口
      host: 'localhost',#域名
      liveload: true,#实时刷新代码。不用f5刷新
      directoryListing: {
        path: './www/',
        enable: true,
        open: true,
        fallback: 'index.html'
        }
      })))

gulp.task('watch', ['vendor', 'watch:coffee', 'watch:jade', 'watch:scss'])
gulp.task('deploy', ['vendor', 'coffee', 'scss', 'jade'])
gulp.task('deploy_src', ['vendor:source', 'coffee', 'scss', 'jade'])

gulp.task('default', ['watch','server'])
