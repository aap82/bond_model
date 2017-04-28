mongoose = require('mongoose')
Schema = mongoose.Schema
composeWithMongoose = require('graphql-compose-mongoose').default



LoanSchema = new Schema({
  loanID:
    type:String
    required: yes
    unique: yes
    index: yes
  name:
    type: String
  closeDate:
    type: Date
    default: Date.now
  oBal:
    type: Number
    description: "Original Loan Balance"
  coupon:
    type: Number
    min: 0
  fee:
    type: Number
    default: 2
    min: 0
  type:
    type: String
    enum: ['fixed', 'floating']
  accrual:
    type: String
    enum: [ 'Act/360', '30/360']
  term:
    type: Number
    default: 120
    min: 4
  amort:
    type: Number
    default: 360
    min: 0
  io:
    type: Number
    default: 0
    min: 0
  open:
    min: 0
    type: Number
    default: 4
    min: 0
})

Loan = mongoose.model 'Loan', LoanSchema
LoanTC = composeWithMongoose(Loan)

module.exports =
  Loan: Loan
  LoanTC: LoanTC


