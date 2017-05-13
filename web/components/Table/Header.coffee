import React from 'react'
import {tr, thead, th} from 'teact'
import {inject, observer} from 'mobx-react'
import {extendObservable, expr, action, runInAction} from 'mobx'





TableHeader = observer(({
  headerClass = 'full width'
  columns
}) ->
  thead className: headerClass, ->
    tr ->
      for column in columns
        th className: column.alignClass, "#{column.header}"
)

TableHeader.displayName = 'TableHeader'
export default TableHeader