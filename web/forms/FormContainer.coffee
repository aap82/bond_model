import React from 'react'
import {crel, div, form, br, button} from 'teact'
import Input from 'forms/components/Input'
import DropDown from 'forms/components/DropDown'
import {inject, observer} from 'mobx-react'

FormContainer = observer(class FormContainer extends React.Component
  constructor: (props) ->
    super props

  componentWillMount: -> @props.form.set(@props.form.defaults())
  componentWillUnmount: -> @props.form.clear()
  handleSubmit: (e) =>
    {id, onSubmit} = @props

    @props.form.onSubmit(e, {
      onSuccess: ((form) -> onSubmit(id, form))
      onError: ((form) -> form.invalidate())
    })


  render: ->
    {onCancel} = @props
    console.log 'render form container'
    form className: 'ui form', onSubmit: @handleSubmit, =>
      crel 'div', @props.children
      div className: 'ui submit button positive', onClick: @handleSubmit, 'Submit'
      div className: 'ui cancel button negative', onClick: onCancel, 'Cancel'



)



export default FormContainer





