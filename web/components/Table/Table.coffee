import React from 'react'
import {crel, div, input,  td, tr, thead, th, tbody} from 'teact'
import {inject, observer} from 'mobx-react'
import TableHeader from './Header'
import TableBody from './Body'


class Table extends React.Component
  constructor: (props) ->
    super props

  componentDidMount: ->
    document.addEventListener('keydown', @handleKeyBoardInput)

  componentWillUnmount: ->

    document.removeEventListener('keydown',@handleKeyBoardInput)


  handleKeyBoardInput: (e) =>
    {tableId, tables} = @props
    return if tableId isnt tables.selected.table
    return if e.keyCode not in [13, 27, 37, 39, 113, 40, 38]
    return if tables.isEditing unless e.keyCode in [13,27,113]
    switch e.keyCode
      when 13
        if tables.isEditing
          @handleInputSubmit()
        else
          tables.moveDown()
      when 113
        if tables.isEditing
          tables.doneEditing()
        else
          tables.startEditing()
      when 27
        if tables.isEditing
          tables.doneEditing()
        else
          tables.unSelectCell()
      when 37 then tables.moveLeft()
      when 38 then tables.moveUp()
      when 39 then tables.moveRight()
      when 40 then tables.moveDown()
      else return


  handleInputSubmit: =>
    {tables, handleChange} = @props
    {selected, inputValue} = tables
    handleChange(selected.row, selected.column, inputValue)
    tables.doneEditing()
  onContextMenu:  (e) =>
    return unless @props.contextMenu?
    {tables} = @props
    return unless tables.selected.rows.length > 0
    e.stopPropagation()
    e.preventDefault()
    console.log 'context menu'


  handleTableClick: (e) =>

    e.stopPropagation()
    e.preventDefault()

  render: ->
    {tableId, tables, table, contextMenu } = @props
    {rows, columns} = table
    crel 'table',
      onClick: @handleTableClick
      className: 'ui compact unstackable celled selectable striped small table ',
      =>

        crel TableHeader, columns: columns
        crel TableBody,
          tableId: tableId
          tables: tables
          columns: columns
          rows: rows
          contextMenu: contextMenu


export default Table
