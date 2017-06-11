import React from 'react'
import {crel, div, tr, td,input} from 'teact'
import {expr} from 'mobx'
import {observer} from 'mobx-react'
import {getSnapshot, applySnapshot, clone} from 'mobx-state-tree'
import cx from 'classnames'



TableCell = observer((props) ->
  {column} = props

  if column.type is 'toggle'
    crel ToggleCell, props
  else
    crel SelectableCell, props

)


SelectableCell = observer(({
  table
  column
  row
}) ->
  {data} = row
  {alignClass} = column
  isSelected = expr(-> row.selected and column.selected and row.included and table.isSelected)
  isEditing = expr(-> isSelected and table.editing)
  className = cx(
    "#{alignClass}": yes
    active: isSelected
    disabled: !row.included
    editable: column.editable
    
  )


  handleMouseDown = ((e) ->
    return unless e.nativeEvent.which is 1
    e.stopPropagation()
    e.preventDefault()
    switch
      when isSelected and table.selected.single then table.startEditing() if column.editable
      else table.selectCell(row, column)
  )

  handleMouseEnter = ((e) ->
    return unless table.selecting
    e.stopPropagation()
    e.preventDefault()
    switch isSelected
      when no then table.addSelectedCell(row, column)
      else table.removeSelectedCell(row, column)

  )

  if isEditing
    crel EditingCell,
      table: table
      row: clone(data)
      column: column
      onSubmit: ((newData) ->
        return if data[column.key] is newData[column.key]
        table.edit('updateCell', {
          key: column.key
          data: data
          update: getSnapshot(newData)
        })

      )
  else
    td onMouseDown: handleMouseDown, onMouseEnter: handleMouseEnter, className: className, "#{column.format(data[column.key])}"

)

ToggleCell = observer(({row, column, table}) ->
  {selected} = table
  isSelected = expr(-> row.selected and column.selected and selected.columns.length is 1)
  toggleRow = (->row.toggle())
  className = cx(
    active: isSelected
    toggle: yes
  )
  td onClick: toggleRow, className: className, ->
    input type: 'checkbox', checked: row.included, onChange: (->)
)





EditingCell = observer(class extends React.Component
  constructor: (props) ->
    super props
    @focus = => @textInput.focus()

    @handleChange = (e) =>
      {row, column} = @props
      value = if e.target.value is "" then 0 else column.parse(e.target.value)
      row.edit(column.key, value)

    @handleKeyBoardInput = (e) =>
      return unless e.keyCode in [13, 27]
      {table, row} = @props
      return table.stopEditing() if e.keyCode is 27
      if e.keyCode is 13
        @props.onSubmit(row)
        table.stopEditing()


  componentDidMount: ->
    @focus()
    document.addEventListener('keydown', @handleKeyBoardInput)

  componentWillUnmount: ->  document.removeEventListener('keydown',@handleKeyBoardInput)

  render: ->
    {row, column} = @props
    {alignClass} = column
    value = if row[column.key] is 0 then "" else row[column.key]
    td className: alignClass + ' active editing', =>
      div className: 'ui fluid tiny transparent input focus', =>
        crel 'input',
          placeholder: column.format(column, row[column.key]),
          value: value,
          ref: ((input) => @textInput = input),
          className: alignClass,
          onChange: @handleChange
  )

TableCell.displayName = 'TableCell'

export default TableCell
