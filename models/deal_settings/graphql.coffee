composeWithMongoose = require('graphql-compose-mongoose').default
DealSettings = require './mongoose'

exports = module.exports

exports.TC =
  DealSettingsTC: composeWithMongoose(DealSettings)