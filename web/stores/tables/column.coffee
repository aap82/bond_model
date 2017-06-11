import {unprotect, types, getSnapshot, applySnapshot, getParent, hasParent} from 'mobx-state-tree'
import numeral from 'numeral'
import {objectWithProperties} from 'utils/helpers'

Subtotal = types.model({
  type: types.string
  text: types.maybe(types.string)
  weight: types.maybe(types.string)
})


columnProps = objectWithProperties
  table: null
  columns: null
  position: null
  alignClass: null
  selected: null
  subtotal: null
  key: types.identifier()
  header: types.maybe(types.string)
  footer: types.maybe(Subtotal)
  align: types.optional(types.string, 'left')
  type: types.optional(types.string, 'text')
  numeral: types.maybe(types.string)
  visible: types.optional(types.boolean, yes)
  selectable: types.optional(types.boolean, yes)
  editable: types.optional(types.boolean, yes)
  properties:
    table:
      get: -> getParent(@,2)

    columns:
      get: -> getParent(@)

    position:
      get: -> @columns.findIndex((c) => c is @)

    alignClass:
      get: -> @align + ' aligned'

    subtotal:
      get: ->
        return null unless @footer?
        if @footer.type is 'text'
          return @footer.text
        else if @footer.type is 'sum'
          sum = 0
          sum += row.data[@key] for row in @table.includedRows
          return sum
        else if @footer.type is 'weightedAverage'
          wtdAvg = 0
          wtdAvg += row.data[@key]*row.data[@table.subtotalWeight]/ @table.columns[@table.weightIndex].footerValue for row in @table.includedRows
          return wtdAvg




  format: (value) ->
    if @type isnt 'number'
      return value
    else if @numeral isnt null
      switch value
        when 0 then return ""
        else numeral(value).format(@numeral)
    else
      return numeral(value).format("0")

  parse: (value) ->
    return value unless @type is 'number'
    return parseInt(value, 10) unless @numeral
    decimals = @numeral.split('.')
    return parseInt(value, 10) unless decimals?[1]
    return parseFloat(value)









Object.defineProperty columnProps, 'selected',
  get: ->
    @position in @table.selected.columns



columnActions =
  select: ->
    @selected = yes

  unselect: ->
    @selected = no


Column = types.model('Column', columnProps, columnActions)

export {Column}
