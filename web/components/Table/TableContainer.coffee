import React from 'react'
import {crel, div, input, table, td, tr, thead, th, tbody} from 'teact'
import {inject, observer} from 'mobx-react'
import {extendObservable, expr, action, runInAction} from 'mobx'
import numeral from 'numeral'
import {keys} from 'lodash'



class TableContainer extends React.Component
  constructor: (props) ->
    super props
    @columnKeys = keys(props.columns)
    extendObservable @, {

      active:
        isEditing: no
        row: null
        column: null
        value: null
        columnIndex: null


      startEditing: action(=>
        return if @active.isEditing
        runInAction(=>
          {row, column} = @active
          @active.isEditing = yes
          @active.value = @props.rows[row][column]
        )
      )
      handleCellSelect: action((row, column) =>
        runInAction(=>
          document.addEventListener('keydown', @handleKeyboardInput)
          @active.row = row
          @active.column = column
          @active.columnIndex = @columnKeys.findIndex((k) => k is column)
          @active.isEditing = no


        )
      ) 

      doneEditing: action(=>
        runInAction(=>
          document.removeEventListener('keydown',@handleKeyboardInput)
          @active.row = null
          @active.column = null
          @active.value = null
          @active.columnIndex = null
          @active.isEditing = no
        )

      )
      
      handleInputChange: action((e) =>@active.value = e.target.value)
      handleInputSubmit: action(=>
        runInAction(=>
          @props.handleChange(@active)
          @active.isEditing = no

        )
      )

      handleEnterKey: action(=>
        runInAction(=>
          if @active.isEditing
            @handleInputSubmit()
          else
            @moveDown()

        )
      )
      handleInputCancel: action(=>
        runInAction(=>
          if @active.isEditing
            @value = @props.rows[@active.row][@active.column]
            @active.isEditing = no
          else
            @doneEditing()
        )

      )
      moveLeft: action(=>
        return if @active.isEditing
        runInAction(=>
          if @active.columnIndex > 0
            @active.columnIndex--
            @active.column = @columnKeys[@active.columnIndex]
            @active.value =  @props.rows[@active.row][@active.column]
            @active.isEditing = no
        )
      )
      moveRight: action((code) =>
        return if @active.isEditing and code isnt 9

        runInAction(=>
          if @active.columnIndex < @columnKeys.length - 1
            @active.columnIndex++
            column = @columnKeys[@active.columnIndex]
            @active.column = column
            @active.value =  @props.rows[@active.row][column]
            @active.isEditing = no
        )
      )
      moveUp: action(=>
        runInAction(=>
          if @active.row > 0
            @active.isEditing = no
            @active.row--
            @active.value =  @props.rows[@active.row][@active.column]
        )
      )

      moveDown: action( =>
        runInAction(=>
          if @active.row < @props.rows.length - 1
            @active.row++
            @active.value =  @props.rows[@active.row][@active.column]
            @active.isEditing = no
        )
      )




    }

  handleKeyboardInput: (e) =>
    return if e.keyCode not in [13, 27, 37, 39, 113, 40, 38, 9]
    switch e.keyCode
      when 13 then @handleEnterKey()
      when 113 then @startEditing()
      when 27 then @handleInputCancel()
      when 9 then @moveRight(9)
      when 37 then @moveLeft()
      when 38 then @moveUp()
      when 39 then @moveRight(39)
      when 40 then @moveDown()
      else return


  render: ->
    {columns, rows} = @props
    table className: 'ui compact celled selectable striped small table ', =>
      thead className: 'full width', ->
        crel TableHeader, columns: columns
      tbody =>
        for row, i in rows
          crel TableRow, editing: @active, rowID: i, onCancel: @handleInputCancel, =>
            for key, column of columns
              className = if column.align? then "#{column.align} aligned" else ''
              crel TableCell,
                column: column
                editing: @active
                rowID: i
                property: key,
                format: column.format
                className: className,
                row: row,
                onStartEditing: @startEditing
                onClick: @handleCellSelect
                onChange: @handleInputChange
                onSubmit: @handleInputSubmit
                onCancel: @handleInputCancel



export default TableContainer



EditingCell = observer(class EditingCell extends React.Component
  componentDidMount: =>
    @focus()
  focus: =>    @textInput.focus()
  render: ->
    {editing, onChange, className, placeholder} = @props
    td className: className + ' editing-cell', =>
      div className: 'ui fluid tiny transparent input focus', =>
        crel 'input',
          placeholder: placeholder(),
          value: editing.value,
          ref: ((input) =>
            @textInput = input
          ),
          className: className,
          onChange: onChange
)





SelectedCell = observer(({editing, onClick, onChange, className, value}) ->
  switch editing.isEditing
    when no
      td onClick: onClick, className: className + ' selected-cell', "#{value()}"
    else
      crel EditingCell,
        onChange: onChange
        className: className
        editing: editing
        placeholder: value


)

TableCell = observer(({column, format = null, row, property, rowID, editing, onClick, onChange, className, onStartEditing}) ->
  isSelected = expr(-> editing.row is rowID and editing.column is property)
  handleClick = ((e)=>
    e.preventDefault
    onClick(rowID, property)
  )
  getValue = =>
    if column.type is 'number'
      value = numeral(row[property]).format(format)
    else
      row[property]

  switch isSelected
    when no
      td onClick: handleClick, className: className, "#{getValue()}"
    else
      crel SelectedCell,
        property: property,
        onClick: onStartEditing,
        row: row
        className: className
        editing: editing
        onChange: onChange
        value: getValue
)



TableHeader = observer(({columns}) ->
  tr ->
    for key, column of columns
      className = if column.align? then "#{column.align} aligned" else ''
      th className: className, "#{column.header}"
)


TableRow = observer(({editing, rowID, children}) ->
  isEditing = expr(-> editing.row is rowID)
  className = if isEditing then 'active' else ''
  tr className: className,
    children
)

