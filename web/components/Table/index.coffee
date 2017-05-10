import TableContainer from './TableContainer'
export default TableContainer


#
#editable = edit.edit {
#  isEditing: (({ columnIndex, rowData}) => columnIndex is rowData.editing)
#  onActivate: (( {columnIndex, rowData}) =>
#    console.log columnIndex, rowData
#    index = @props.model.loans.findIndex((l) -> l._id is rowData._id)
#    @props.model.loans[index].editing = columnIndex
#    console.log @props
#  )
#  onValue: (({value, rowData, property}) =>
#    console.log value, rowData, property
#
#  )
#
#}



#
#class EditingCell extends React.Component
#  componentDidMount: => @textInput.focus()
#  render: ->
#    {onChange, className, editing, onChange} = @props
#    td className: className + ' editing-cell', =>
#      div className: 'ui fluid tiny transparent input focus', =>
#        crel InputCell,
#          ref: ((input) =>
#            @textInput = input
#          ),
#          className: className + ' focus',
#          editing: editing
#          onChange: onChange
