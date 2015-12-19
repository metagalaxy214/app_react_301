DeliveryForm = React.createClass
  fieldChanged: (field, newValue)->
    @props.orderChanged(field, newValue)

  render: ->
    R.div
      className: "container"
      R.form
        action: "#"
        onSubmit: @props.finished,
        SectionTitle({ text: "Gift to" })
        RequiredFieldWarning({})
        FieldRow({
          fields: [
            {
              type: "text",
              name: "first_name"
              placeholder: "First"
              required: true
              value: @props.order.first_name
            }, {
              type: "text"
              name: "last_name"
              placeholder: "Last"
              required: true
              value: @props.order.last_name
            }
          ]
        })
        FieldRow({
          fields: [
            {
              type: "text",
              name: "address_1",
              placeholder: "Address 1",
              required: true
              value: @props.order.address_1
            }, {
              type: "text",
              name: "address_2",
              placeholder: "Address 2",
              required: false,
              value: @props.order.address_2
            }
          ]
        })
        FieldRow fields: [
          {
            type: "text"
            name: "city"
            placeholder: "City"
            required: true
            value: @props.order.city
          }
          {
            type: "select"
            name: "state"
            placeholder: "State"
            required: true
            title: "State"
            additionalOptions: (
              key: state[0]
              value: state[1]
              selected: @props.order.state == state[1])  for state in window.states_list
          }
          {
            type: "text"
            name: "zip_code"
            placeholder: "Zip Code"
            required: true
            maxLength: 5
            value: @props.order.zip_code
          }
        ]
        FieldRow fields: [
          {
            type: "tel"
            name: "phone"
            placeholder: "Phone"
            required: true
            value: @props.order.phone
          }
          {
            type: "email"
            name: "email"
            placeholder: "Gift Email"
            required: true
            value: @props.order.email
          }
        ]
        R.div
          className: "field-row",
          R.div
            className: "gift-message",
            "Gift Message"
          R.div
            className: "field gift_message",
            R.textarea
              name: "gift_message"
              value: @props.order.gift_message
              onChange: =>
                @fieldChanged "gift_message", $("textarea[name='gift_message']").val()
              onBlur: =>
                @fieldChanged "gift_message", $("textarea[name='gift_message']").val()
        R.div
          className: "field-row",
          R.div
            className: "field submit",
            R.input
              type: "submit"
              value: "Next"
              readOnly: true

window.DeliveryForm = DeliveryForm
