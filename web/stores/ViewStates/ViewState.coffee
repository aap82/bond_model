import {unprotect, types, getSnapshot, applySnapshot, getParent, hasParent} from 'mobx-state-tree'
import Table from '../tables'
import {Deal} from './deal'
import {Loan} from './loan'
import loanColumns from 'models/loan_tape/data_table'

viewStateProps =
  id: types.identifier()
  deal: Deal
  tables: types.map(Table)
  selectedTable: types.optional(types.string, '')
viewStateActions =
  reset: -> @tables.get('loans').reset()
  setSelectedTable: (id = '') ->  @selectedTable = id
  clearSelectedTable: -> @selectedTable = ''

ViewState = types.model('ViewState', viewStateProps, viewStateActions)





viewStatesProps =
  views: types.optional(types.map(ViewState), {})
  view: types.reference(ViewState, './views')


viewStatesActions =
  select: (view) -> @view = view

  create: (deal) ->
    view = ViewState.create({
      id: deal._id
      deal: deal
      tables:
        loans:
          id: 'loans'
          source: ({id: loan._id, data: loan} for loan,i in deal.loans)
          columns: loanColumns
          sortColumn: 'currentBalance'
          sortDirection: -1
          footer: yes
          subtotalWeight: 'currentBalance'
    })
    @views.put(view)
    @select(view)
    return view

  load: (view) ->
    view.reset()
    @select(view)


ViewStates = types.model('ViewStates', viewStatesProps, viewStatesActions)
viewStates = ViewStates.create({
  view: ''
})


export default viewStates

