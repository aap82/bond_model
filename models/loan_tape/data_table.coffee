
columns =
  seller:
    header: 'Seller'
    selectable: no
  name:
    header: 'Loan Name'
  oBal:
    header: 'Original Balance'
    align: 'right'
    type: 'number'
    format: '0,000.00'
  cBal:
    header: 'Current Balance'
    align: 'right'
    type: 'number'
    format: '0,000.00'
  coupon:
    align: 'right'
    header: 'Coupon'
    type: 'number'
    format: '0.0000'
  adminRate:
    header: 'AdminRate'
    align: 'right'
    type: 'number'
    format: '0.0000'
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

export default columns