CheckoutForm = React.createClass
  fieldChanged: (field, newValue)->
    @props.checkoutChanged(field, newValue)

  submit: (e)->
    e.preventDefault()

    @props.checkoutDone()

  render: ->
    R.div
      className: "container",
      R.img
        className: "section-title-image" 
        src: "/assets/checkout.png"
      R.form
        action: "#"
        onSubmit: @submit,
        RequiredFieldWarning({ additional: R.div(className: "name-on-card", "Name on Card")})
        FieldRow fields: [
          {
            type: "text"
            name: "card_first_name"
            placeholder: "First"
            required: true
            value: @props.info.card_first_name
          }
          {
            type: "text"
            name: "card_last_name"
            placeholder: "Last"
            required: true
            value: @props.info.card_last_name
          }
        ]
        FieldRow fields: [
          {
            type: "select"
            name: "card_type"
            placeholder: "Card type"
            additionalOptions: (
              key: state[0]
              value: state[1]
              selected: @props.info.cardtype == state[1]
            )  for state in window.cardtypes_list
          }
          {
            type: "text"
            name: "card_number"
            required: true
            placeholder: "Card Number"
            maxLength: 20
            value: @props.info.card_number
          }
          {
            type: "text"
            name: "card_cvv"
            required: true
            placeholder: "cvv"
            maxLength: 4
            value: @props.info.card_cvv
          }
          {
            type: "text"
            name: "card_expires"
            required: true
            placeholder: "expires"
            maxLength: 6
            value: @props.info.card_expires
          }

        ]

        FieldRow fields: [
          {
            type: "text"
            name: "promo"
            placeholder: "Promo Code"
            value: @props.info.promo
          }
          {
            type: "submit"
            name: "apply_promo"
            value: "Apply"
            readOnly: true
          }
          {
            type: "submit"
            name: "submit"
            value: "Next"
            readOnly: true
          }
        ]

        SectionTitle({ text: "\u00a0" })
        R.div
          className: "field-row",
          R.div
            className: "billing-address",
            "Billing Address"
            if @props.setBillingToShipping
              R.label
                className: "checkbox after"
                unselectable: "on"
                onClick: @props.setBillingToShipping,
                  R.input type: "checkbox"
                  R.div
                    className: "input",
                    R.span null, "Same as Shipping"

        FieldRow fields: [
          {
            type: "text"
            name: "billing_first_name"
            required: true
            placeholder: "First"
            value: @props.info.billing_first_name
          }
          {
            type: "text"
            name: "billing_last_name"
            required: true
            placeholder: "Last"
            value: @props.info.billing_last_name
          }
        ]
        FieldRow fields: [
          {
            type: "text"
            name: "billing_address_1"
            placeholder: "Address 1"
            required: true
            value: @props.info.billing_address_1
          }
          {
            type: "text"
            name: "billing_address_2"
            placeholder: "Address 2"
            value: @props.info.billing_address_2
          }
        ]
        FieldRow fields: [
          {
            type: "text"
            name: "billing_city"
            placeholder: "City"
            required: true
            value: @props.info.billing_city
          }
          {
            type: "select"
            name: "billing_state"
            placeholder: "State"
            required: true
            additionalOptions: (
              key: state[0]
              value: state[1]
              selected: @props.info.billing_state == state[1]
            )  for state in window.states_list
          }
          {
            type: "text"
            name: "billing_zip"
            placeholder: "Zip"
            required: true
            maxLength: 5
            value: @props.info.billing_zip
          }
        ]
        FieldRow fields: [
          {
            type: "text"
            name: "billing_phone"
            placeholder: "Phone"
            required: true
            value: @props.info.billing_phone
          }
          {
            type: "submit"
            name: "submit"
            value: "Next"
            readOnly: true
          }
        ]

window.CheckoutForm = CheckoutForm
