getenv = require('getenv')
{ graphqlKoa, graphiqlKoa  } = require 'graphql-server-koa'
graphQLoptions = require '../graphql'





Router = require 'koa-router'

graphql = new Router


graphql.post('/graphql', graphqlKoa(graphQLoptions))
graphql.get('/graphql', graphqlKoa(graphQLoptions))



if getenv('NODE_ENV') is 'development'
  graphql.get('/graphiql', graphiqlKoa({ endpointURL: '/graphql'}))


module.exports = graphql