import {unprotect, types, getSnapshot, applySnapshot, getParent, hasParent} from 'mobx-state-tree'
import moment from 'moment'
import {objectWithProperties} from 'utils/helpers'
loanProps = objectWithProperties
#  _id: types.identifier() #types.optional(types.string, '')
  seller: types.optional(types.string, '')
  name: types.optional(types.string, 'Insert Name')
  oBal: types.optional(types.number, 0.00)
  cBal: types.optional(types.number, 0.00)
  coupon: types.optional(types.number, 0.00)
  adminRate: types.optional(types.number, 0.00)
  term: types.optional(types.number, 0)
  amort: types.optional(types.number, 0)
  io: types.optional(types.number, 0)
  open: types.optional(types.number, 0)
  loanAge: types.optional(types.number, 0)
  isAct360: types.optional(types.boolean, yes)
  dates: null
  firstPaymentDate: null
  accrualStartDate: null
  amortPayment: null
  currentBalance: null
  properties:
    dates:
      get: ->
        return null unless getParent(@,5)?
        getParent(@,5).deal.dates

    firstPaymentDate:
      get: -> moment(@dates.settlement).subtract(@loanAge, 'months').startOf('month')

    accrualStartDate:
      get: -> @firstPaymentDate.clone().subtract(1, 'month')
    amortPayment:
      get: ->
        return null unless @io isnt @term
        monthlyPayment = @oBal * (@coupon / 1200) / (1 - Math.pow(1 / (1 + @coupon / 1200), @amort))
        return Math.round(monthlyPayment*100)/100
    currentBalance:
      get: ->   @cashflow()[0].beginBalance

  cashflow: (toOpen = no) ->
    cashflows = []

    maturity = switch toOpen
      when yes
        if @open is 0
          @term
        else
          @term-@open+1
      else @term

    accrualDate = @firstPaymentDate.clone().subtract(1, 'month')
    for i in [0..maturity-1]
      beginBalance = if i is 0 then @oBal else cashflows[i-1].endBalance
      beginBalance = Math.round(beginBalance*100)/100

      adminFee = beginBalance * (@adminRate/ 10000) * (accrualDate.daysInMonth()/360)
      adminFee = Math.round(adminFee*100)/100

      interest = beginBalance * ((@coupon-(@adminRate/100)) / 100) * (accrualDate.daysInMonth()/360)
      interest = Math.round(interest*100)/100


      amort = switch
        when !@amortPayment? then 0
        when (i+1) > @io then @amortPayment - interest
        else 0
      amort = Math.round(amort*100)/100

      balloon = switch
        when i is maturity-1 then beginBalance - amort
        else 0
      balloon = Math.round(balloon*100)/100

      cashflows.push {
        period: i + 1
        beginBalance: beginBalance
        coupon: @coupon-@adminRate/100
        interest: interest
        adminFee: adminFee
        amort: amort
        balloon: balloon
        principal: Math.round((amort + balloon)*100)/100
        endBalance: Math.round((beginBalance - amort - balloon)*100)/100
      }
      accrualDate.add(1, 'month')
    cashflows.splice(0, @loanAge) if @loanAge > 0
    return cashflows




loanActions =
  edit: (key, value) -> @[key] = value if @[key] isnt value

Loan = types.model('Loan', loanProps, loanActions)

export {Loan}

