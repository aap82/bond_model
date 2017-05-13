import {DealActions} from './deal/mobx'
import {LoanActions} from './loan_tape/mobx'
class Actions
  constructor: (gql) ->
    @deal = new DealActions(gql)
    @loans = new LoanActions(gql)


export default Actions