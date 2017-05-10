import React from 'react'
import {crel, div, h1, h3, h2, h5, text, br } from 'teact'
import {inject, observer} from 'mobx-react'
import { Grid, Segment } from 'semantic-ui-react'
import {ToolBarDefault} from './ToolBar'
import Card from 'components/Card'
import LoanTable from './LoanTable'


LoansSection = observer(({model}) ->
  div className: 'row top', ->
    crel Card,
      as: 'h1'
      width: 12
      title: 'Loans', ->
        switch model.deal.length
          when 0
            div 'Upload Loans'
          else
            crel LoanTable, model: model





)



DealSettings = observer(({deal, model})->
  div ->
    switch deal._id
      when null then null
      else
        div ->
          h1 "#{deal.name.toUpperCase()}"
          text "Type: "
          text "#{deal.type}"

        div className: 'row top', ->
          crel Card,
            title: 'Settings', ->
              div 'HELLO'
              div 'HELLO'
              div 'HELLO'
          crel Card,
            title: 'Settings', ->
              div 'HELLO'
              div 'HELLO'
              div 'HELLO'
        br()
        crel LoansSection, model: model

)

class ModelViewEntry extends React.Component
  constructor: (props) ->
    super props

  componentDidMount: ->
    @props.actions.deal.dealsGetAllSummary().then((result) =>
      @props.model.deals.replace(result or [])
    )


  submitAddNewDeal: (id, form) =>
    @props.actions.deal.dealCreate(form.values()).then((result) =>
      @props.app.toolbar.closePopups() if result
    )
  loadDeal: (id) =>
    @props.actions.deal.dealGetByID(id).then((result) =>
      @props.model.loadDeal result if result?
      @props.app.toolbar.closePopups()
    )

  closeDeal: =>
    @props.model.closeDeal()


  render: ->
    {model, app} = @props
    {toolbar} = app
    {deal} = model
    div =>
      crel ToolBarDefault,
        toolbar: toolbar
        model: model
        onNewDealSubmit: @submitAddNewDeal
        onLoadDealSubmit: @loadDeal
        onCloseDeal: @closeDeal
      div style: padding: 5, =>
        crel DealSettings, deal: deal, model: model









ModelViewEntry = inject('app', 'model', 'actions')(ModelViewEntry)

export default ModelViewEntry