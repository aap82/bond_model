import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import GQL from './gql'


class AppStore
  constructor: (gqlFetch) ->
    @gql = new GQL(@, gqlFetch)
    extendObservable @, {
      openForm: null
      toolbar:
        popupID: null
        openPopup: action('Open Popup', (e, d) => @toolbar.popupID = d.id if !d.open)
        closePopups: action('Closing Popups', => @toolbar.popupID = null)

      openToolBarOpenForm: action('Close Toolbar OpenForm', ((id) -> @toolbarOpenForm = id))
      closeToolBarOpenForm: action('Close Toolbar OpenForm', -> @toolbarOpenForm = null)
      isModelOpen: no
    }





export default AppStore

