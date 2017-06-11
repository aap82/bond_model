
import React from 'react'
import {crel, div,} from 'teact'
import {inject, observer} from 'mobx-react'
import mobx from 'mobx'
import Table from 'components/Table'
import {Menu, Header, Confirm} from 'semantic-ui-react'
import {ContextMenuTrigger, ContextMenu} from 'react-contextmenu';


LoanTableContextMenu_Body = observer(({table, onClick}) ->
  console.log 'render context'
  crel ContextMenu,
    id: 'loans_body',
    hideOnLeave: yes
    onShow: onClick,
    ->
      crel Menu, vertical: yes, ->
        crel Menu.Item,
          name: 'delete'



)


class LoanTable extends React.Component
  constructor: (props) ->
    super props
    @handleContextMenuClick =  (e, data) =>
#      console.log e
#      console.log data
      e.stopPropagation()
      e.preventDefault()

    @handleChange = (row, column, value) =>
      {actions} = @props
      actions.loans.loanUpdate({_id: row._id, "#{column.key}": value}).then((res) ->
        if res
          row[column.key] = value
      )


  render: ->
    {view} = @props.model
    {tables} = view
    console.log 'render loan table'
    div '.loan-table', =>
      crel Table,
        table: tables.get('loans')
        handleChange: @handleChange
        contextMenu:
          body: 'loans_body'

      crel LoanTableContextMenu_Body, table: tables.get('loans'), onClick: @handleContextMenuClick














LoanTable = inject('actions')(observer(LoanTable))
export default LoanTable

