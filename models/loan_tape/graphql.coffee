composeWithMongoose = require('graphql-compose-mongoose').default
LoanTape = require './mongoose'

options = {}







module.exports = composeWithMongoose(LoanTape, options)