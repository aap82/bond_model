getenv = require('getenv')
models = require('../models/mongoose')
mongoose = require('mongoose')
promise = require('bluebird')
MONGO_DB = getenv 'MONGO_DB'


mongoose.Promise = promise
mongoose.connect MONGO_DB