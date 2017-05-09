
exports.loanTapeSummaryFragment = "
  fragment loanSummary on LoanTape {
      _id
      seller
      oBal
      cBal
      name
      dealID
    }
"

exports.loanTapeDetailsFragment = "
  fragment loanDetail on LoanTape {
       _id
      seller
      oBal
      cBal
      name
      dealID
      coupon
      adminRate
      term
      amort
      io
      open
      loanAge
      isAct360
    }
"

