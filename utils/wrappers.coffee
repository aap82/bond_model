Function::getter = (prop, get) ->
  Object.defineProperty @prototype, prop, {get, configurable: yes}

