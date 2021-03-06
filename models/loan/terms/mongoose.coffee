mongoose = require('mongoose')
Schema = mongoose.Schema

LoanTermsSchema = new Schema({
  closeDate:
    description: "Actual or Anticipated Closing Date"
    type: Date
    default: Date.now
  oBal:
    description: "Original Loan Balance"
    type: Number
  cBal:
    description: "Current Loan Balance"
    type: Number
  coupon:
    description: "Current Total Loan Coupon"
    type: Number
    min: 0
  adminRate:
    description: "The servicing fee and related"
    type: Number
    default: 2
    min: 0
  term:
    description: "The original loan term in months"
    type: Number
    default: 120
    min: 4
  amort:
    description: "The amortization term in months"
    type: Number
    default: 360
    min: 0
  io:
    description: "The io period in months"
    type: Number
    default: 0
    min: 0
  open:
    description: "The open period in months.  3 months open is actually 4, since maturity date is a pay period"
    type: Number
    min: 0
    default: 4
    min: 0

},
  _id: false
)

module.exports = LoanTermsSchema



