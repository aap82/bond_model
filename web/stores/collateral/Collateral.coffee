import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import Loan from './Loan'
import test_data from './test_data'
import columns from './columns'

class Collateral
  constructor: (@columns, test_data) ->
    extendObservable @, {
      loans: []
      getLoan: action('GetLoan', ((i) =>
        mobx.toJS(@loans[i]))
      )
      addLoan: action('AddLoan', ((loan) -> @loans.push(new Loan(loan))))
      addLoans: action('AddLoans', ((loans) ->
        runInAction(=>
          @addLoan(loan) for loan in loans
        )
      ))

      handleUpdate: action('LoanUpdate', ((e) -> console.log e))

    }
    @addLoans(test_data)


collateral = new Collateral(columns, test_data)

export default collateral