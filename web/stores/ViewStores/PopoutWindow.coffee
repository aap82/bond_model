import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'


class PopOutWindow
  constructor: ({@id}) ->

    extendObservable @, {
      isOpen: no
      toggle: action(-> @isOpen = !@isOpen)
      open: action(-> @isOpen = yes)
      close: action(-> @isOpen = no)

    }






class PopOutWindowStore
  constructor: ->

    extendObservable @, {
      popOuts: observable.shallowMap {
        cashflowCollateral: new PopOutWindow(id: 'cashflowCollateral')
      }

      opened: computed(-> (popOut.isOpen for popOut in @popOuts.values()).length > 0)
      closeAll: action(-> popOut.close() for popOut in @popOuts.values())



    }







store = new PopOutWindowStore()
export default store