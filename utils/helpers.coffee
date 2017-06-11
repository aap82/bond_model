

export objectWithProperties = (obj) ->
  if obj.properties
    Object.defineProperties obj, obj.properties
    delete obj.properties
  obj
