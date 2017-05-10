import React from 'react'
import {crel, div, input, i} from 'teact'
import {inject, observer} from 'mobx-react'


Card = observer(({
  width = 4
  as = 'h3'
  title
  icon = yes
  iconName = 'edit'
  children

}) ->
  div className: "col-xs-#{width}", ->
    div className: 'ui top attached header inverted basic', ->
      div className: 'row middle between', ->
        crel "#{as}", "#{title}"
        i className: "#{iconName} icon" if icon
    div className: 'ui attached segment',  children

)

export default Card 