composeWithMongoose = require('graphql-compose-mongoose').default
LoanTape = require './mongoose'

exports = module.exports
exports.TC =
  LoanTapeTC: composeWithMongoose(LoanTape)




{loanTapeSummaryFragment, loanTapeDetailsFragment} = require './fragments'

exports.queries = [
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
]
