import React from 'react'
import { Button, Header, Icon, Image, Modal } from 'semantic-ui-react'
import {crel, div} from 'teact'


import {inject, observer} from 'mobx-react'
ModalContainer = inject('modal')(observer(class ModalContainer extends React.Component
  constructor: (props) ->
    super props

  onClose: () ->
    console.log 'closing'
    @props.modal.closeModal()


  render: ->
    {modal} = @props
    if modal.isOpen is no
      div ->
        null
    else
      console.log modal.component
      crel Modal,
        size: 'small'
        onClose: @onClose
        open: modal.isOpen, ->
          crel Modal.Header, "#{modal.header}"
          crel modal.component






))


export default ModalContainer