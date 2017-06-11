require('dotenv').config()
require('./mongoose')
import getenv from 'getenv'

SERVER_HOST = getenv 'SERVER_HOST'
SERVER_PORT = getenv 'SERVER_PORT'



import koa from 'koa'
import koaBody from 'koa-bodyparser'
import { baseErrorHandling  } from './middleware/basic'
import {graphql} from './graphql'


app = new koa()
app.use koaBody()

app.use baseErrorHandling()
app.use graphql.routes()
app.use graphql.allowedMethods()

app.listen(SERVER_PORT)