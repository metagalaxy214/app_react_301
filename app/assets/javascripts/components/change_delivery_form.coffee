ChangeDeliveryForm = React.createClass

  submit: (e)->
    e.preventDefault()

    @props.finished()

  fieldChanged: (field, new_value)->
    @props.infoChanged(field, new_value)

  render: ->
    R.section
      id: "delivery"
      R.div className: "container",
      R.form
        action: "#"
        onSubmit: @submit,
        SectionTitle(text: "Delivery")
        FieldRow fields: [
          {
            type: "text"
            name: "first_name"
            placeholder: "First"
            required: true
            value: @props.info.first_name
          }, {
            type: "text"
            name: "last_name"
            placeholder: "Last"
            required: true
            value: @props.info.last_name
          }
        ]
        FieldRow fields: [
          {
            type: "text"
            name: "address_1"
            placeholder: "Address 1"
            required: true
            value: @props.info.address_1
          }, {
            type: "text"
            name: "address_2"
            placeholder: "Address 2"
            required: false,
            value: @props.info.address_2
          }
        ]
        FieldRow fields: [
          {
            type: "text"
            name: "city"
            placeholder: "City"
            required: true
            value: @props.info.city
          }, {
            type: "select"
            name: "state"
            placeholder: "State"
            required: true
            additionalOptions: (
              key: state[0]
              value: state[1]
              selected: @props.info.state == state[1]
            ) for state in window.states_list
          }, {
            type: "text"
            name: "zip"
            placeholder: "Zip Code"
            required: true
            value: @props.info.zip
            maxLength: 5
          }
        ]
        FieldRow
          before:
            R.div className: "special-instructions", "Special Instructions"
          fields: [
            {
              type: "textarea"
              name: "special_instructions"
              required: false
              placeholder: ""
              value: @props.info.special_instructions
            }
          ]
        FieldRow fields: [
          {
            type: "submit"
            name: "submit"
            value: @props.submit_value
          }
        ]

window.ChangeDeliveryForm = ChangeDeliveryForm
