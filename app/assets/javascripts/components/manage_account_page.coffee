ManageAccountPage = React.createClass
  getInitialState: ->
    {
      submit_values:
        profile: "Update"
        password: "Update"
        email: "Update"
        billing: "Update"
        delivery: "Update"
        vacation_hold_place: "Submit"
        vacation_hold_cancel: "Cancel Vacation Hold"
        cancel_membership: "Cancel Membership"
        renew_membership: "Renew Membership"
      user_info: {}
      card_info: {}
      delivery_info: {}
      vacation_hold: ""
      user_id: null
      has_active_subscription: true
    }

  componentDidMount: ->
    jQuery.ajax
      method: "GET"
      url: "/api/users/current"
      success: (response, status, xhr)=>
        user = response.user
        card = response.card || @blankCard
        subscription = response.subscription

        new_state = @state
        new_state.user_id = user.id

        new_state.subscription_held = subscription.on_hold

        if subscription.status == "active"
          new_state.has_active_subscription = true
        else
          new_state.has_active_subscription = false

        new_state.subscription_id = subscription.id
        new_state.user_info =
          first_name: user.first_name
          last_name: user.last_name
          phone_number: user.phone_number
          email: user.email

        new_state.card_info =
          card_placeholder_last4: "Card ending in: #{card.last4}"
          card_exp_month: card.exp_month
          card_exp_year: card.exp_year
          card_first_name: card.name.split(" ")[0]
          card_last_name: card.name.split(" ").slice(1).join(" ")
          email: subscription.recipient_email
          phone: subscription.recipient_phone
          billing_address_1: card.address_line1
          billing_address_2: card.address_line2
          billing_city: card.address_city
          billing_state: card.address_state
          billing_zip: card.address_zip

        new_state.delivery_info =
          first_name: subscription.recipient_first_name
          last_name: subscription.recipient_last_name
          address_1: subscription.shipping_address_line1
          address_2: subscription.shipping_address_line2
          city: subscription.shipping_city
          state: subscription.shipping_state
          zip: subscription.shipping_zipcode
          special_instructions: subscription.shipping_special_instructions

        @setState(new_state)


      error: (xhr, status, response)->
        alert "Error loading user."


  profileChanged: (field, new_value)->
    new_state = @state
    new_state.user_info[field] = new_value

    @setState(new_state)

  profileFinished: ->
    new_state = @state
    new_state.submit_values.profile = "Updating"
    @setState(new_state)

    @updateProfileOnServer =>
      new_state = @state
      new_state.submit_values.profile = "Update"
      @setState(new_state)

  passwordChanged: (field, new_value)->
    new_state = @state
    new_state.user_info[field] = new_value
    @setState(new_state)

  passwordFinished: ->
    new_state = @state
    new_state.submit_values.password = "Updating"
    @setState(new_state)

    @updateProfileOnServer =>
      new_state = @state
      new_state.submit_values.password = "Update"
      @setState(new_state)

  emailChanged: (field, new_value)->
    new_state = @state
    new_state.user_info[field] = new_value
    @setState(new_state)

  emailFinished: ->
    new_state = @state
    new_state.submit_values.email = "Updating"
    @setState(new_state)

    @updateProfileOnServer =>
      new_state = @state
      new_state.submit_values.email = "Update"
      @setState(new_state)

  updateProfileOnServer: (callback)->
    data = user:
      first_name: @state.user_info.first_name
      last_name: @state.user_info.last_name
      phone_number: @state.user_info.phone_number
      email: @state.user_info.new_email
      password: @state.user_info.password

    jQuery.ajax
      method: "PATCH"
      url: "/api/users/#{@state.user_id}"
      data: data

      success: (response, status, xhr)->
        callback()

      failure: (xhr, status, response)->
        alert "Unable to save profile information."
        callback()

  updateBillingOnServer: (callback)->
    data = billing:
      first_name: @state.card_info.card_first_name
      last_name: @state.card_info.card_last_name
      email: @state.card_info.email
      phone: @state.card_info.phone
      card_number: @state.card_info.card_number
      card_cvv: @state.card_info.card_cvv
      card_expiration_month: @state.card_info.card_exp_month
      card_expiration_year: @state.card_info.card_exp_year
      address_line1: @state.card_info.billing_address_1
      address_line2: @state.card_info.billing_address_2
      city: @state.card_info.billing_city
      state: @state.card_info.billing_state
      zipcode: @state.card_info.billing_zip

    jQuery.ajax
      method: "PATCH"
      url: "/api/billing/#{@state.user_id}"
      data: data

      success: (response, status, xhr)->
        callback()

      error: (xhr, status, response)->
        response = JSON.parse(xhr.responseText)
        if typeof(response.errors) == "string"
          alert response.errors
        else
          alert "Unable to save billing information."

        callback()

  updateShippingOnServer: (callback)->
    data = subscription:
      recipient_first_name: @state.delivery_info.first_name
      recipient_last_name: @state.delivery_info.last_name
      shipping_address_line1: @state.delivery_info.address_1
      shipping_address_line2: @state.delivery_info.address_2
      shipping_city: @state.delivery_info.city
      shipping_state: @state.delivery_info.state
      shipping_zipcode: @state.delivery_info.zip
      shipping_special_instructions: @state.delivery_info.special_instructions

    jQuery.ajax
      method: "PATCH"
      url: "/api/subscriptions/#{@state.subscription_id}"
      data: data

      success: (response, status, xhr)->
        callback()

      error: (xhr, status, response)->
        alert "Unable to save shipping information."

        callback()

  billingChanged: (field, new_value)->
    console.log "#{field}: #{new_value}"
    new_state = @state
    new_state.card_info[field] = new_value
    @setState(new_state)

  billingFinished: ->
    new_state = @state
    new_state.submit_values.billing = "Updating"
    @setState(new_state)

    @updateBillingOnServer =>
      new_state = @state
      new_state.submit_values.billing = "Update"
      @setState(new_state)

  deliveryChanged: (field, new_value)->
    new_state = @state
    new_state.delivery_info[field] = new_value
    @setState(new_state)

  deliveryFinished: ->
    new_state = @state
    new_state.submit_values.delivery = "Updating"
    @setState(new_state)

    @updateShippingOnServer =>
      new_state = @state
      new_state.submit_values.delivery = "Update"
      @setState(new_state)

  vacationHoldChanged: (field, new_value)->
    new_state = @state
    new_state.vacation_hold = new_value

    @setState(new_state)

  vacationHoldCanceled: ->
    new_state = @state
    new_state.submit_values.vacation_hold_cancel = "Cancelling hold"
    @setState(new_state)

    @renewOnServer (response)=>
      new_state = @state
      new_state.submit_values.vacation_hold_cancel = "Cancel Vacation Hold"
      new_state.subscription_id = response.subscription.id
      new_state.has_active_subscription = true
      new_state.subscription_held = false
      @setState(new_state)

  vacationHoldFinished: ->
    return if @state.vacation_hold == ""

    if confirm("Are you sure you want to place a hold on your membership?")
      new_state = @state
      new_state.submit_values.vacation_hold_place = "Submitting"
      @setState(new_state)

      @placeHoldOnServer =>
        new_state = @state
        new_state.submit_values.vacation_hold_place = "Submit"
        new_state.subscription_held = true
        @setState(new_state)

  placeHoldOnServer: (callback)->
    jQuery.ajax
      method: "PUT"
      url: "/api/subscriptions/#{@state.subscription_id}/place-hold"
      data:
        hold: @state.vacation_hold

      success: (response, status, jqxhr)->
        callback()

      error: (jqxhr, status, response)->
        alert response.errors

  cancelMembership: ->
    if confirm("Are you sure you want to cancel your membership?")
      new_state = @state
      new_state.submit_values.vacation_hold_place = "Placing hold"
      @setState(new_state)

      @cancelMembershipOnServer =>
        new_state = @state
        new_state.submit_values.vacation_hold_place = "Place Hold"
        new_state.has_active_subscription = false
        @setState(new_state)

  cancelMembershipOnServer: (callback)->
    jQuery.ajax
      method: "DELETE"
      url: "/api/subscriptions/#{@state.subscription_id}"

      success: (response, status, jqxhr)->
        callback()

      error: (jqxhr, status, response)->
        alert response.errors


  renewMembership: ->
    new_state = @state
    new_state.submit_values.renew_membership = "Renewing"
    @setState(new_state)

    @renewOnServer (response)=>
      new_state = @state
      new_state.submit_values.renew_membership = "Renew Membership"
      new_state.subscription_id = response.subscription.id
      new_state.has_active_subscription = true
      @setState(new_state)

  renewOnServer: (callback)->
    jQuery.ajax
      method: "PUT"
      url: "/api/subscriptions/#{@state.subscription_id}/renew"

      success: (response, status, jqxhr)->
        callback(response)

      error: (jqxhr, status, response)=>
        new_state = @state
        new_state.submit_values.renew_membership = "Renew Membership"
        @setState(new_state)

        alert response.errors

  blankCard: ->
    last4: ""
    exp_month: ""
    exp_year: ""
    name: ""
    name: ""
    address_line1: ""
    address_line2: ""
    address_city: ""
    address_state: ""
    address_zip: ""

  render: ->
    R.div null,
      PageTitle(title: "Manage Your Account")
      ProfileForm(info: @state.user_info, submit_value: @state.submit_values.profile, infoChanged: @profileChanged, finished: @profileFinished)
      ChangePasswordForm(info: @state.user_info, submit_value: @state.submit_values.password, infoChanged: @passwordChanged, finished: @passwordFinished)
      ChangeEmailForm(info: @state.user_info, submit_value: @state.submit_values.email, infoChanged: @emailChanged, finished: @emailFinished)
      ChangeBillingForm(info: @state.card_info, submit_value: @state.submit_values.billing, infoChanged: @billingChanged, finished: @billingFinished)
      ChangeDeliveryForm(info: @state.delivery_info, submit_value: @state.submit_values.delivery, infoChanged: @deliveryChanged, finished: @deliveryFinished)
      VacationHoldForm(
        vacation_hold: @state.vacation_hold,
        on_hold: @state.subscription_held,
        place_hold_submit_value: @state.submit_values.vacation_hold_place,
        cancel_hold_submit_value: @state.submit_values.vacation_hold_cancel,
        infoChanged: @vacationHoldChanged,
        cancel: @vacationHoldCanceled,
        finished: @vacationHoldFinished
      ) if @state.has_active_subscription || @state.subscription_held
      CancelMembershipForm(submit_value: @state.submit_values.cancel_membership, finished: @cancelMembership) if @state.has_active_subscription && !@state.subscription_held
      RenewMembershipForm(submit_value: @state.submit_values.renew_membership, finished: @renewMembership) if !@state.has_active_subscription && !@state.subscription_held

window.ManageAccountPage = ManageAccountPage
