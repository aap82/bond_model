import React from 'react'
import {crel, div, h1, h2, h5, text, select, option, label,br,button,th } from 'teact'
import {inject, observer} from 'mobx-react'
import TableContainer from 'components/Table'
import {expr, extendObservable, action, computed} from 'mobx'
import * as Table from 'reactabular-table'
import * as edit from 'react-edit'
import numeral from 'numeral'
rightAligned = (name) => div className: 'right aligned', "#{name}"
loanAmount = (value) => div className: 'right aligned', "#{numeral(value).format('0,000.00')}"
coupon = (value) => div className: 'right aligned', "#{numeral(value).format('0.0000')}"

class LoanTable extends React.Component
  constructor: (props) ->
    super props

    @columns =
      seller:
        header: 'Seller'
        type: 'text'
      name:
        header: 'Loan Name'
        type: 'text'
      oBal:
        header: 'Original Balance'
        align: 'right'
        type: 'number'
      cBal:
        header: 'Current Balance'
        align: 'right'
        type: 'number'
      coupon:
        align: 'right'
        header: 'Coupon'
        type: 'number'
      adminRate:
        header: 'AdminRate'
        align: 'right'
        type: 'number'
      term:
        header: 'Term'
        align: 'right'
        type: 'number'
      amort:
        align: 'right'
        header: 'Amort'
        type: 'number'
      io:
        align: 'right'
        header: 'IO'
        type: 'number'
      open:
        header: 'Open'
        align: 'right'
        type: 'number'
      loanAge:
        header: 'Age'
        align: 'right'
        type: 'number'

  render: ->
    {model} = @props
    crel TableContainer, rows: model.loans, columns: @columns






export default LoanTable
