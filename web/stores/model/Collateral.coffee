
class Collateral
  constructor: (@loans) ->
    @coupon = []
    @beginBalance = []
    @interest = []
    @adminFee = []
    @amort = []
    @balloon = []
    @principal = []
    @endBalance = []


  clear: ->
    @coupon = []
    @beginBalance = []
    @interest = []
    @adminFee = []
    @principal = []
    @amort = []
    @balloon = []
    @endBalance = []

  update: (toOpen = no) ->
    @clear()
    loans = @loans.getDataIncluded()
    for loan, i in loans
      cashflows = loan.cashflow(toOpen)

      for cashflow,j in cashflows
        if not @beginBalance[j]?
          @coupon[j] = (cashflow.coupon * cashflow.beginBalance)
          @beginBalance[j] = cashflow.beginBalance
          @interest[j] = cashflow.interest
          @adminFee[j] = cashflow.adminFee
          @amort[j] = cashflow.amort
          @balloon[j] = cashflow.balloon
          @principal[j] = (cashflow.balloon + cashflow.amort)
          @endBalance[j] = cashflow.endBalance
        else
          @coupon[j] += (cashflow.coupon * cashflow.beginBalance)
          @beginBalance[j] += cashflow.beginBalance
          @interest[j] += cashflow.interest
          @adminFee[j] += cashflow.adminFee
          @amort[j] += cashflow.amort
          @balloon[j] += cashflow.balloon
          @principal[j] += (cashflow.balloon + cashflow.amort)
          @endBalance[j] += cashflow.endBalance

    for i in [0..@beginBalance.length-1]
      @coupon[i] = @coupon[i] / @beginBalance[i]
      @beginBalance[i] = Math.round(@beginBalance[i]*100)/100
      @interest[i] = Math.round(@interest[i]*100)/100
      @adminFee[i] = Math.round(@adminFee[i]*100)/100
      @amort[i] = Math.round(@amort[i]*100)/100
      @balloon[i] = Math.round(@balloon[i]*100)/100
      @principal[i] = Math.round(@principal[i]*100)/100
      @endBalance[i] = Math.round(@endBalance[i]*100)/100
    return {
      beginBalance: @beginBalance
      adminFee: @adminFee
      interest: @interest
      coupon: @coupon
      amort: @amort
      balloon: @balloon
      principal: @principal
      endBalance: @endBalance
    }

  @getter 'cashflow', -> @update()
  @getter 'cashflowOpen', -> return @update(yes)




export default Collateral