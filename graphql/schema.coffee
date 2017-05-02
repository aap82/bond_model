{ GQC } = require 'graphql-compose'
{LoanTapeTC, LoanDetailTC, DealSettingsTC, DealTC} = require '../models/graphql'



GQC.rootQuery().addFields({
  deal: DealTC.getResolver('findOne')
  deals: DealTC.getResolver('findMany')
  dealSettings: DealSettingsTC.getResolver('findOne')
  loan: LoanTapeTC.getResolver('findOne')
  loans: LoanTapeTC.getResolver('findMany')
})


GQC.rootMutation().addFields({
  createDeal: DealTC.get('$createOne')
  editDeal: DealTC.get('$updateById')


  createLoan: LoanTapeTC.get('$createOne')
  editLoan: LoanTapeTC.get('$updateById')

})


schema = GQC.buildSchema()

module.exports = schema









