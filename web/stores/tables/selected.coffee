import {unprotect, types, getSnapshot, applySnapshot, getParent, hasParent} from 'mobx-state-tree'
import {computed} from 'mobx'
import min from 'lodash/min'

selectedCellsProps =
  table: types.computed
  single: types.computed
  first: types.computed
  rows: types.optional(types.array(types.number), [])
  columns: types.optional(types.array(types.number), [])
  recent: ->
    row: if @rows.length > 0 then @rows[@rows.length-1] else -1
    column: if @columns.length > 0 then @columns[@columns.length-1] else -1

  cell: ->
    return null unless @single?
    return {
      row: @table.rows[@rows[0]]
      column: @table.columns[@columns[0]]
    }



userProps =
  firstName: types.string
  lastName: types.string
  fullName: null

Object.defineProperty userProps, 'fullName', ->
  get: -> @firstName + ' ' + @lastName




Object.defineProperty selectedCellsProps, 'single',
  get: ->  (@rows.length is 1 and @columns.length is 1)

Object.defineProperty selectedCellsProps, 'first',
  get: ->  min(@rows)

Object.defineProperty selectedCellsProps, 'table',
  get: ->  getParent(@)


selectedCellsActions =
  clear: ->
    @rows.clear()
    @columns.clear()
  clearRows: -> @rows.clear()
  clearColumns: -> @columns.clear()

  setRow: (newRow) -> @rows.replace([newRow]) if newRow?
  setRows: (newRows) -> @rows.replace(newRows)
  addRow: (newRow) -> @rows.push(newRow) if newRow not in @rows
  addRows: (newRows) -> @rows.push(newRow) for newRow in newRows when newRow not in @rows
  removeRow: (row) -> @rows.remove(row)
  removeRowsAfter: (row) ->
    idx = @rows.findIndex((r) -> r is row)
    @rows.splice(idx+1)

  removeActiveRow: -> @rows.pop()


  setColumn: (newColumn) -> @columns.replace([newColumn])
  setColumns: (newColumns) -> @columns.replace(newColumns)

  addColumn: (newColumn) -> @columns.push(newColumn) if newColumn not in @columns
  addColumns: (newColumns) -> @columns.push(newColumn) for newColumn in newColumns when newColumn not in @columns
  removeColumn: (column) -> @columns.remove(column)
  removeActiveColumn: -> @columns.pop()
  removeColumnsAfter: (column) ->
    idx = @columns.findIndex((c) -> c is column)
    @columns.splice(idx+1)





  setCell: (newRow, newColumn) ->
    @setRow(newRow)
    @setColumn(newColumn)






Selected = types.model('Selected', selectedCellsProps, selectedCellsActions)

export {Selected}
