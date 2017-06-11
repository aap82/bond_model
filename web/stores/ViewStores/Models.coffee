import mobx, {autorun, extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import PopOutWindowStore from './PopoutWindow'
import {collateralCashflow} from '../model'
import {getSnapshot} from 'mobx-state-tree'
import {Loan} from 'models/loan_tape/mobx'

class ModelView
  constructor: (@id, @view, @history) ->
    @tables = @view.tables
    extendObservable @, {
      loansVisible: yes
      showLoans: action(-> @loansVisible = yes)
      hideLoans: action(-> @loansVisible = no)

      toggleLoansVisibility: action(->
        console.log 'hi'
        switch @loansVisible
          when yes then @hideLoans()
          else @showLoans()

      )


      deal: computed(-> @view.deal)
      loans: computed(-> (row.data for row in @tables.get('loans').source when row.included is yes))
      bonds: null

      collateralCashFlow: action(->
        collateralCashflow  @deal.dates, @loans, no
      )
#      loanCashFlow: action((loans) ->
#        loanCashFlow @deal.dates, @loans.source[0].data
#      )

    }



class ModelsViewTopBar
  constructor: ->
    extendObservable @, {
      openForm: null
      popupID: null
      openPopup: action('Open Popup', (e, d) => @popupID = d.id if !d.open)
      closePopups: action('Close Popups', => @popupID = null)
      isModelOpen: no
    }


modelsViewTopBar = new ModelsViewTopBar


class ModelsViewStore
  constructor: (@topBar, @popOuts)->
    extendObservable @, {
      loans: []

      deals: []
      models: observable.shallowMap({})
      model: null
      open: action 'Loading Deal', ((deal) ->
        loans = (new Loan(loan) for loan in deal.loans)
        @loans.replace(loans)
      )

      close: action 'Closing Deal',( ->
        @loans.clear()
        @model = null
      )

      createLoans: action ((loans) -> (new Loan(loan) for loan in loans)

      )



      save: action(->
        return

      )




    }



modelsViewStore = new ModelsViewStore(modelsViewTopBar,PopOutWindowStore)



export default modelsViewStore

