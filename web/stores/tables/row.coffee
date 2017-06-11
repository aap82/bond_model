import {unprotect, types, getSnapshot, applySnapshot, getParent, hasParent} from 'mobx-state-tree'
import {Loan} from '../ViewStates/loan'
import {Deal} from '../ViewStates/deal'
import {randomUuid} from 'utils/uuid'
import {objectWithProperties} from 'utils/helpers'

rowProps = objectWithProperties
  id: types.identifier()
  table: null
  position: null
  positionIncluded: null
  selected: null
  included: types.optional(types.boolean, yes)
  data: Loan
  sourcePosition: -> @table.source.findIndex((r) => r is @data)
  properties:
    table:
      get: -> getParent(@,2)
    position:
      get: -> @table.rows.findIndex((r) => r is @)
    positionIncluded:
      get: -> @table.includedRows.findIndex((r) => r is @)
    selected:
      get: -> @position in @table.selected.rows

rowActions =
  update: (data) ->  @data = data
  toggle: -> @included = !@included
  include: -> @included = yes
  exclude: -> @included = no
  select: ->
    return unless @positionIncluded > -1
    @table.select() if not @table.isSelected




Row = types.model('Row', rowProps,rowActions)



export {Row}