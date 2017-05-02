import React from 'react'
import {crel, div, h2 } from 'teact'
import {inject, observer} from 'mobx-react'


Model = observer(class Model extends React.Component
  constructor: (props) ->
    super props

  render: ->
    h2 'MODEL'
)


export default Model