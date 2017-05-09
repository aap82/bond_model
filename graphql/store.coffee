{OperationStore} = require('graphql-server-module-operation-store')
{queries} = require '../models/graphql'
exports.init_store = (schema) =>
  store = new OperationStore(schema)
  store.put query for query in queries
  return store