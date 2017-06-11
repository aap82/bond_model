import {composeWithMongoose} from 'graphql-compose-mongoose'
import LoanTape from './mongoose'

export TC =
  LoanTapeTC: composeWithMongoose(LoanTape)




import {loanTapeSummaryFragment, loanTapeDetailsFragment} from './fragments'

export queriesANDmutations = [
  "#{loanTapeSummaryFragment}
    query getLoans {
      loans {
        ...loanSummary
      }
    }"

  "
  #{loanTapeDetailsFragment}
   query getLoansDetailed {
      loans {
        ...loanDetail
      }
    }"


  "mutation loanUpdate($loan: UpdateByIdLoanTapeInput!) {
    loanUpdate(record: $loan) {
      recordId

    }
  }"


]
