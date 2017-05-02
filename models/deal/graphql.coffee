composeWithMongoose = require('graphql-compose-mongoose').default
Deal = require './mongoose'
DealSettingsTC = require '../deal_settings/graphql'
LoanTapeTC = require '../loan_tape/graphql'


Deal = composeWithMongoose(Deal)

Deal.addRelation 'settings', (-> {
  resolver: DealSettingsTC.getResolver('findById')
  args:
    _id: ((source) ->  source.settingsID)
  projection:
    settingID: yes
})


Deal.addRelation 'loans', (-> {
  resolver: LoanTapeTC.getResolver('findByIds')
  args:
    _ids: ((source) ->  source.loanIDs)

  projection:
    loanIDs: yes

})





module.exports = Deal