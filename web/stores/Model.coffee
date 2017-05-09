import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import {Deal} from 'models/deal/mobx'

class Model
  constructor: ->
    extendObservable @, {
      deal: new Deal()
      settings: null
      deals: []
      loans: []
      bonds: []


      loadDeal: action('Loading Deal', (deal) ->
        runInAction(=>
          @deal.update(deal)
          @settings = deal.settings
          @loans.replace(deal.loans)
          @bonds.replace(deal.bonds)
        )
      )
      closeDeal: action('Closing Deal', (deal) ->
        runInAction(=>
          @deal.reset()
          @settings = null
          @loans.clear()
          @bonds.clear()
        )
      )


    }



model = new Model()



export default model

