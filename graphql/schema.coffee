{ GQC } = require 'graphql-compose'
{LoanTC} = require '../models/graphql'



GQC.rootQuery().addFields({
  loan: LoanTC.getResolver('findOne')
  loans: LoanTC.getResolver('findMany')
})


GQC.rootMutation().addFields({
  loan: LoanTC.getResolver('findOne')
  loans: LoanTC.getResolver('findMany')
})


schema = GQC.buildSchema()

module.exports = schema









