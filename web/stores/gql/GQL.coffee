import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'


class GQL
  constructor: (@store, @gql) ->
    extendObservable @, {
      query: action("Executing Fetch", ((type, query, variables = {}) ->
          @gql(type, query, variables).then(@handleGQLResponse)
        )
      )


      handleGQLResponse: action('GQL Response', ((result) ->
          if result.errors
            console.log result.errors
            return null
          return result.data
        )
      )

      mutation: action('Execute Mutation', ((mutation, data) ->
          @gql('opName', mutation, data).then(@handleGQLResponse)
        )
      )



    }






export default GQL