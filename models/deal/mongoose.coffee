mongoose = require('mongoose')
Schema = mongoose.Schema

DealSchema = new Schema({
  dealID:
    description: 'Unique top level identifier for a deal'
    type: String
    unique: yes
    index: yes
  name:
    description: 'The Name of the deal'
    type:String
    required: yes
    index: yes
  type:
    description: 'Is this a test or real?'
    type: String
    enum: ['test', 'pool']
    required: yes
    default: 'test'
  officialType:
    description: 'if this real, pick from one of the choices'
    type: String
    enum: ['initial', 'red', 'launch', 'priced', 'preprice', 'ra', 'bbuyer', 'other' ]
    default: 'initial'
  testType:
    description: 'If its a test, give it a name'
    type: String
    default: 'New Pool'
  settingsID:
    type:String
  loanIDs:
    description: 'Array of Loan IDs'
    type: [String]
  bondIDs:
    description: 'Array of Bond IDs'
    type: [String]
})

module.exports = mongoose.model 'Deal', DealSchema



