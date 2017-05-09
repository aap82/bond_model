{dealSettingsFragment} = require '../deal_settings/fragments'
{loanTapeDetailsFragment} = require '../loan_tape/fragments'

exports.dealSummaryFragment = "
  fragment dealSummary on Deal {
      _id
      dealID
      name
      type
      settingsID
      loanIDs
      bondIDs
    }
"


exports.dealDetailsFragment = "
  #{dealSettingsFragment}
  #{loanTapeDetailsFragment}
  fragment dealDetails on Deal {
      _id
      dealID
      name
      type
      settingsID
      loanIDs
      bondIDs
      settings {
        ...dealSettings
      }
      loans {
        ...loanDetail
      }
    }
"


