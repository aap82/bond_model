composeWithMongoose = require('graphql-compose-mongoose').default
LoanDetail = require './mongoose'


module.exports = composeWithMongoose(LoanDetail)