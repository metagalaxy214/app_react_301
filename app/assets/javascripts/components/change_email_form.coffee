ChangeEmailForm = React.createClass

  submit: (e)->
    e.preventDefault()

    @props.finished()

  fieldChanged: (field, new_value)->
    @props.infoChanged(field, new_value)

  render: ->
    R.section
      id: "email",
      R.div
        className: "container",
        R.form
          action: "#"
          onSubmit: @submit,
          SectionTitle(text: "Change Email")
          FieldRow(
            fields: [
              {
                type: "email"
                name: "current_email"
                required: true
                placeholder: "Current Email"
                value: @props.info.email
              },
              {
                type: "email"
                name: "new_email"
                required: true
                placeholder: "New Email"
                value: @props.info.new_email
              }
            ]
          )
          FieldRow(
            fields: [
              {
                type: "submit"
                name: "submit"
                value: @props.submit_value
              }
            ]
          )

window.ChangeEmailForm = ChangeEmailForm
