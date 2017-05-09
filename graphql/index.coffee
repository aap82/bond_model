schema = require './schema'

{init_store} = require('./store')
store = init_store(schema)

module.exports =
  schema: schema
  formatParams: ((params) =>
    if params.operationName?
      params['query'] = store.get(params.operationName)
    return params)