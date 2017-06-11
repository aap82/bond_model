import {END, HOME, SPACE_BAR, UP_ARROW, DOWN_ARROW, LEFT_ARROW, RIGHT_ARROW} from 'utils/keycodes'

rowAbove = ({selected, rows, columns, includedRowPositions}, row, column) ->
  return 0 unless rows[row]? and columns[column]?
  if selected.columns.length is 1 and columns[column].type is 'toggle'
    currentPosition = rows[row].position
    return 0 unless currentPosition > 0
    currentPosition - 1
  else
    currentPosition = rows[row].positionIncluded
    return 0 unless currentPosition > 0
    includedRowPositions[currentPosition-1]

rowBelow = ({selected, rows, columns, includedRows, includedRowPositions}, row, column) ->
  return row.position unless rows[row]? or columns[column]?
  if selected.columns.length is 1 and columns[column].type is 'toggle'
    currentPosition = rows[row].position
    return row.position unless currentPosition < rows.length - 1
    currentPosition + 1
  else
    currentPosition = rows[row].positionIncluded
    return row.position unless currentPosition < includedRows.length - 1
    includedRowPositions[currentPosition+1]




export handleKeyboardMove = (key, shiftKey, ctrlKey) ->
  {row, column} = @selected.recent()

  if not shiftKey and not ctrlKey
    switch key
      when UP_ARROW then @selected.setCell(rowAbove(@, row, column), column)
      when DOWN_ARROW then @selected.setCell(rowBelow(@, row, column), column)
      when LEFT_ARROW then @selected.setCell(row, column-1) if column > 0 #and @columns[column-1].type isnt 'toggle'
      when RIGHT_ARROW then @selected.setCell(row, column+1) if column < @columns.length-1
      when HOME then @selected.setCell(row, 0)
      when END then @selected.setCell(row, @columns.length-1)
      else return
  else if shiftKey and ctrlKey
    switch key
      when UP_ARROW then @selected.setRows([0..@selected.rows[0]]) if @selected.rows[0] isnt @includedRows[0].position
      when DOWN_ARROW then @selected.setRows([@includedRowPositions[@includedRows.length-1]..@selected.rows[0]]) if @selected.rows[0] isnt @includedRows[@includedRows.length-1].position

      when LEFT_ARROW then @selected.setColumns([0..@selected.columns[0]]) if @selected.columns[0] isnt 0
      when RIGHT_ARROW then @selected.setColumns([@columns.length-1..@selected.columns[0]])if @selected.columns[0] isnt @columns.length - 1
  else if shiftKey
    if key in [UP_ARROW, DOWN_ARROW]
      newRow = if key is UP_ARROW then rowAbove(@, row, column) else rowBelow(@, row, column)
      switch
        when newRow in @selected.rows then @selected.removeActiveRow()
        else @selected.addRow(newRow) if -1 < newRow <= @includedRowPositions[@includedRowPositions.length-1]
    else if key in [LEFT_ARROW, RIGHT_ARROW]
      newColumn = column + if key is LEFT_ARROW then -1 else 1
      switch
        when newColumn in @selected.columns then @selected.removeActiveColumn()
        else @selected.addColumn(newColumn) if -1 < newColumn < @columns.length-1
  else if ctrlKey
    switch key
      when UP_ARROW then @selected.setCell(@includedRows[0].position, column)
      when DOWN_ARROW then @selected.setCell(@includedRows[@includedRows.length-1].position, column)
      when LEFT_ARROW then @selected.setCell(row, 0)
      when RIGHT_ARROW then @selected.setCell(row, @columns.length-1)
      when HOME then @selected.setCell(0, 0)
      when END then @selected.setCell(@includedRows[@includedRows.length-1].position, @columns.length-1)
      else return



