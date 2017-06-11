import React from 'react'
import {crel, tr, thead, th, input} from 'teact'
import {inject, observer} from 'mobx-react'
import {extendObservable, expr, action, runInAction} from 'mobx'
import cx from 'classnames'



ToggleHeader = observer(({table}) ->
  switch table.selectionIncludeToggle()
    when null then return th null, ""
    else
      isChecked = table.selectionIncludeToggle()
      toggleRows = ((e) ->
        e.preventDefault()
        e.stopPropagation()
        console.log isChecked
        switch isChecked
          when yes then table.excludeAllRows()
          else table.includeAllRows()
      )
      th onClick: toggleRows, ->
        input type: 'checkbox', checked: isChecked, onChange: (->)
)

HeaderCell = observer(({
  column
  table
}) ->
#  return crel ToggleHeader, table: table if column.key is 'include'
  return th null, "" unless column.header?
  isSorted = expr(-> column.key is table.sortColumn)
  direction =
    if !isSorted then no
    else
      switch table.sortDirection
        when 1 then 'ascending'
        when -1 then 'descending'
        else null

  className = cx(
    sorted: isSorted
    ascending: (direction is 'ascending')
    descending: (direction is 'descending')
    "#{column.alignClass}": yes


  )
  handleClick =  ((e) ->
    e.preventDefault()
    table.sort(column.key, table.sortDirection * -1)
  )
  th className: className, onClick: handleClick,
    "#{column.header}"
)







TableHeaderRow = observer(({
  headerClass = 'full-width'
  table
}) ->
  {columns} = table
  thead className: headerClass, ->
    tr className: 'collapsing', ->
      for column in columns
        crel HeaderCell,
          table: table
          column: column
)

TableHeaderRow.displayName = 'TableHeader'
export default TableHeaderRow