export newLoanColumns = [
  data: 'include'
  type: 'checkbox'
  width: 22
  className: 'htCenter htMiddle'
  manualColumnResize: no
,
  data:'seller'
  width: 80
  title: 'Seller'
  type: 'text'
  editor: 'text'
  selectable: no
,
  data:'name'
  width: 400
  title: 'Loan Name'
  type: 'text'
  editor: 'text'

,

  data:'oBal'
  width: 135
  title: 'Original Balance'
  type: 'numeric'
  editor: 'numeric'
  format: '0,000.00'
,
  data:'current'
  width: 135
  title: 'Current Balance'
  type: 'numeric'
  editor: no
  format: '0,000.00'


,
  data:'coupon'
  width: 100
  title: 'Coupon'
  type: 'numeric'
  editor: 'numeric'
  format: '0.0000'
,
  data:'adminRate'
  width: 100
  title: 'AdminRate'
  align: 'right'
  type: 'numeric'
  format: '0.0000'
  editor: 'numeric'

,
  data:'term'
  width: 100
  title: 'Term'
  align: 'right'
  type: 'numeric'
  editor: 'numeric'

,
  data:'amort'
  width: 100
  title: 'Amort'
  align: 'right'
  type: 'numeric'
  editor: 'numeric'

,
  data:'io'
  width: 100
  title: 'IO'
  align: 'right'
  type: 'numeric'
  editor: 'numeric'

,
  data:'open'
  width: 100
  title: 'Open'
  align: 'right'
  type: 'numeric'
  editor: 'numeric'

,
  data:'loanAge'
  width: 100
  title: 'Age'
  align: 'right'
  type: 'numeric'
  editor: 'numeric'

]

loanColumns = [
    key: 'include'
    type: 'toggle'
  ,
    key: 'seller'
    header: 'Seller'
    selectable: no
  ,
    key: 'name'
    header: 'Loan Name'
    footer:
      type: 'text'
      text: 'Total / Weighted Average'
  ,

    key: 'oBal'
    header: 'Original Balance'
    align: 'right'
    type: 'number'
    numeral: '0,000.00'
    footer:
      type: 'sum'
  ,
    key: 'currentBalance'
    editable: no
    header: 'Current Balance'
    align: 'right'
    type: 'number'
    numeral: '0,000.00'
    footer:
      type: 'sum'


,
    key: 'coupon'
    align: 'right'
    header: 'Coupon'
    type: 'number'
    numeral: '0.0000'
    footer:
      type: 'weightedAverage'

,
    key: 'adminRate'
    header: 'AdminRate'
    align: 'right'
    type: 'number'
    numeral: '0.0000'
    footer:
      type: 'weightedAverage'
  ,
    key: 'term'
    header: 'Term'
    align: 'right'
    type: 'number'
    footer:
      type: 'weightedAverage'
  ,
    key: 'amort'
    align: 'right'
    header: 'Amort'
    type: 'number'
    footer:
      type: 'weightedAverage'
  ,
    key: 'io'
    align: 'right'
    header: 'IO'
    type: 'number'
    footer:
      type: 'weightedAverage'
  ,
    key: 'open'
    header: 'Open'
    align: 'right'
    type: 'number'
    footer:
      type: 'weightedAverage'
  ,
    key: 'loanAge'
    header: 'Age'
    align: 'right'
    type: 'number'
    footer:
      type: 'weightedAverage'
]

export default loanColumns