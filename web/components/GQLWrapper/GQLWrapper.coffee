import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import {lazyObservable} from 'mobx-utils'
#
#export default withGQL = (Component, query, variables = {}, initial = null) ->
#  return inject('gql')(class extends React.Component
#    constructor: (props) ->
#      console.log variables
#      @gql = props.gql
#      @query = lazyObservable(
#        ((sink) =>
#          @gql('query', query, variables)
#          .then (results) =>
#            console.log results
#            sink(results.data)
#        )
#        initial
#      )
#
#    render: ->
#      crel Component, {
#          @props
#          query: @query
#        }
#
#
#
#  )
#
#
