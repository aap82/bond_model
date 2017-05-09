import validatorjs from 'validatorjs';
import MobxReactForm from 'mobx-react-form'
plugins = dvr: validatorjs

options = {}


name =
    name: 'name'
    label: "Deal Name"
    default: ''
    value: ''
    placeholder: "Enter Deal Name"
    rules: 'required|string'

    
type =
    type: 'select'
    name: 'type'
    label: "Type of Deal"
    value: 'initial'
    default: 'initial'
    extra: [
      {value: 'initial', text: 'Initial'}
      {value: 'test', text: 'Test'}
      {value: 'red', text: 'Red'}
      {value: 'launch', text: 'Launch'}
      {value: 'priced', text: 'Priced'}
      {value: 'preprice', text: 'Pre-Price'}
      {value: 'ra', text: 'RA'}
      {value: 'bbuyer', text: 'B-Buyer'}
      {value: 'other', text: 'Other' }
    ]




addDealForm = new MobxReactForm({ fields: {name} }, { plugins })
export {addDealForm}