import React from 'react'
import {crel, div, h1, h3, h2, h5, text, br,i } from 'teact'
import {inject, observer} from 'mobx-react'
import { Grid, Segment } from 'semantic-ui-react'
import {ToolBarDefault} from './ToolBar'
import Card from 'components/Card'
import LoanHOTTable from './LoanHOTTable'
import cx from 'classnames'

ToggleArrow = observer(({store, prop, action}) ->
  className = cx
    chevron: yes
    down: if store? then store[prop] else yes
    right: if store? then !store[prop] else no
    icon: yes
  div className: 'toggle-icon', onClick: ((e) ->
    store[action]()
  ), ->
    i className: className
)



LoansSection = observer(({model, models}) ->
  console.log models.loans.length
  console.log 'render loans section'
  loanHeader = ->
    div style: width: '20%', ->
      div className: 'row middle start', ->
        crel ToggleArrow, store: model, prop: 'loansVisible', action: 'toggleLoansVisibility'
        h1 className: 'header-title', 'Loan'
    i className: "edit icon"


  crel Card,
    width: 12
    as: 'h2'
    hidden: no
    title: 'Loans'
    ->
      crel LoanHOTTable, loans: models.loans
)

DealSettings = observer(({model})->
  div ->
    br()
    div className: 'row top', ->
      crel Card,
        width: 2
        title: 'Settings', ->
          div 'HELLO'
          div 'HELLO'
          div 'HELLO'
      crel Card,
        width: 2
        title: 'Settings', ->
          div 'HELLO'
          div 'HELLO'
          div 'HELLO'
      crel Card,
        width: 2
        title: 'Settings', ->
          div 'HELLO'
          div 'HELLO'
          div 'HELLO'
    br()
)

class ModelViewEntry extends React.Component
  constructor: (props) ->
    super props


    @submitAddNewDeal = (id, form) =>
      @props.actions.deal.dealCreate(form.values()).then((result) =>
        @props.models.topBar.closePopups() if result
      )


    @loadDeal = (id) =>
      @props.actions.deal.dealGetByID(id).then((result) =>
        @props.models.open result if result?
        @props.models.topBar.closePopups()
      )

    @closeDeal = =>
      @props.models.close()

  componentDidMount: ->
    @props.actions.deal.dealsGetAllSummary().then((result) =>
      @props.models.deals.replace(result or [])
    )

  render: ->
    {models} = @props
    {model, topBar, popOuts} = models
    div onClick: @handleClick, style: height: '100vh', =>
      crel ToolBarDefault,
        topBar: topBar
        models: models
        onNewDealSubmit: @submitAddNewDeal
        onLoadDealSubmit: @loadDeal
        onCloseDeal: @closeDeal
      crel DealSettings, model: model
      crel LoansSection, model: model, models: models











ModelViewEntry = inject('app', 'models', 'actions')(observer(ModelViewEntry))

export default ModelViewEntry