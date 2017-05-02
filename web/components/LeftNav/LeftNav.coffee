import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import {expr} from 'mobx'
import { Menu } from 'semantic-ui-react'



NavItem = observer(({routing, name}) ->
  path = '/' + if name is 'home' then '' else name
  handleClick = (->    routing.push(if name is 'home' then '/' else name) )
  isActive = expr(-> routing.location.pathname is path)
  crel Menu.Item,
    name: name
    active: isActive
    onClick: handleClick
)

LeftNav = inject('routing')(({routing}) ->
  displayName: 'LeftNav'
  crel Menu,
    inverted: yes
    vertical: yes
    fixed: 'left', ->
      crel NavItem, name: 'home', routing: routing
      crel NavItem, name: 'model', routing: routing
      crel NavItem, name: 'data', routing: routing
)
export default LeftNav 