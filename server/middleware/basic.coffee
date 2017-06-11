#async = require('asyncawait/async')
#awaits = require('asyncawait/await')
import compose from 'koa-compose'

import compress from 'koa-compress'


export baseErrorHandling = ->
  (ctx, next) =>
    try
      await next()
    catch err
      console.error "BASE ERROR HANDLING: #{err.name} : #{err.message}"
      ctx.body = { name: err.name, message: err.message, stack: err.stack }
      ctx.status = err.status or 500



export compressResponse = ->
  return compress()

#mount = require  'koa-mount'
#serve = require  'koa-static'
#paths = require '../../config/paths'
#
#exports.serveStaticFiles = (env) ->
#  static_files = [mount '/public', serve(paths.publicFiles)]
#  static_files.push mount('/', serve(paths.prodBuild)) if env is 'production'
#  return compose(static_files)

