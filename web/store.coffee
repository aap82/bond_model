import TransportLayer from './stores/transport'
import { RouterStore, syncHistoryWithStore } from 'mobx-react-router';




export configureStores = (gqlFetch) ->
  return {
    routing: new RouterStore()
    gql: gqlFetch
  }













