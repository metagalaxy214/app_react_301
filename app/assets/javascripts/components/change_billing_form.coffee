ChangeBillingForm = React.createClass

  fieldChanged: (field, new_value)->
    @props.infoChanged(field, new_value)

  submit: (e)->
    e.preventDefault()

    @props.finished()

  render: ->
    R.section
      id: "billing",
      R.div
        className: "container",
        R.div
          className: "field-row",
          R.form
            action: "#"
            onSubmit: @submit,
            SectionTitle(text: "Billing")
            R.div className: "name-on-card", "Name on Card"
            FieldRow(
              fields: [
                {
                  type: "text"
                  name: "card_first_name"
                  required: true
                  placeholder: "First"
                  value: @props.info.card_first_name
                },
                {
                  type: "text"
                  name: "card_last_name"
                  required: true
                  placeholder: "Last"
                  value: @props.info.card_last_name
                }
              ]
            )
            FieldRow(
              fields: [
                
                {
                  type: "text"
                  name: "card_number"
                  required: true
                  placeholder: @props.info.card_placeholder_last4 || "Card Number"
                  value: @props.info.card_number
                  maxLength: 20
                },
                {
                  type: "text"
                  name: "card_cvv"
                  required: true
                  placeholder: "cvv"
                  value: @props.info.card_cvv
                  maxLength: 4
                },
                {
                  type: "text",
                  name: "card_exp_month"
                  required: true
                  placeholder: "Exp. Month"
                  maxLength: 2
                  value: @props.info.card_exp_month
                },
                {
                  type: "text"
                  name: "card_exp_year"
                  required: true
                  placeholder: "Exp. Year"
                  maxLength: 4
                  value: @props.info.card_exp_year
                }
              ]
            )
            FieldRow(
              fields: [
                {
                  type: "text"
                  name: "email"
                  required: true
                  placeholder: "Email Address"
                  value: @props.info.email
                },
                {
                  type: "text"
                  name: "phone"
                  required: true
                  placeholder: "Phone: (555) 555-5555"
                  minLength: 7
                  maxLength: 22
                  title: "Use format (555) 555-5555"
                  pattern: "^\(?\d{3}\)?[- ]?\d{3}[- ]?\d{4}$"
                  value: @props.info.phone
                }
              ]
            )
            FieldRow(
              fields: [
                {
                  type: "text"
                  name: "billing_address_1"
                  required: true
                  placeholder: "Address 1"
                  value: @props.info.billing_address_1
                },
                {
                  type: "text"
                  name: "billing_address_2"
                  required: false
                  placeholder: "Address 2"
                  value: @props.info.billing_address_2
                }
              ]
            )
            FieldRow(
              fields: [
                {
                  type: "text"
                  name: "billing_city"
                  required: true
                  placeholder: "City"
                  value: @props.info.billing_city
                },
                {
                  type: "select"
                  name: "billing_state"
                  required: true
                  placeholder: "State"
                  additionalOptions: (
                    key: state[0]
                    value: state[1]
                    selected: @props.info.billing_state == state[1]
                  )  for state in window.states_list
                },
                {
                  type: "text"
                  name: "billing_zip"
                  required: true
                  placeholder: "Zip Code"
                  value: @props.info.billing_zip
                  maxLength: 5
                }
              ]
            )
            FieldRow fields: [
              {
                type: "submit"
                name: "submit"
                value: @props.submit_value
              }
            ]



window.ChangeBillingForm = ChangeBillingForm
