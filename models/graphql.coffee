LoanTape = require './loan_tape/graphql'
DealSettings = require './deal_settings/graphql'
Deal = require './deal/graphql'

merge = require 'lodash/merge'
flatten = require 'lodash/flatten'

exports = module.exports

exports.queries = flatten [
    Deal.queriesANDmutations
    LoanTape.queriesANDmutations
  ]



exports.TCs = merge {},
  Deal.TC
  DealSettings.TC
  LoanTape.TC