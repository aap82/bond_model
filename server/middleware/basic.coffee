async = require('asyncawait/async')
awaits = require('asyncawait/await')
compose = require  'koa-compose'

compress = require  'koa-compress'


exports.baseErrorHandling = ->
  async (ctx, next) =>
    try
      awaits next()
    catch err
      console.error "BASE ERROR HANDLING: #{err.name} : #{err.message}"
      ctx.body = { name: err.name, message: err.message, stack: err.stack }
      ctx.status = err.status or 500



exports.compressResponse = ->
  return compress()

#mount = require  'koa-mount'
#serve = require  'koa-static'
#paths = require '../../config/paths'
#
#exports.serveStaticFiles = (env) ->
#  static_files = [mount '/public', serve(paths.publicFiles)]
#  static_files.push mount('/', serve(paths.prodBuild)) if env is 'production'
#  return compose(static_files)

