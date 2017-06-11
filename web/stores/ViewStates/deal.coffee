import {unprotect, types, getSnapshot, applySnapshot, getParent, hasParent} from 'mobx-state-tree'
import moment from 'moment'

datesProps =
  settlement: types.string
  firstPayment: types.string
  pricing: types.string




datesActions =
  edit: (key, value) -> @[key] = value if @[key] isnt value



Dates = types.model('Dates', datesProps, datesActions)



dealProps =
  _id: types.optional(types.string, '')
  dealID: types.optional(types.string, '')
  name: types.optional(types.string, '')
  type: types.optional(types.string, 'initial')
  loanIDs: types.optional(types.array(types.string), [])
  dates: types.optional Dates, {
    settlement: (new Date("7/20/17")).toUTCString()
    firstPayment: (new Date("8/15/17")).toUTCString()
    pricing: (new Date("5/5/22")).toUTCString()
  }

Deal = types.model('Deal', dealProps)
console.log 'test'

export {Deal}

