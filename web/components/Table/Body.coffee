import React from 'react'
import cx from 'classnames'
import {expr} from 'mobx'
import {crel, div, input,  td, tr, thead, th, tbody} from 'teact'
import {inject, observer} from 'mobx-react'
import TableCell from './Cell'
import {ContextMenuTrigger, ContextMenu} from 'react-contextmenu';



TableBody = observer(class  extends React.Component
  constructor: (props) ->
    super props


    @onContextMenu =  (e) ->

      console.log 'context menu'

    @onMouseUp = (e) =>
      return unless @props.table.selecting
      e.stopPropagation()
      e.preventDefault()
      @props.table.stopSelecting()


  render: ->
    {table, contextMenu} = @props
    {rows, columns} = table
    crel 'tbody', onMouseUp: @onMouseUp, =>
      for row, i in rows
        crel ContextMenuTrigger,
          renderTag: 'tr'
          id: contextMenu
          attributes:
            className: 'compact collapsing'
            onContextMenu: @onContextMenu
          =>

#        tr className: 'collapsing', =>
            for column, j in columns
              crel TableCell,
                table: table
                row: row
                column: column


)
export default TableBody
