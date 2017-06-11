import moment from 'moment'

export loanCashFlow = (dates, {
  loanAge
  oBal
  coupon
  adminRate
  io
  term
  amort
  open
}, toOpen = no, currentBalance=no) ->
  cashflows = []
  amortPayment = switch
    when io is term then null
    else
      monthlyPayment = oBal * (coupon / 1200) / (1 - Math.pow(1 / (1 + coupon / 1200), amort))
      Math.round(monthlyPayment*100)/100

  maturity = switch toOpen
    when yes
      if open is 0
        term
      else
        term-open+1
    else term
  accrualDate = moment(dates.settlement).subtract(loanAge+1, 'months').startOf('month')

  for i in [0..maturity-1]
    beginBalance = if i is 0 then oBal else cashflows[i-1].endBalance
    beginBalance = Math.round(beginBalance*100)/100
    return beginBalance if currentBalance and loanAge is i
    adminFee = beginBalance * (adminRate/ 10000) * (accrualDate.daysInMonth()/360)
    adminFee = Math.round(adminFee*100)/100

    interest = beginBalance * ((coupon-(adminRate/100)) / 100) * (accrualDate.daysInMonth()/360)
    interest = Math.round(interest*100)/100


    amort = switch
      when !amortPayment? then 0
      when (i+1) > io then amortPayment - interest
      else 0
    amort = Math.round(amort*100)/100

    balloon = switch
      when i is maturity-1 then beginBalance - amort
      else 0
    balloon = Math.round(balloon*100)/100
    cashflows.push {
      period: i + 1
      beginBalance: beginBalance
      adminRate: adminRate
      grossCoupon: coupon
      coupon: coupon-adminRate/100
      interest: interest
      adminFee: adminFee
      amort: amort
      balloon: balloon
      principal: Math.round((amort + balloon)*100)/100
      endBalance: Math.round((beginBalance - amort - balloon)*100)/100
    }


    accrualDate.add(1, 'month')
  cashflows.splice(0, loanAge) if loanAge > 0
  return cashflows