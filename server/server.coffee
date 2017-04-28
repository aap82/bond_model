require('dotenv').config()
require('./mongoose')

getenv = require('getenv')

koa = require('koa')
koaBody = require 'koa-bodyparser'

SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'
GRAPHQL_ENDPOINT = getenv 'GRAPHQL_ENDPOINT'


gqlFetch = require('../utils/fetch')(GRAPHQL_ENDPOINT)


app = new koa()
app.context.fetch = gqlFetch

app.use koaBody()