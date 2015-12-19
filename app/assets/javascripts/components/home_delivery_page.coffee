HomeDeliveryPage = React.createClass
  getInitialState: ->
    {
      server_preferences: []
      order:
        first_name: ""
        last_name: ""
        address_1: ""
        address_2: ""
        city: ""
        state: ""
        zip_code: ""
        phone: ""
        shipping_special_instructions: ""
        preferences: []
      checkout_info:
        card_first_name: ""
        card_last_name: ""
        card_number: ""
        card_cvv: ""
        card_exp_month: ""
        card_exp_year: ""
        promo: ""
        email: ""
        billing_first_name: ""
        billing_last_name: ""
        billing_address_1: ""
        billing_address_2: ""
        billing_city: ""
        billing_state: ""
        billing_zip: ""
        billing_phone: ""
      registration:
        first_name: ""
        last_name: ""
        email: ""
        confirm_email: ""
        password: ""
        fbAuthResponse: ""
    }

  handleOpen: (area, callback)->
    $(area).slideDown 500, =>
      new_state = @state
      @setState(callback(new_state))

    setTimeout ->
      Utilities.scroll_to area
    , 250


  showOrder: ->
    @handleOpen "#delivery", (new_state)->
      new_state.show_order = true
      new_state

  orderChanged: (field, new_value)->
    new_state = @state
    new_state.order[field] = new_value

    @setState(new_state)

  showCheckout: ->
    @createSubscriptionOnServer =>
      @handleOpen "#checkout", (new_state)->
        new_state.show_checkout = true
        new_state

  createSubscriptionOnServer: (callback)->
    params = subscription:
      recipient_first_name: @state.order.first_name
      recipient_last_name: @state.order.last_name
      shipping_address_line1: @state.order.address_1
      shipping_address_line2: @state.order.address_2
      shipping_city: @state.order.city
      shipping_state: @state.order.state
      shipping_zipcode: @state.order.zip_code
      recipient_phone: @state.order.phone
      shipping_special_instructions: @state.order.shipping_special_instructions
      preference_ids: @state.order.preferences

    jQuery.ajax
      url: "/api/subscriptions"
      method: "POST"
      data: params
      success: (response, status, jqxhr)=>
        if response.status == "success"
          callback()

          new_state = @state
          new_state.pending_subscription_id = response.pending_subscription_id
        else
          alert "Something went wrong!"


      error: (jqxhr, status, response)=>
        alert @generateErrorMessage(jqxhr.responseJSON.errors)

      
  generateErrorMessage: (error)->
    return "Something went wrong" unless error

    message = ""
    if error.constructor == Object
      message += "#{key}: #{error[key]}\n" for key in Object.keys(error)
    else if error.constructor == String
      message += error
    else if error.constructor == Array
      message += "#{val}\n" for val in error

    message

  checkoutChanged: (field, new_value)->
    new_state = @state
    new_state.checkout_info[field] = new_value

    @setState(new_state)

  showRegister: ->
    @handleOpen "#register", (new_state)->
      new_state.show_register = true
      new_state

  registrationChanged: (field, new_value)->
    new_state = @state
    new_state.registration[field] = new_value

    @setState(new_state)

  setBillingToShipping: ->
    new_state = @state
    new_state.checkout_info.billing_first_name = @state.order.first_name
    new_state.checkout_info.billing_last_name = @state.order.last_name
    new_state.checkout_info.billing_address_1 = @state.order.address_1
    new_state.checkout_info.billing_address_2 = @state.order.address_2
    new_state.checkout_info.billing_city = @state.order.city
    new_state.checkout_info.billing_state = @state.order.state
    new_state.checkout_info.billing_zip = @state.order.zip_code
    new_state.checkout_info.billing_phone = @state.order.phone

    @setState(new_state)

  showConfirmation: ->
    @registerOnServer (referral_code)=>
      @handleOpen "#confirm", (new_state)->
        new_state.show_confirm_order = true
        new_state.referral_code = referral_code
        new_state

  registerOnServer: (callback)->
    params = {
      user:
        first_name: @state.registration.first_name
        last_name: @state.registration.last_name
        phone_number: @state.order.phone
        email: @state.registration.email
        email_confirmation: @state.registration.confirm_email
        password: @state.registration.password
        connect_facebook: @state.registration.connect_facebook
        uid: @state.registration.uid
        access_token: @state.registration.access_token
        access_token_expires_at: @state.registration.access_token_expires_at
      card:
        first_name: @state.checkout_info.card_first_name
        last_name: @state.checkout_info.card_last_name
        card_number: @state.checkout_info.card_number
        cvv: @state.checkout_info.card_cvv
        expiration_month: @state.checkout_info.card_exp_month
        expiration_year: @state.checkout_info.card_exp_year
        address_line1: @state.checkout_info.billing_address_1
        address_line2: @state.checkout_info.billing_address_2
        city: @state.checkout_info.billing_city
        state: @state.checkout_info.billing_state
        zipcode: @state.checkout_info.billing_zip
      subscription_id: @state.pending_subscription_id
    }

    jQuery.ajax
      url: "/api/users/register"
      method: "POST"
      data: params

      success: (response, status, jqxhr)->
        if response.status == "success"
          callback(response.referral_code)
        else
          alert "Something went wrong!"

      error: (jqxhr, status, response)=>
        alert @generateErrorMessage(jqxhr.responseJSON.errors)

  confirmOnServer: (callback)->
    jQuery.ajax
      url: "/api/subscriptions/#{@state.pending_subscription_id}"
      method: "PUT"

      success: (response, status, jqxhr)->
        if response.status == "success"
          callback()
        else
          alert "Something went wrong!"

      error: (jqxhr, status, response)=>
        alert @generateErrorMessage(jqxhr.responseJSON.errors)

  confirmationComplete: (e)->
    e.preventDefault()

    $("a.account").attr("href", "/account") # To take them to the account page

    @confirmOnServer =>
      @handleOpen "#thank-you", (new_state)->
        new_state.show_thank_you = true
        new_state

  componentDidMount: ->
    @_fetchPrefs({})

  _fetchPrefs: (data) ->
    $.ajax 
      url: "/preference"
      method: "GET"
      dataType: "json"
    .done @_fetchPrefsDone
    .fail @_fetchPrefsFail

  _fetchPrefsDone: (data, textStatus, jqXHR) ->
    @setState
      server_preferences: data

  _fetchPrefsFail: (xhr, status, err) => 
    console.error status, err.toString()

  preferenceSubmit: (e)->
    e.preventDefault()
    temp_selected = []
    $('#checkbox-row input:checked').each ->
      temp_selected.push($(this).attr('value'))
    @setPreferences(temp_selected)
    @handleOpen "#delivery", (new_state)->
      new_state.show_order = true
      new_state

  setPreferences: (temp_selected)->
    new_state = @state
    new_state.order.preferences = temp_selected
    @setState(new_state)
    




  render: ->
    R.div null,
      JoinUs()
      R.section
        id: "preferences"
        R.div
          className: "container",
          R.img
            className: "section-title-image" 
            src: "/assets/preferences.png"
          R.p null,  "Please check any meats, fish, or shellfish you don't want us to cook with so that we personalize each menu to your preferences. Poultry, Beef and Pork are used by our chefs on a regular basis. You can always changes these settings in your account profile." 

          R.p null, "We do not unfortunately have any vegetarian meals at the moment but stay tuned."
          R.form
            action: "#"
            onSubmit: @preferenceSubmit,
            ref: "form"
            R.div
              className: "field-row"
              id: "checkbox-row"
              ref: "checks"
              for preference in @state.server_preferences
                R.label
                  className: "checkbox after"
                  R.input 
                    type: "checkbox"
                    value: "#{preference.id}"
                  R.div
                    className: "input"
                    R.span null, "#{preference.name}"

      R.section
        id: "delivery"

        SubscribeOrder({
          orderDone: @showCheckout
          orderChanged: @orderChanged
          order: @state.order
        })
      R.section
        id: "checkout"
        className: "#{"hidden" unless @state.show_checkout && @state.show_thank_you != true}",
        CheckoutForm({ info: @state.checkout_info, setBillingToShipping: @setBillingToShipping, checkoutChanged: @checkoutChanged, checkoutDone: @showRegister })
      R.section
        id: "register"
        className: "#{"hidden" unless @state.show_register && @state.show_thank_you != true}",
        RegisterForm({
          info: @state.registration
          fieldChanged: @registrationChanged
          registerDone: @showConfirmation
        })
      R.section
        id: "confirm"
        className: "#{"hidden" unless @state.show_confirm_order && @state.show_thank_you != true}",
        R.div
          className: "container",
          R.img
            className: "section-title-image" 
            src: "/assets/onelaststep.png"
          OrderSummariesList({
            orders: [{
              meal:
                description: "Chef-Crafted Meals Delivered to You for $70 a Week."
              address_1: @state.order.address_1
              address_2: @state.order.address_2
              first_name: @state.order.first_name
              last_name: @state.order.last_name
              city: @state.order.city
              state: @state.order.state
              zip_code: @state.order.zip_code
            }]
          })
          R.div
            className: "complete-order",
            R.a
              href: "#"
              onClick: @confirmationComplete
              className: "complete-order-link",
              "Complete Order"

      R.section
        id: "thank-you"
        className: "#{"hidden" unless @state.show_thank_you}"
        ThankYouBox({
          referral_code: @state.referral_code
        })

window.HomeDeliveryPage = HomeDeliveryPage
