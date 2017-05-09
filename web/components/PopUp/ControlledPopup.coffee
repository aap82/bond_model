import React from 'react'
import { Popup} from 'semantic-ui-react'
import {crel, div} from 'teact'
import {inject, observer} from 'mobx-react'
import {expr} from 'mobx'

ControlledPopup = inject('app')(observer(({
  id
  store
  openID
  trigger
  handleOpen = null
  handleClose= null
  children
  position = null
  basic = yes
  inverted = no
  flowing = yes
  hoverable = no
  content = null
  offset = 0
  hideOnScroll = no
}) ->
  isOpen = expr(-> store[openID] is id)
  crel Popup,
    id: id
    open: isOpen
    onOpen: handleOpen
    onClose: handleClose
    hoverable: hoverable
    trigger: trigger
    basic: basic
    inverted: inverted
    flowing: flowing,
    content: content
    offset: offset
    position: position
    hideOnScroll: hideOnScroll
    on: 'click'
    content: children



))


ControlledPopup.displayName = 'ControlledPopup'

export default ControlledPopup