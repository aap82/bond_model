import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import {Deal} from 'models/deal/mobx'
import {TableColumn, Tables} from './tables/Tables'
import loanTableColumns from 'models/loan_tape/data_table'






class Model
  constructor: (loanTableColumns)->
    extendObservable @, {
      deal: new Deal()
      settings: null
      deals: []
      loans: []
      bonds: []


      loadDeal: action('Loading Deal', ((deal) ->
        runInAction(=>
          @deal.update(deal)
          @settings = deal.settings
          @loans.replace(deal.loans)
          @bonds.replace(deal.bonds)
        ))
      )
      closeDeal: action('Closing Deal', ((deal) ->
        runInAction(=>
          @deal.reset()
          @settings = null
          @loans.clear()
          @bonds.clear()
        ))
      )
    }

    @tables = new Tables({
      loans:
        columns: (new TableColumn(key, column) for key, column of loanTableColumns)
        rows: @loans
    })



model = new Model(loanTableColumns)



export default model

