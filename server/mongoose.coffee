getenv = require('getenv')
models = require('../models/mongoose')
mongoose = require('mongoose')
promise = require('bluebird')

mongoose.Promise = promise


mongoose.connect getenv('MONGO_DB')