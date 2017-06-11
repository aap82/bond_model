import getenv from 'getenv'
import { graphqlKoa, graphiqlKoa  } from 'graphql-server-koa'
import graphQLoptions from '../graphql'
import Router from 'koa-router'

export graphql = new Router


graphql.post('/graphql', graphqlKoa(graphQLoptions))
graphql.get('/graphql', graphqlKoa(graphQLoptions))



if getenv('NODE_ENV') is 'development'
  graphql.get('/graphiql', graphiqlKoa({ endpointURL: '/graphql'}))


