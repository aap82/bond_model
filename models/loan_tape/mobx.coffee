import mobx, {autorun, extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import {loanCashFlow} from '../../web/stores/model/loanCashflow'

export class Loan
  constructor: (props) ->
    @dates =
      settlement: (new Date("7/20/17")).toUTCString()
      firstPayment: (new Date("8/15/17")).toUTCString()
      pricing: (new Date("5/5/22")).toUTCString()

    extendObservable @, {
      _id: props._id or ''
      seller: props.seller or ''
      name: props.name or 0
      oBal: props.oBal or 0
      cBal: props.cBal or 0
      coupon: props.coupon or 0.000
      adminRate: props.adminRate or 4.000
      term: props.term or 120
      amort: props.amort or 360
      io: props.io or 0
      open: props.open or 4
      loanAge: props.loanAge or 2
      isAct360: props.isAct360 or yes
      dealID: props.dealID or ''
      include: yes
      current: 0

      cashflow: action(->
        runInAction(=>
          @current =  loanCashFlow(@dates, @, no, yes)
          return @current
        )
      )

      updateProps: action((prop, value) =>
        @[prop] = value
      )
      toggle: action(->
        @include = !@include
      )


      reset: action('Reset deal to default', (->
          runInAction(=>
            @_id = null
            @seller = ''
            @name = ''
            @oBal = 0
            @cBal = 0
            @coupon = 0
            @adminRate = 0
            @term = 0
            @amort = 0
            @io = 0
            @open = 0
            @loanAge = 0
            @isAct360 = yes
            @dealID = null
          )
        )
      )

      update: action('update from json', ((props) ->
          runInAction(=>
            @_id = props._id
            @seller = props.seller
            @name = props.name
            @oBal = props.oBal
            @cBal = props.cBal
            @coupon = props.coupon
            @adminRate = props.adminRate
            @term = props.term
            @amort = props.amort
            @io = props.io
            @open = props.open
            @loanAge = props.loanAge
            @isAct360 = yes
            @dealID = props.dealID
          )
        )
      )

      toJSON: action('get deal data', (->
          _id: @_id
          name: @name
          type: @type
          settingsID: @settingsID
          loanIDs: mobx.toJS(@loanIDs)
          bondIDs: mobx.toJS(@bondIDs)
        )
      )




    }






export class LoanActions
  constructor: (@gql) ->
    extendObservable @, {
      isUpdatingLoan: no
      loanUpdate: action('UpdateLoanData', (loan) ->
        @isUpdatingloan = yes
        @gql.query('opName', 'loanUpdate', loan: loan).then((data) =>
          runInAction(=>
            @isUpdatingloan = no
            if data?
              return yes
            else
              return no
          )
        )
      )
#
#      isFetchingDeal: no
#      dealGetByID: action('Fetching Deal By ID', (id) ->
#        @isFetchingDeal = yes
#        @gql.query('opName', 'dealGetByID', id: id).then((data) =>
#          runInAction(=>
#            @isFetchingDeal = no
#            if data.dealById?
#              return data.dealById
#            else
#              return null
#          )
#        )
#      )
#
#
#
#
#      isCreatingDeal: no
#      dealCreate: action('Create New Deal', (props) ->
#        props.dealID = uuidV4()
#        @isCreatingDeal = yes
#        @gql.mutation('dealCreate', deal: props).then((data) =>
#          runInAction(=>
#            @isCreatingDeal = no
#            if data?
#              @addToMaster(data.dealCreate.record)
#              return data.dealCreate.record
#            else
#              return no
#          )
#        )
#      )
#
#      isAddingDeal: no
#      addToMaster: action('Add Deal to Master Mapping', ({dealID, name, _id, type}) ->
#        @isAddingDeal = yes
#        props =
#          dealID: dealID
#          name: name
#          lastUsed: _id
#          mappings:
#            type: type
#            typeID: _id
#        @gql.mutation('dealAddToMaster', deal: props).then((data) =>
#          console.log data
#          @isAddingDeal = no
#          return
#        )
#      )
    }





