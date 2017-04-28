import React from 'react'
require './styles.scss'
import {crel, div,h2} from 'teact'
import Collateral from './containers/Collateral/'



class App extends React.Component
  render: ->
    {store} = @props
    div className: "app", ->
      crel Collateral, store: store


export default App