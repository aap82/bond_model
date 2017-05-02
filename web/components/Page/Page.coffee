import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import {Header, Container} from 'semantic-ui-react'

Page = observer(class Page extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {title} = @props
    div style: {paddingTop: 5, paddingLeft: 5}, =>
      crel Header,
        as: 'h1'
        "#{title}"
      crel 'div', @props.children
)

export default Page 