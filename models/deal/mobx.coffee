import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import uuidV4 from 'uuid'

export class Deal
  constructor: ->
    extendObservable @, {
      _id: null
      dealID: null
      name: ''
      type: 'initial'
      settingsID: ''
      loanIDs: []
      bondIDs: []

      reset: action('Reset deal to default', ->
        runInAction(=>
          @_id = null
          @dealID = null
          @name = ''
          @type = 'initial'
          @settingsID = ''
          @loanIDs.clear()
          @bondIDs.clear()
        )
      )

      update: action('update from json', (props) ->
        runInAction(=>
          @_id = props._id
          @dealID = props.dealID
          @name = props.name
          @type = props.type
          @settingsID = props.settingsID
          @loanIDs.replace(props.loanIDs)
          @bondIDs.replace(props.bondIDs)
        )
      )

      toJSON: action('get deal data', ->
        _id: @_id
        dealID: @dealID
        name: @name
        type: @type
        settingsID: @settingsID
        loanIDs: mobx.toJS(@loanIDs)
        bondIDs: mobx.toJS(@bondIDs)
      )
    }





export class DealActions
  constructor: (@gql) ->
    extendObservable @, {
      isFetchingDeals: no
      dealsGetAllSummary: action('Fetch deals from server', ->
        @isFetchingDeals = yes
        @gql.query('opName', 'dealsGetSummary').then((data) =>
          runInAction(=>
            @isFetchingDeals = no
            if data.dealSummary?
              return data.dealSummary
            else
              return null
          )
        )
      )

      isFetchingDeal: no
      dealGetByID: action('Fetching Deal By ID', (id) ->

        console.log id
        @isFetchingDeal = yes
        @gql.query('opName', 'dealGetByID', id: id).then((data) =>
          runInAction(=>
            @isFetchingDeal = no
            if data.dealById?
              return data.dealById
            else
              return null
          )
        )
      )




      isCreatingDeal: no
      dealCreate: action('Create New Deal', (props) ->
        props.dealID = uuidV4()
        @isCreatingDeal = yes
        @gql.mutation('dealCreate', deal: props).then((data) =>
          runInAction(=>
            @isCreatingDeal = no
            if data?
              @addToMaster(data.dealCreate.record)
              return data.dealCreate.record
            else
              return no
          )
        )
      )
      isAddingDeal: no
      addToMaster: action('Add Deal to Master Mapping', ({dealID, name, _id, type}) ->
        @isAddingDeal = yes
        props =
          dealID: dealID
          name: name
          lastUsed: _id
          mappings:
            type: type
            typeID: _id
        @gql.mutation('dealAddToMaster', deal: props).then((data) =>
            console.log data
            @isAddingDeal = no
            return
        )
      )
    }




