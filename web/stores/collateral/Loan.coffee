import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'

class Loan
  constructor: (loan = {}) ->
    @id = loan.id or null
    extendObservable @, {
      seller: loan.seller or 'Default'
      name: loan.name or 'Insert Name'
      origBalance: loan.origBalance or 0
      coupon: loan.coupon or 0

    }

export default Loan