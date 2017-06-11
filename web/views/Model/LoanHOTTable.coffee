import React from 'react'
import Handsontable from 'handsontable/dist/handsontable.full'
import SettingsMapper from './Table';

import {crel, div,} from 'teact'
import {inject, observer} from 'mobx-react'
import mobx from 'mobx'
import {newLoanColumns} from 'models/loan_tape/data_table'

columnHeaders = [
  ''
  'Seller'
  'Loan Name'
  'Original Balance'
  'Current Balance'
  'Coupon'
  'AdminRate'
  'Term'
  'Amort'
  'IO'
  'Open'
  'Age'

]
class Table extends React.Component
  constructor: (props) ->
    super()
    @instance = null
    @hooks = null
    @settings = new SettingsMapper
    @id = 'loans'

    @updateHot = (newSettings) =>
      @instance.updateSettings(newSettings)

  componentDidMount: ->
    console.log @props.loans
    table = document.getElementById(@id)
    newSettings =
      startRows: 50
      cells: (row, col, prop) =>
        return unless @instance?
        return if prop is 'include'
        cellProps =
          readOnly: if @instance.getSourceData()[row].include then no else yes
        return cellProps
      data: if @props.loans.length > 0 then @props.loans else null
      contextMenu: yes
      allowRemoveColumn: no
      columns: newLoanColumns
#
#      columnSorting:
#        column: 4
#        sortOrder: yes
      rowHeaders: yes
      fixedColumnsLeft: 2
      manualColumnResize: yes
      manualColumnFreeze: yes
#      stretchH: 'all'
      sortIndicator: yes
      enterBeginsEditing: no
      afterColumnResize: ((column, newSize) =>
        console.log column, newSize

      )
      afterChange: ((updates, source) =>

        return unless updates?
        rows = []
        rerender = no
        for update in updates
          [row, prop, before, after] = update
          return unless row not in rows
          rows.push row
          if before isnt after and prop not in ['include', 'seller', 'name']
            console.log row
            console.log @instance.getDataAtRow(row)
            console.log @instance.getSourceDataAtRow(row)
            current = @instance.getDataAtCell(row, 'current')
            newCurrent = @props.loans[row].cashflow()
            if current isnt newCurrent
              rerender = yes
        if rerender
          return @instance.render()

        return
#          return
#          [row, prop, before, after] = update
#          if before isnt after
#            console.log row, prop, before, after, source

      )


    @instance = new Handsontable(table, newSettings)
    Handsontable.dom.addEvent table, 'mousedown', (event) =>
      return if @props.loans.length is 0
      console.log 'yellow'
      if event.target.nodeName == 'INPUT' and event.target.type == 'checkbox'
        event.stopPropagation()
        @props.loans[event.target.getAttribute('data-row')].toggle()
        return @instance.render()
      return
    @instance.render()

  componentWillReceiveProps: (props, nextProps) ->
    console.log 'nextProps', props, nextProps
    @instance.loadData(if props.loans.length is 0 then null else props.loans)

    return

  componentDidReceiveProps: ->
    console.log 'table got props'
    @instance.render()


  componentWillUnmount: ->
    @instance.destroy()




  render: ->
    div id: @id














#LoanHOTTable = inject('actions')(observer(LoanHOTTable))
Table = observer(Table)
export default Table
