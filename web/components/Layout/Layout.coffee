import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import LeftNav from '../LeftNav'

import {Header} from 'semantic-ui-react'
sidebarWidth = 210




class Layout extends React.Component
  constructor: (props) ->
    super props

  render: ->
    style =
      main:
        marginLeft: sidebarWidth,
        minWidth: parseInt(sidebarWidth, 10) + 300
        paddingTop: 5
        paddingLeft: 5

    div =>
      crel LeftNav
      div style: style.main, =>
        crel Header, as: 'h1', "TITLE GOES HERE"
        crel 'div', @props.children


export default Layout




