RegisterForm = React.createClass

  fieldChanged: (field, new_value)->
    @props.fieldChanged(field, new_value)

  submit: (e)->
    e.preventDefault()

    @props.registerDone()

  fbConnect: ->
    FB.login (response) =>
      if response.status is "connected"
        @fbGetInfo()
      else if response.status is "not_authorized"
        alert "Unable to register through Facebook."

    , scope: "public_profile,email"

  fbGetInfo: ->
    FB.api "/me", (response) =>
      me = response
      window.fb_me = me

      @fieldChanged("first_name", me.first_name)
      @fieldChanged("last_name", me.last_name)
      @fieldChanged("email", me.email)
      @fieldChanged("email_confirmation", me.email)
      @fieldChanged("connect_facebook", true)

      auth = FB.getAuthResponse()
      @fieldChanged("uid", auth.userID)
      @fieldChanged("access_token", auth.accessToken)
      @fieldChanged("access_token_expires_at", auth.expiresIn)


  facebookRegister: (e)->
    e.preventDefault()

    FB.getLoginStatus (response)=>
      if response.status is "connected"
        @fbGetInfo()
      else
        @fbConnect()

  render: ->
    R.div
      className: "container",
      R.form
        action: "#"
        onSubmit: @submit,
        SectionTitle(text: "Register")
        RequiredFieldWarning(additional: R.div(className: "member", "Register to change your address, contact information, and hold deliveries while you are on vacation."))
        FieldRow(
          fields: [
            {
              type: "text",
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
        )
        FieldRow(
          fields: [
            {
              type: "email"
              name: "email"
              placeholder: "Email"
              required: true
              value: @props.info.email
            }, {
              type: "email"
              name: "confirm_email"
              placeholder: "Confirm Email"
              required: true,
              value: @props.info.email_confirmation
            }
          ]
        )
        FieldRow(
          fields: [
            {
              type: "password"
              name: "password"
              placeholder: "Password"
              required: true
              value: @props.info.password
            }
          ]
        )
#        R.div
#          className: "field-row",
#          R.a
#            className: "facebook-register"
#            href: "#"
#            onClick: @facebookRegister,
#            "Register through Facebook"
          R.div
            className: "field submit",
              R.input
                type: "submit"
                value: "Next"

window.RegisterForm = RegisterForm
