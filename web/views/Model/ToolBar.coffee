import React from 'react'
import {crel, div, h1, h2, h5, text, select, option, label,br,button } from 'teact'
import {inject, observer} from 'mobx-react'
import {expr, extendObservable, action, computed} from 'mobx'
import {Menu, Header, Confirm} from 'semantic-ui-react'
import FormContainer from 'forms/FormContainer'
import ControlledPopup from 'components/PopUp/ControlledPopup'
import Input from 'forms/components/Input'
import DropDown from 'forms/components/DropDown'




SelectDealSection = observer(class extends React.Component
    constructor: (props) ->
      super props

      extendObservable @, {
        selectedID: props.model.id or ''
      }

      @handleChange = (e) => @selectedID = e.target.value
      @handleSubmit = => @props.onSubmit(@selectedID) if @selectedID isnt ''

    render: ->
      {model} = @props

      div className: 'ui form', =>
        div className: 'field', =>
          label 'Select Deal'
          select className: 'ui search dropdown', value: @selectedID, onChange: @handleChange, ->
            option value: '', 'Select Deal'
            for deal in model.deals
              option key: deal._id, value: deal.lastUsed, "#{deal.name}"
        button type: 'submit', className: 'ui submit button positive', onClick: @handleSubmit, 'Load'


)

AddNewDealForm  = inject('forms')(observer(({id, forms, onSubmit, onCancel}) ->
  crel FormContainer,
    id: id,
    onSubmit: onSubmit,
    onCancel: onCancel
    form: forms.dealCreate, ->
    crel Header, 'Add New Deal'
    div className: 'ui fields', ->
      crel(Input, field: forms.dealCreate.$('name'))
))




ToolBarDefault = observer(({
  models,
  onNewDealSubmit
  onLoadDealSubmit
  onCloseDeal
  topBar
}) ->
  {openPopup, closePopups} = topBar
  LoadDealTrigger = crel Menu.Item,
    name: 'loadDeal'
  AddDealTrigger = crel Menu.Item,
    icon: 'plus'
    name: 'addNewDeal'
  div className: 'row middle between top-bar z-depth-2', ->
#    h1 "Model Page"
    crel Menu,
      inverted: yes,
      floated: 'right',
      =>
        switch models.loans.length
          when 0
            crel ControlledPopup,
              id: 'dealOpen',
              store: topBar
              openID: 'popupID'
              position: 'bottom left'
              trigger: LoadDealTrigger
              handleOpen: openPopup
              handleClose: closePopups, ->
                crel SelectDealSection,
                  model: models
                  onSubmit: onLoadDealSubmit
            crel ControlledPopup,
              id: 'dealCreate',
              store: topBar
              openID: 'popupID'
              handleOpen: openPopup
              trigger: AddDealTrigger, ->
                crel AddNewDealForm,
                  id: 'dealCreate',
                  onSubmit: onNewDealSubmit
                  onCancel: closePopups
          else
            div className: "row middle start", ->
#              div ->
#                h1 "#{models.model.view.deal.name.toUpperCase()}"
              div ->
                crel Menu.Item,
                  name: 'closeDeal'
                  onClick: onCloseDeal



)

ToolBarDefault.displayName = 'ToolbarDefault'

export {ToolBarDefault}