import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'


export class Deal
  constructor: ->
    extendObservable @, {
      _id: null
      seller: ''
      name: ''
      oBal: 0
      cBal: 0
      coupon: 0
      adminRate: 0
      term: 0
      amort: 0
      io: 0
      open: 0
      loanAge: 0
      isAct360: yes
      dealID: null
        

      reset: action('Reset deal to default', ->
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

      update: action('update from json', (props) ->
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

      toJSON: action('get deal data', ->
        _id: @_id
        name: @name
        type: @type
        settingsID: @settingsID
        loanIDs: mobx.toJS(@loanIDs)
        bondIDs: mobx.toJS(@bondIDs)
      )
    }





class DealStore
  @deal
  @gql
  constructor: (gql) ->
    @gql = gql
    @deal = new Deal
    extendObservable @, {
      isLoadingDeals: no

      deals: observable.shallowArray([])
      getDeals: action('Fetch deals from server', ->
        @isLoadingDeals = yes
        @gql.query('opName', 'getDeals').then (data) =>
          runInAction(=>
            @deals.replace(data.deal) if data isnt null
            @isLoadingDeals = no
          )
        )

      createDeal: action('Create New Deal', (props) ->
        @deals.push deal
        @deal = deal
        return
      )
    }
    @getDeals()

export default DealStore



