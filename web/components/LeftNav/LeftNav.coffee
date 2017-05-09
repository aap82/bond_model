import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import {expr} from 'mobx'
import { Link} from 'react-router-dom'
import { Menu } from 'semantic-ui-react'



NavItem = inject('routing')(observer(({routing, name}) ->
  path = '/' + if name is 'home' then '' else name
  handleClick = (->    routing.push(if name is 'home' then '/' else name) )
  active = expr(-> routing.location.pathname is path)
#  crel Link, to: path, ->
  crel Menu.Item,
    name: name
    active: active
    onClick: handleClick

))

LeftNav = ->
  displayName: 'LeftNav'
  crel Menu,
    inverted: yes
    vertical: yes
    fixed: 'left', ->
      crel NavItem, name: 'home'
      crel NavItem, name: 'model'
      crel NavItem, name: 'data'

export default LeftNav 