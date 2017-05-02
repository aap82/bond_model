require('dotenv').config()
require('./mongoose')
getenv = require('getenv')

SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'



koa = require('koa')
koaBody = require 'koa-bodyparser'
app = new koa()
app.use koaBody()


{ baseErrorHandling  } = require './middleware/basic'







app.use baseErrorHandling()

graphql = require './graphql'
app.use graphql.routes()
app.use graphql.allowedMethods()

app.listen(SERVER_PORT)