composeWithMongoose = require('graphql-compose-mongoose').default
{DealMasterModel, DealModel} = require './mongoose'

DealMasterTC = composeWithMongoose(DealMasterModel)

{TC: {DealSettingsTC: DealSettingsTC}} = require '../deal_settings/graphql'
{TC: {LoanTapeTC: LoanTapeTC}} = require '../loan_tape/graphql'




DealTC = composeWithMongoose(DealModel)

DealTC.addRelation 'settings', (-> {
  resolver: DealSettingsTC.getResolver('findById')
  args:
    _id: ((source) ->  source.settingsID)
  projection:
    settingID: yes
})


DealTC.addRelation 'loans', (-> {
  resolver: LoanTapeTC.getResolver('findByIds')
  args:
    _ids: ((source) ->  source.loanIDs)
  projection:
    loanIDs: yes
})


DealMasterTC.addRelation 'deals', (-> {
  resolver: DealTC.getResolver('findByIds')
  args:
    _ids: ((source) ->(d.typeID for d in source.mappings))
  projection:
    mappings: yes
})






exports = module.exports

exports.TC =
  DealTC: DealTC
  DealMasterTC: DealMasterTC



{dealSummaryFragment, dealDetailsFragment} = require './fragments'


exports.queriesANDmutations = [
  "
    query dealsGetSummary {

      dealSummary {
        _id
        dealID
        name
        lastUsed
        mappings {
          typeID
          type
        }
      }

    }


  "
  "#{dealSummaryFragment}
    query dealsGetAllSummary {
      deals {
        ...dealSummary
      }
    }"

  "
  #{dealDetailsFragment}
   query dealGetByID($id: MongoID!) {
      dealById(_id: $id) {
        ...dealDetails
      }
    }"

  "
  #{dealSummaryFragment}
  mutation dealCreate($deal: CreateOneDealInput!) {
    dealCreate(record: $deal) {
      recordId
      record { ...dealSummary }
    }
  }"
  "
  mutation dealAddToMaster($deal: CreateOneDealMasterInput!) {
      dealAddToMaster(record: $deal) {
        recordId
      }
  }"



  "mutation dealUpdate($deal: UpdateByIdDealInput!) {
    dealUpdate(record: $deal) {
      recordId

    }
  }"

  "mutation dealDelete($id: MongoID!) {
    dealDelete(_id: $id) {
      recordId
    }
  }"



]