import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import PopoutWindow from 'react-popout'

class PopOutWindow extends React.Component
  constructor: (props) ->
    super props

  render: ->
    {popOut} = @props
    return null unless popOut.isOpen
    crel PopoutWindow,
      title: popOut.id
      onClosing: (-> popOut.close())
      ->
        div 'hello'





PopOutWindow = inject(({popOutStore}, {id}) =>
  console.log id
  popOut: popOutStore.popOuts.get(id)
)(observer(PopOutWindow))
export default PopOutWindow