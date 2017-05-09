import React from 'react'
import { Dropdown as SemanticUIDropDown, Form} from 'semantic-ui-react'
import {inject, observer} from 'mobx-react'
import {label, crel, div, text, select, option} from 'teact'

DropDown = observer(({
  field

}) =>
  props = field.bind()
  props.className = 'ui selection search dropdown'
  div className: 'field', =>
    label "#{field.label}"
    select props, ->
      for item in field.extra
        option key: item.value, value: item.value, "#{item.text}"


)
export default DropDown