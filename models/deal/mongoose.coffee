mongoose = require('mongoose')
Schema = mongoose.Schema
exports = module.exports
DealSchema = new Schema({
  dealID:
    description: 'Unique top level identifier for a deal'
    type: String
    index: yes
    required: yes
  name:
    description: 'The Name of the deal'
    type:String
    required: yes
    index: yes
  type:
    description: 'Deal Types'
    type: String
    required: yes
    enum: ['test', 'initial', 'red', 'launch', 'priced', 'preprice', 'ra', 'bbuyer', 'other' ]
    default: 'initial'
  settingsID:
    type: Schema.Types.ObjectId,
    ref: 'DealSetting'
  loanIDs:
    description: 'Array of Loan IDs'
    type: [{ type: Schema.Types.ObjectId, ref: 'LoanTape' }]
  bondIDs:
    description: 'Array of Bond IDs'
    type: [{ type: Schema.Types.ObjectId, ref: 'Bond' }]
})

exports.DealModel = mongoose.model 'Deal', DealSchema
DealMappingSchema = new Schema({
  type:
    description: 'Deal Types'
    type: String
    required: yes
    enum: ['test', 'initial', 'red', 'launch', 'priced', 'preprice', 'ra', 'bbuyer', 'other' ]
  typeID:
    type: Schema.Types.ObjectId
    index: yes
    required: yes

}, _id: false)



DealMasterSchema = new Schema({
  dealID:
    description: 'Unique top level identifier for a deal'
    type: String
    index: yes
  name:
    description: 'The Name of the deal'
    type:String
    index: yes
  lastUsed:
    description: 'Deal Id most recently accessed'
    type: Schema.Types.ObjectId
  mappings: [DealMappingSchema]

}, collection: 'deal_master')

exports.DealMasterModel = mongoose.model 'DealMaster', DealMasterSchema





