import React from 'react'
import {crel, div, input} from 'teact'
import {inject, observer} from 'mobx-react'
import ReactDataGrid from 'react-data-grid'
import {Editors, Formatters} from 'react-data-grid-addons'








Collateral = observer(class Collateral extends React.Component
  constructor: (props) ->
    super props

  handleGridRowsUpdated: (e) =>
    console.log  e


  render: ->
    console.log 'render'
    {store} = @props
    crel ReactDataGrid,
      enableCellSelect: yes
      columns: store.columns
      rowGetter: store.getLoan
      rowsCount: store.loans.length
      headerRowHeight: 35
      rowHeight: 25
      onGridRowsUpdated: store.handleUpdate
      onCellsDragged: (-> return)





)


export default Collateral 