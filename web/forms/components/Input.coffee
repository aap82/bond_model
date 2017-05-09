import React from 'react'
import { Form, Message, Input as SemanticUIInput, Container } from 'semantic-ui-react'
import {inject, observer} from 'mobx-react'
import {crel, div, text, input, label} from 'teact'
import cx from 'classnames'

Input = observer(({
  field

}) =>
  mainClass = cx(
    field: yes
    required: field.rules?.match('required')?
    error: field.error?
  )


  div className: mainClass, ->
    label "#{field.label}"
    input field.bind()









)
export default Input