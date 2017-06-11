import React from 'react'
import {crel, div, input,  td, tr, thead, th, tbody} from 'teact'
import {extendObservable, action, computed} from 'mobx'
import {inject, observer} from 'mobx-react'
import TableHeader from './Header'
import TableFooter from './Footer'
import TableBody from './Body'
import {clone, getSnapshot, applySnapshot} from 'mobx-state-tree'
import {
  HOME, END,  ESCAPE, F2, SHIFT, CTRL, LEFT_ARROW, SPACE_BAR, DOWN_ARROW, d, z, y
} from 'utils/keycodes'


Table = observer(class  extends React.Component
  constructor: (props) ->
    super props
    extendObservable @, {
      shiftKey: no
      ctrlKey: no
      listening: computed(->
        count = 0
        count++ if @shiftKey
        count++ if @ctrlKey
        return count
      )
      keyPress: action((key, state) ->
        switch key
          when SHIFT then @shiftKey = state
          when CTRL then @ctrlKey = state

      )
    }

    @handleKeyBoardInput = (e) =>
      {table} = @props
      return if not table.isSelected or table.editing
      if e.keyCode in [SHIFT, CTRL]
        document.addEventListener('keyup', @handleKeyUp) if @listening is 0
        @keyPress(e.keyCode, yes)
      else if @ctrlKey and e.keyCode in [d, z, y]
        ctrlKeyActions(e, table)
      else if e.keyCode in [LEFT_ARROW..DOWN_ARROW] or e.keyCode in [HOME, END]
        table.arrowKey(e.keyCode,@shiftKey, @ctrlKey)
      else if e.keyCode in [SPACE_BAR] then table.toggleSelectedRows()
      else
        switch e.keyCode
          when F2 then table.startEditing()
          when ESCAPE then table.stopEditing()
          else return


    @handleKeyUp = (e) =>
      if e.keyCode in [16,17]
        document.removeEventListener('keyup', @handleKeyUp) if @listening is 1
        @keyPress(e.keyCode, no)
        return



  componentDidMount: -> document.addEventListener('keydown', @handleKeyBoardInput)
  componentWillUnmount: -> document.removeEventListener('keydown',@handleKeyBoardInput)

  render: ->
    {table, contextMenu} = @props
    crel 'table',
      className: 'ui small complex compact sortable unstackable celled selectable striped table ',
      =>
        crel TableHeader, table: table
        crel TableBody,
          table: table
          contextMenu: contextMenu.body
        if table.footer
          crel TableFooter,
            table: table

)
export default Table


ctrlKeyActions = (e, table) =>
  e.preventDefault()
  if e.keyCode in [z,y]
    switch e.keyCode
      when z then table.undo()
      when y then table.redo()
  else
    switch e.keyCode
      when d
        table.edit('copyDown', {selection: yes}) unless (table.selected.columns.length is 1) and (table.columns[table.selected.columns[0]].editable isnt yes)

