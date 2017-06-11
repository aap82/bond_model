import 'utils/wrappers'
import AppStore from 'stores/AppStore'
import DealForm from 'models/deal/form'
import Forms from 'models/forms'
import Modal from 'stores/Modal'
import Actions from 'models/actions'
import ModelsStore from 'stores/ViewStores/Models'
import PopOutWindowStore from 'stores/ViewStores/PopoutWindow'

export configureStores = (gqlFetch, routingStore) ->


  appStore = new AppStore(gqlFetch, DealForm)
  return {
    app: appStore
    popOutStore: PopOutWindowStore
    actions: new Actions(appStore.gql)
    forms: Forms
    models: ModelsStore
    routing: routingStore
    modal: Modal
  }













