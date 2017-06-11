import {unprotect, types, getSnapshot, applySnapshot, getParent, hasParent, clone} from 'mobx-state-tree'

import {Column} from './column'
import {Row} from './row'
import {Selected} from './selected'
import {UP_ARROW, DOWN_ARROW, LEFT_ARROW, RIGHT_ARROW} from 'utils/keycodes'
import {handleKeyboardMove} from './actions'


tableProps =
  id: types.identifier()
  view: types.computed
  rows: types.computed
  ready: types.computed
  columns: types.array(Column)
  source: types.optional(types.array(Row), [])
  includedRows: null
  includedRowPositions: null
  isSelected: null
  areCellsSelected: null
  singleCellSelected: null
  multipleCellsSelected: null
  multipleRowsSelected: null
  newRows: types.optional(types.array(Row), [])
  selected: types.optional(Selected, {})
  editing: no
  selecting: no
  sortColumn: types.maybe(types.string)
  sortDirection: types.optional(types.number, -1)
  footer: types.optional(types.boolean, no)
  subtotalWeight: types.maybe(types.string)
  weightIndex: null

  selectionIncludeToggle: ->
    if @selected.rows.length < 2
      return null
    else
      for row in @selected.rows
        if @rows[row].included
          return yes
      return no



  getData: -> return (row.data for row in @rows)
  getDataIncluded: -> return (row.data for row in @includedRows)
  getSelectedRows: -> return (@rows[row].data for row in @selected.rows)
  getSelectedColumns: -> return (@columns[column] for column in @selected.columns)
  getSelectedColumnKeys: -> return (@columns[column].key for column in @selected.columns)
  getEditableSelectedColumnKeys: -> return (@columns[column].key for column in @selected.columns when @columns[column].editable)
  getEditableSelected: ->
    keys: @getEditableSelectedColumnKeys()
    rows: @getSelectedRows()




Object.defineProperty tableProps, 'view',
  get: -> getParent(@,2)

Object.defineProperty tableProps, 'rows',
  get: -> sortRows(@source, @sortColumn, @sortDirection)

Object.defineProperty tableProps, 'isSelected',
  get: -> @view.selectedTable is @id

Object.defineProperty tableProps, 'areCellsSelected',
  get: -> (@singleCellSelected or @multipleCellsSelected)

Object.defineProperty tableProps, 'singleCellSelected',
  get: -> (@selected.columns.length is 1 and @selected.rows.length is 1)

Object.defineProperty tableProps, 'multipleCellsSelected',
  get: -> (@selected.columns.length > 1 and @selected.rows.length > 1)
Object.defineProperty tableProps, 'multipleRowsSelected',
  get: -> @selected.rows.length > 1
Object.defineProperty tableProps, 'includedRows',
  get: -> @rows.filter((r) -> r.included is yes)

Object.defineProperty tableProps, 'includedRowPositions',
  get: -> (row.position for row in @includedRows)

Object.defineProperty tableProps, 'weightIndex',
  get: ->
    if @subtotalWeight is null
      return null
    else
      @columns.findIndex((c) => c.key is @subtotalWeight)

Object.defineProperty tableProps, 'ready',
  get: ->
    @source.length > 0 or @newRows.length > 0


tableActions =
  reset: ->  @selected.clear()
  select: -> @view.setSelectedTable(@id)
  unselect: -> @view.clearSelectedTable()
  startEditing: -> @editing = yes if @selected.single
  stopEditing: -> @editing = no
  selectCell: (row, column) ->
    return unless row in @includedRows
    @select() if not @isSelected
    @stopEditing() if @editing
    @startSelecting() unless @selecting
    @selected.setRow(row.position)
    @selected.setColumn(column.position)
  addSelectedCell: (row, column) ->
    @selected.addRow(row.position)
    @selected.addColumn(column.position)
    return
  removeSelectedCell: (row, column) ->
    return if @selected.single
    @selected.removeRowsAfter(row.position) if @selected.rows.length > 1
    @selected.removeColumnsAfter(column.position) if @selected.columns.length > 1
    return

  includeAllRows: -> @rows[row].include() for row in @selected.rows
  excludeAllRows: -> @rows[row].exclude() for row in @selected.rows




  setSortColumn: (column) ->  @sortColumn = column
  setSortDirection: (direction) -> @sortDirection = direction
  clearSortDirection: -> @sortDirection = 0
  sort: (column, direction) ->
    sortDirection = if column is @sortColumn then direction else -1
    @stopEditing() if @editing
    @setSortColumn(column)
    @setSortDirection(sortDirection)


#    data = sortRows(@rows, column, @sortDirection)

  createRows: (rows) -> @rows.replace ({data: row} for row in rows)
  addRow: (data) -> @rows.push({data: data})
  editRow: (row, key, value) -> row.edit(key, value)
  editSelectedRows: (source) ->
    {keys, rows} = @getEditableSelected()
    @editRow(row, key, source[key]) for row in rows for key in keys

  undo: ->@editing = no
  redo: -> @editing = no

  updateRow: ({data, key, update}) -> data.edit(key, update[key])



  edit: (type, options) ->
    switch type
      when 'updateCell' then @updateRow(options)
      when 'copyDown' then @editSelectedRows(@rows[@selected.first].data)



  toggleSelectedRows: ->
    return unless @selected.columns.length is 1
    rows =  (@rows[row] for row in @selected.rows)
    row.toggle() for row in rows

  startSelecting: -> @selecting = yes
  stopSelecting: -> @selecting = no

  arrowKey: handleKeyboardMove





Table = types.model('Table', tableProps, tableActions)

export {Table}


sortRows = (rows, key, dir) =>
  rows.sort((a, b) =>
    if a.data[key] > b.data[key]
      1 * dir
    else if a.data[key] is b.data[key]
      dir
    else
      -1 * dir
  )

sortSourceRows = (rows, key, dir) =>
  rows.sort((a, b) =>
    if a[key] > b[key]
      1 * dir
    else if a[key] is b[key]
      0
    else
      -1 * dir
  )


