import {loanCashFlow} from './loanCashflow'

export collateralCashflow = (dates, collateral, toOpen=no) ->
  names = []
  coupon = []
  beginBalance = []
  interest = []
  adminFee = []
  amort = []
  balloon = []
  principal = []
  endBalance = []
  adminRate = []
  grossCoupon = []
  for loan, i in collateral
    names.push loan.name
    cashflows = loanCashFlow(dates, loan, toOpen)
    for cashflow,j in cashflows
      if not beginBalance[j]?
        adminRate[j] = (cashflow.adminRate * cashflow.beginBalance)
        grossCoupon[j] = (cashflow.grossCoupon * cashflow.beginBalance)
        coupon[j] = (cashflow.coupon * cashflow.beginBalance)
        beginBalance[j] = cashflow.beginBalance
        interest[j] = cashflow.interest
        adminFee[j] = cashflow.adminFee
        amort[j] = cashflow.amort
        balloon[j] = cashflow.balloon
        principal[j] = (cashflow.balloon + cashflow.amort)
        endBalance[j] = cashflow.endBalance
      else
        adminRate[j] += (cashflow.adminRate * cashflow.beginBalance)
        grossCoupon[j] += (cashflow.grossCoupon * cashflow.beginBalance)
        coupon[j] += (cashflow.coupon * cashflow.beginBalance)
        beginBalance[j] += cashflow.beginBalance
        interest[j] += cashflow.interest
        adminFee[j] += cashflow.adminFee
        amort[j] += cashflow.amort
        balloon[j] += cashflow.balloon
        principal[j] += (cashflow.balloon + cashflow.amort)
        endBalance[j] += cashflow.endBalance

  for i in [0..beginBalance.length-1]
    adminRate[i] = adminRate[i] / beginBalance[i]
    grossCoupon[i] = grossCoupon[i] / beginBalance[i]
    coupon[i] = coupon[i] / beginBalance[i]
    beginBalance[i] = Math.round(beginBalance[i]*100)/100
    interest[i] = Math.round(interest[i]*100)/100
    adminFee[i] = Math.round(adminFee[i]*100)/100
    amort[i] = Math.round(amort[i]*100)/100
    balloon[i] = Math.round(balloon[i]*100)/100
    principal[i] = Math.round(principal[i]*100)/100
    endBalance[i] = Math.round(endBalance[i]*100)/100
  return {
    names: names
    adminRate: adminRate
    grossCoupon: grossCoupon
    beginBalance: beginBalance
    adminFee: adminFee
    interest: interest
    coupon: coupon
    amort: amort
    balloon: balloon
    principal: principal
    endBalance: endBalance
  }


