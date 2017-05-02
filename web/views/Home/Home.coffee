import React from 'react'
import {crel, div, h2 } from 'teact'
import {inject, observer} from 'mobx-react'
import Page from '../../components/Page'

Home = observer(class Home extends React.Component
  constructor: (props) ->
    super props

  render: ->
    h2 'HELLO'
)


export default Home