import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import numeral from 'numeral'

export class TableColumn
  constructor: (@key, column) ->
    @header = column.header or ''
    @alignClass = (column.align or 'left') + ' aligned'
    @type = column.type or 'text'
    @format = column.format or null
    extendObservable @, {
      visible: if column.hidden? then column.hidden else yes
      selectable: if column.selectable? then column.selectable else yes
      editable: if column.editable? then column.editable else yes
    }

export class Tables
  constructor: (@data) ->
    extendObservable @, {
      selected:
        table: null
        row: null
        rows: []
        column: null



      selectColumn: action((column) ->
        if column.selectable and column.visible
          @selected.column = column
      )
      selectCell: action((table, row, column) ->
        runInAction(=>
          @isEditing = no
          @selected.rows.clear()
          @selected.table = table
          @selected.row = row
          @selectColumn(column)
          @selectRow(row)
        )
      )
      unSelectCell: action(->
        runInAction(=>
          @isEditing = no
          @selected.table = null
          @selected.row = null
          @selected.column = null
          @selected.rows.clear()
        )
      )
      selectRow: action((row) ->
        @selected.rows.push row
      )

      selectRowsTo: action((row) ->
        runInAction(=>
          currentRow = @getRowIndex()
          selectedRow = @data[@selected.table].rows.findIndex((r) => r is row)
          if currentRow > selectedRow
            @selected.rows.replace(@data[@selected.table].rows[selectedRow..currentRow])
          else

            @selected.rows.replace(@data[@selected.table].rows[currentRow..selectedRow])


        )

      )

      unSelectRow: action((row) ->
        @selected.rows.remove row
      )

      isCellSelected: computed(->
        @selected.table isnt null or @selected.row isnt null or @selected.column isnt null
      )

      isEditing: no
      startEditing: action( ->@isEditing = yes)
      doneEditing: action(->@isEditing = no)

      inputValue: null
      inputValueChange: action((e) => @inputValue = e.target.value)

      getColumnIndex: action(->
        @data[@selected.table].columns.findIndex((c) => c is @selected.column)
      )
      getRowIndex: action(->
        @data[@selected.table].rows.findIndex((r) => r is @selected.row)
      )


      moveLeft: action(=>
        idx = @getColumnIndex()
        if idx > 0
          runInAction(=>
            @selectColumn @data[@selected.table].columns[idx-1]
            @selected.rows.clear()
            @selectRow(@selected.row)
          )
      )
      moveRight: action( =>
        idx = @getColumnIndex()
        if idx < @data[@selected.table].columns.length - 1
          runInAction(=>
            @selectColumn @data[@selected.table].columns[idx+1]
            @selected.rows.clear()
            @selectRow(@selected.row)
          )
      )

      moveUp: action(=>
        idx = @getRowIndex()
        @selected.row = @data[@selected.table].rows[idx-1] if idx > 0
        @selected.rows.clear()
        @selectRow(@selected.row)
      )

      moveDown: action( =>
        idx = @getRowIndex()
        if idx < @data[@selected.table].rows.length - 1
          @selected.row = @data[@selected.table].rows[idx+1]
          @selected.rows.clear()
          @selectRow(@selected.row)
      )

      formatValue: action((column, value) ->
        if column.format is null
          return value
        else if column.type is 'number'
          return numeral(value).format(column.format)
        else
          return value
      )


    }






