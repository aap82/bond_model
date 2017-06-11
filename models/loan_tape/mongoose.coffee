import mongoose, {Schema} from 'mongoose'


LoanTapeSchema = new Schema({
  seller:
    description: "loan seller"
    index: yes
    type: String
    default: 'bust'
  name:
    description: "Name of the Loan"
    type: String
    required: yes
  oBal:
    description: "Original Loan Balance"
    type: Number
  cBal:
    description: "Contributed Loan Balance"
    type: Number
    index: yes
  coupon:
    description: "Loan Coupon"
    type: Number
    min: 0
    max: 10
  adminRate:
    description: "The servicing fee and related"
    type: Number
    default: 2
    min: 0
    max: 4
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
    max: 360
  io:
    description: "The io period in months"
    type: Number
    default: 0
    min: 0
    max: 120
  open:
    description: "The open period in months.  3 months open is actually 4, since maturity date is a pay period"
    type: Number
    min: 0
    default: 4
    max: 120
  loanAge:
    description: "Age of the loan"
    type: Number
    min: 0
    default: 0
    max: 120
  isAct360:
    description: "Does the loan accrue Act/360? if not, assumed to be  30/360"
    type: Boolean
    default: yes
  dealID:
    type: String
    index: yes


},
  collection: 'loan_tapes'
)

LoanTape = mongoose.model 'LoanTape', LoanTapeSchema
export default LoanTape



