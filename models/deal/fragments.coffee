import {dealSettingsFragment} from '../deal_settings/fragments'
import {loanTapeDetailsFragment} from '../loan_tape/fragments'

export dealSummaryFragment = "
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


export dealDetailsFragment = "
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


