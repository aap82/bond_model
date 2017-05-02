import React from 'react'
require './styles.scss'
import {crel} from 'teact'
import Routes from './Routes'
import Layout from './components/Layout'

class App extends React.Component
  render: ->
    crel Layout, ->
      crel Routes



export default App