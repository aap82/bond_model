import React from 'react'
import DevTools from 'mobx-react-devtools'
import {crel, div} from 'teact'
import { Router, Route,  Redirect,  Miss, Switch} from 'react-router-dom'
import LeftNav from './components/LeftNav'
import Home from './views/Home'
import Model from './views/Model'
import Modal from 'components/Modal'
require './styles.scss'
sidebarWidth = 210

options =
  highlightTimeout: 800
  setGraphEnabled: yes
  position:
    bottom: 0
    right: 150

class App extends React.Component
  render: ->
    style =
      main:
        marginLeft: sidebarWidth,
        minWidth: parseInt(sidebarWidth, 10) + 300
#        paddingLeft: 5
#        paddingTop: 5
    div =>
      crel DevTools, options
      crel Model
#      crel LeftNav
#      div style: style.main, =>
#        crel Route,
#          path: '/model'
#          component: Model
#          exact: yes
#        crel Route,
#          path: '/model'
#          component: Model
#          exact: yes





export default App