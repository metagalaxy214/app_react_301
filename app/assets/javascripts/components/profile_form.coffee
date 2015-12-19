ProfileForm = React.createClass

  submit: (e)->
    e.preventDefault()

    @props.finished()

  fieldChanged: (field, new_value)->
    @props.infoChanged(field, new_value)

  render: ->
    R.section
      id: "profile",
      R.div
        className: "container",
        R.form
          action: "#"
          onSubmit: @submit,
          SectionTitle(text: "Profile")
          FieldRow(
            fields: [
              {
                type: "text"
                name: "first_name"
                required: true
                placeholder: "First"
                value: @props.info.first_name
              },
              {
                type: "text"
                name: "last_name"
                required: true
                placeholder: "Last"
                value: @props.info.last_name
              }
            ]
          )
          FieldRow(
            fields: [
              {
                type: "text"
                name: "phone_number"
                required: true
                placeholder: "Phone Number"
                value: @props.info.phone_number
              },
              {
                type: "submit"
                name: "submit"
                value: @props.submit_value
              }
            ]
          )

window.ProfileForm = ProfileForm
