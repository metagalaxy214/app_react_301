SubscribeOrder = React.createClass
  fieldChanged: (field, newValue)->
    @props.orderChanged(field, newValue)

  submit: (e)->
    e.preventDefault()

    @props.orderDone()

  render: ->
    R.div
      className: "container"
      R.img
        className: "section-title-image" 
        src: "/assets/createaccount.png"
      R.form
        action: "#"
        onSubmit: @submit,
        RequiredFieldWarning({ additional: R.div(className: "label-address", "ADDRESS")})
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

        R.div
          className: "field-row login-form"
          R.div
            action: "#"
            className: "login-form-left"
            onSubmit: @submit,
            R.div(className: "label-login", "LOGIN")
            FieldRow({
              fields: [
                {
                  type: "email",
                  name: "email"
                  placeholder: "Email Address"
                  value: ""
                }, {
                  type: "password"
                  name: "password"
                  placeholder: "Password"
                  value: ""
                }
              ]
            })
          R.div
            className: "action-buttons",
            R.div
              className: "field-row"
              R.div
                className: "label-or-facebook",
                "- OR -"
              R.div
                className: "signin-facebook "
                R.a
                  className: "signin-facebook-button"
                  href: "#no-im-done-adding-gifts",
                  "Sign in with Facebook"
            R.div
              className: "field-row subscribe-next",
              R.div
                className: "field submit",
                R.input
                  type: "submit"
                  value: "Next"
                  readOnly: true


window.SubscribeOrder = SubscribeOrder
