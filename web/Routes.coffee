import { Router, Route,  Redirect,  Miss, Switch} from 'react-router-dom'
import {inject, observer} from 'mobx-react'
import {crel, div,h2} from 'teact'
import Home from './views/Home'
import Model from './views/Model'
DataRoute = observer(({match}) ->
  div ->
    h2 "DATsA ROUTE"
)

HomeRoute = observer(({match}) ->
  div ->
    h2 "HOME sdfsfROUTE"
)


Routes = ->
  div ->

    crel Route,
      path: '/'
      component: ((props) -> crel(Home, props))
      exact: yes
    crel Route,
      path: '/model'
      component: ((props) -> crel(Model, props))
      exact: yes



export default Routes