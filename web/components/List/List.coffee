import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import { DetailsList, buildColumns} from 'office-ui-fabric-react/lib/DetailsList'

#gqlFetch = require('../../../utils/fetch')('/graphql')


List = observer(class List extends React.Component
  constructor: (props) ->
    super props

  render: ->
    div ->
      div "HI"
#    crel DetailsList,
#      items:  @props.items



)


export default List 