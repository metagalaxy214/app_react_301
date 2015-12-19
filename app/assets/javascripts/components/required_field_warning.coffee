RequiredFieldWarning = React.createClass
  render: ->
    R.div
      className: "field-row",
      @props.additional
      R.div
        className: "required",
        R.span null,
          "Required fields"
          R.span
            className: "asterisk"
            children: "*"

window.RequiredFieldWarning = RequiredFieldWarning
