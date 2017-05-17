import React from 'react'
import {crel, div, input,  td, tr, thead, th, tbody} from 'teact'
import {inject, observer} from 'mobx-react'
import TableHeader from './Header'
import TableRow from './Row'
import TableCell from './Cell'



class TableBody extends React.Component
  constructor: (props) ->
    super props


    @onContextMenu =  (e) ->
      console.log 'context menu'
      return unless @props.contextMenu?
      {tables} = @props
      return unless tables.selected.rows.length > 0
      e.stopPropagation()
      e.preventDefault()
      console.log 'context menu'


  render: ->
    {tableId, tables, rows, columns, contextMenu} = @props
    crel 'tbody',
      =>
        for row, i in rows
          crel TableRow,
            tableId: tableId
            tables: tables
            row: row
            contextMenu: contextMenu
            =>
              for column in columns
                crel TableCell,
                  tableId: tableId
                  tables: tables
                  row: row
                  column: column


export default TableBody
