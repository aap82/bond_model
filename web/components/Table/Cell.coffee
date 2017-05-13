import React from 'react'
import {crel, div, tr, td} from 'teact'
import {expr} from 'mobx'
import {observer} from 'mobx-react'



TableCell = observer(({
  tableId,
  tables,
  column,
  row,
}) ->
  {alignClass} = column
  isSelected = expr(->
    tables.selected.row is row and
    tables.selected.column is column and
    tables.selected.rows.length is 1
  )


  shiftKeyClick = ->
    tables.selectRowsTo(row)



  ctrlKeyClick = ->
    if row in tables.selected.rows
      tables.unSelectRow(row)
    else
      tables.selectRow(row)



  unSelectedClick = ((e) ->
    e.stopPropagation()
    e.preventDefault()
    return shiftKeyClick() if e.shiftKey
    return ctrlKeyClick() if e.ctrlKey
    tables.selectCell(tableId, row, column)
  )
  unSelectedDoubleClick = ((e) ->
    e.stopPropagation()
    e.preventDefault()
    tables.selectCell(tableId, row, column)
    tables.startEditing()
  )
  selectedSingleOrDoubleClick = ((e) ->
    e.stopPropagation()
    e.preventDefault()
    if column.editable then tables.startEditing()

  )
  onEditingClick = ((e) ->
    e.stopPropagation()
    e.preventDefault()
    tables.doneEditing()

  )
  if not column.selectable
    return td className: alignClass, "#{tables.formatValue(column, row[column.key])}"
  else if !isSelected
    return td onClick: unSelectedClick, onDoubleClick: unSelectedDoubleClick, className: alignClass, "#{tables.formatValue(column, row[column.key])}"
  else if tables.isEditing and column.editable
    return crel EditingCell,
      tables: tables
      row: row
      column: column
      onClick: onEditingClick
  else
    className = alignClass + ' selected-cell'
    return td onClick: selectedSingleOrDoubleClick, onDoubleClick: selectedSingleOrDoubleClick,  className: className, "#{tables.formatValue(column, row[column.key])}"

)




EditingCell = observer(class extends React.Component
  componentWillMount: =>
    {tables, row, column} = @props
    tables.inputValue = row[column.key]
    return
  componentDidMount: => @focus()
  focus: => @textInput.focus()
  render: ->
    {tables, row, column} = @props
    {inputValueChange} = tables
    {alignClass} = column
    td className: alignClass + ' editing-cell', =>
      div className: 'ui fluid tiny transparent input focus', =>
        crel 'input',
          placeholder: tables.formatValue(column, row[column.key]),
          value: tables.inputValue,
          ref: ((input) => @textInput = input),
          className: alignClass,
          onChange: inputValueChange
)

TableCell.displayName = 'TableCell'

export default TableCell
