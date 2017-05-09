import React from 'react'
import {crel, div, h1, h3, h2, h5, text } from 'teact'
import {inject, observer} from 'mobx-react'
import { Grid, Segment } from 'semantic-ui-react'
import {ToolBarDefault} from './ToolBar'


DealSettings = observer(({deal})->
  div ->
    switch deal._id
      when null then null
      else
        crel Segment,
          compact: yes
          ->
            h1 "#{deal.name.toUpperCase()}"
            div ->
              text "Type: "
              text "#{deal.type}"
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
        crel DealSettings, deal: deal








ModelViewEntry = inject('app', 'model', 'actions')(ModelViewEntry)

export default ModelViewEntry