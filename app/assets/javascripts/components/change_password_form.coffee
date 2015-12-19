ChangePasswordForm = React.createClass

  submit: (e)->
    e.preventDefault()

    @props.finished()

  fieldChanged: (field, new_value)->
    @props.infoChanged(field, new_value)

  render: ->
    R.section
      id: "password",
      R.div
        className: "container",
        R.form
          action: "#"
          onSubmit: @submit,
          SectionTitle(text: "Change Password")
          FieldRow(
            fields: [
              {
                type: "password"
                name: "password"
                required: true
                placeholder: "Password"
                value: @props.info.password || ""
              },
              {
                type: "submit"
                name: "submit"
                value: @props.submit_value
              }
            ]
          )

window.ChangePasswordForm = ChangePasswordForm
