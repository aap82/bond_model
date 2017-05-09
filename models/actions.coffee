import {DealActions} from './deal/mobx'

class Actions
  constructor: (gql) ->
    @deal = new DealActions(gql)


export default Actions