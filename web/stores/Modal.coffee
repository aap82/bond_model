import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'

class Modal
  constructor: ->
    extendObservable @, {
      isOpen: no
      component: null
      header: ''
      closeModal: action('closing modal', (-> @isOpen = no))



    }




modal = new Modal


export default modal

