import React from 'react'
import {crel, div, input, i} from 'teact'
import {inject, observer} from 'mobx-react'
import cx from 'classnames'

Card = observer(({
  width = 4
  as = 'h3'
  title
  icon = yes
  iconName = 'edit'
  heading = null
  hidden
  children

}) ->
  attachedSegmentClassName = cx {
    ui: yes
    attached: yes
    segment: yes
    hidden: hidden
  }

  div className: "col-xs-#{width}", ->
    div className: 'ui top attached header inverted basic', ->
      div className: 'row middle between', ->
        if heading?
          heading()
        else
          crel "#{as}", "#{title}"
          i className: "#{iconName} icon" if icon
    div className: attachedSegmentClassName,  children

)

export default Card 