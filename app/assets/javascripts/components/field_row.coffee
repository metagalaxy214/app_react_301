FieldRow = React.createClass
  fieldChanged: (field, newValue)->
    @_owner.fieldChanged(field, newValue)

  render: ->
    R.div
      className: "field-row",
      @props.before
      FormField(field) for field in @props.fields

window.FieldRow = FieldRow
