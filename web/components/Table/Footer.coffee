import React from 'react'
import {crel, tr, tfoot, th, td} from 'teact'
import {inject, observer} from 'mobx-react'
import {extendObservable, expr, action, runInAction} from 'mobx'
import cx from 'classnames'

FooterCell = observer(({
  column

}) ->
  th style: {fontWeight: 'bold'},className: column.alignClass, "#{column.format(column.subtotal)}"
)


TableFooter = observer(({
  footerClass = 'full-width'
  table
}) ->
  tfoot className: footerClass, ->
    tr className: 'collapsing', ->
      for column in table.columns
        if not column.footer?
          th null, ""
        else
          crel FooterCell,
            column: column
)

TableFooter.displayName = 'TableFooter'
export default TableFooter