{ GQC } = require 'graphql-compose'
models = require '../models/graphql'
{LoanTapeTC, DealSettingsTC, DealTC, DealMasterTC} = models.TCs



GQC.rootQuery().addFields({
  dealSummary: DealMasterTC.getResolver('findMany')
  deal: DealTC.getResolver('findOne')
  dealById:  DealTC.getResolver('findById')
  deals: DealTC.getResolver('findMany')
  dealSettings: DealSettingsTC.getResolver('findOne')
  loan: LoanTapeTC.getResolver('findOne')
  loans: LoanTapeTC.getResolver('findMany')
})


GQC.rootMutation().addFields({
  dealCreate: DealTC.getResolver('createOne')
  dealAddToMaster: DealMasterTC.getResolver('createOne')
  dealUpdate: DealTC.getResolver('updateById')
  dealDelete: DealTC.getResolver('removeById')

  createLoan: LoanTapeTC.get('$createOne')
  editLoan: LoanTapeTC.get('$updateById')

})


schema = GQC.buildSchema()

module.exports = schema









