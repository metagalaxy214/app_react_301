FormField = React.createClass
  valueChanged: ->
    if @refs.input
      val = @refs.input.getDOMNode().value
    else if @refs.textarea
      val = @refs.textarea.getDOMNode().value

    @_owner.fieldChanged(@props.name, val)


  selectChanged: (a, b, c)->
    @_owner.fieldChanged(@props.name, b.selected)

  render: ->
    input_data = @props
    input_data.onChange = @valueChanged

    if @props.type == "select"
      input_data.ref = "select"
      delete input_data.type
      field = @renderSelect(input_data)
    else if @props.type == "textarea"
      input_data.ref = "textarea"
      delete input_data.type
      field = @renderTextarea(input_data)
    else if @props.type == "radio"
      input_data.ref = "input"

      # This is a hack to deal with radio button field classes
      # not matching up with the name, but rather the value
      value = input_data.name
      name = input_data.value

      input_data.name = name
      input_data.value = value

      field = @renderRadio(input_data)

      input_data.name = value
      input_data.value = name
    else
      input_data.ref = "input"
      field = @renderInput(input_data)

    R.div
      className: "field " + @props.name
      field

  renderSelect: (data)->
    data.noResultsText = "Invalid #{@props.placeholder}"
    data.placeholderTextSingle = @props.placeholder
    data.placeholderTextMultiple = @props.placeholder
    data.placeholder = @props.placeholder
    data.value = opt['value'] for opt in @props.additionalOptions when opt['selected'] == true
    data.onChange = @selectChanged

    Chosen data,
      R.option
        value: ""
        key: ""
        readOnly: true,
        ""
      (R.option({
        value: opt['value']
        key: opt['value']
        readOnly: true
      }, opt['value']) for opt in @props.additionalOptions)

  renderTextarea: (data)->
    R.textarea data

  renderRadio: (data)->
    R.label
      className: "radio",
      R.input data
      R.div
        className: "input",
        R.span null, data.label_name

  renderInput: (data)->
    R.input data

window.FormField = FormField
