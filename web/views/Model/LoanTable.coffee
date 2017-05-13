import React from 'react'
import {crel, div,} from 'teact'
import {inject, observer} from 'mobx-react'
import mobx from 'mobx'
import Table from 'components/Table'
import {Menu, Header, Confirm} from 'semantic-ui-react'
import {ContextMenuTrigger, ContextMenu} from 'react-contextmenu';


LoanTableBodyContextMenu = observer(({tables}) ->
  crel ContextMenu,
    id: 'loans_body', ->
    crel Menu, vertical: yes, ->
      if tables.selected.rows.length > 0
        crel Menu.Item,
          name: 'delete'
      else
        crel Menu.Item,
          name: 'addRow'
        crel Menu.Item,
          name: 'add10Rows'



)

class LoanTable extends React.Component
  constructor: (props) ->
    super props

  handleChange: (row, column, value) =>
    {actions} = @props
    actions.loans.loanUpdate({_id: row._id, "#{column.key}": value}).then((res) ->
      if res
        row[column.key] = value
    )


  render: ->
    {tables} = @props.model
    {loans} = tables.data

    div =>
      crel Table,
        tableId: 'loans'
        table: loans
        tables: tables
        handleChange: @handleChange
        contextMenu:
          body: yes
      crel LoanTableBodyContextMenu,
        tables: tables













LoanTable = inject('actions')(observer(LoanTable))
export default LoanTable
