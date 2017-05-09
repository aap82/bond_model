import AppStore from 'stores/AppStore'
import DealForm from 'models/deal/form'
import Forms from 'models/forms'
import Modal from 'stores/Modal'
import Actions from 'models/actions'
import Model from 'stores/Model'

export configureStores = (gqlFetch, routingStore) ->
  appStore = new AppStore(gqlFetch, DealForm)
  return {
    app: appStore
    actions: new Actions(appStore.gql)
    forms: Forms
    model: Model
    routing: routingStore
    modal: Modal
  }













