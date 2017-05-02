composeWithMongoose = require('graphql-compose-mongoose').default
DealSettings = require './mongoose'


module.exports = composeWithMongoose(DealSettings)