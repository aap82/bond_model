mongoose = require('mongoose')
Schema = mongoose.Schema

DealSettingsSchema = new Schema({
  dealID:
    type: String
    required: yes
    index: yes
  priceDate:
    description: "Deal Pricing Date"
    type: Date
  settleDate:
    description: "Deal Settlement Date"
    type: Date
  cutoffDate:
    description: "Deal Collateral Cutoff Date"
    type: Date
}, {
  collection: 'deal_settings'
})

module.exports = mongoose.model 'DealSetting', DealSettingsSchema



