import React from 'react'
import {crel, tr} from 'teact'
import {expr} from 'mobx'
import {observer} from 'mobx-react'
import {ContextMenuTrigger} from 'react-contextmenu'




TableRow = observer(({
  children

  tables
  row
}) ->
  {selected} = tables
  isRowSelected = expr(-> row in selected.rows)
  className = if isRowSelected then 'active' else ''
  tr className: className,
    children

)

TableRow.displayName = 'TableRow'

export default TableRow