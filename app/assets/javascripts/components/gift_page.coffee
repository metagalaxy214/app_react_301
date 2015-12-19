GiftPage = React.createClass
  getInitialState: ->
    {
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
      orders: [
        {
          id: 1
          meal: @props.meals[0]
          first_name: ""
          last_name: ""
          address_1: ""
          address_2: ""
          city: ""
          state: ""
          zip_code: ""
          phone: ""
          email: ""
          gift_message: ""
        }
      ]
      active_order: 1
    }

  handleOpen: (area, callback)->
    $(area).slideDown 500, =>
      new_state = @state
      @setState(callback(new_state))

    Utilities.delay 250, ->
      Utilities.scroll_to area

  activeOrder: ->
    active = null
    $.grep @state.orders, (order)=>
      active = order if order.id == @state.active_order
    active

  giftChanged: (meal)->
    state = @state
    index = @state.orders.indexOf(@activeOrder())
    state.orders[index].meal = meal

    @setState(state)

  showGiftTo: ->
    @handleOpen "#gift-to", (new_state)->
      new_state.show_gift_to = true
      new_state

  showCheckout: (e)->
    e.preventDefault()

    @handleOpen "#checkout", (new_state)->
      new_state.show_checkout = true
      new_state

  showAddAnother: ->
    @handleOpen "#add-another-gift", (new_state)->
      new_state.show_add_another = true
      new_state

  showConfirm: ->
    @handleOpen "#confirm", (new_state)->
      new_state.show_confirm = true
      new_state

  orderChanged: (field, value)->
    state = @state
    index = @state.orders.indexOf(@activeOrder())
    state.orders[index][field] = value

    @setState(state)

  checkoutChanged: (field, value)->
    state = @state
    state.checkout_info[field] = value
    @setState(state)

  getNextOrderID: ->
    ids = (order.id for order in @state.orders)
    max = Math.max.apply(null, ids)
    max + 1

  addAnother: ->
    currentMeal = @activeOrder().meal
    order =
      id: @getNextOrderID()
      first_name: ""
      last_name: ""
      address_1: ""
      address_2: ""
      city: ""
      state: ""
      zip_code: ""
      phone: ""
      email: ""
      gift_message: ""
      meal:
        name: currentMeal.name
        value: currentMeal.value
        title: currentMeal.title
        description: currentMeal.description
        duration: currentMeal.duration
        weeks: currentMeal.weeks
        price: currentMeal.price

    state = @state
    state.orders.push(order)
    state.show_confirm = true
    state.active_order = order.id
    @setState(state)

    Utilities.scroll_to "#gift-to"

  removeOrder: (order)->
    state = @state

    # Don't ever have fewer than 1 orders
    if state.orders.length == 1
      # Blank out current
      new_orders = @getInitialState().orders
    else
      # Create order array that stays
      new_orders = state.orders.filter (o)=> o.id != @activeOrder().id

    if order.id == @activeOrder().id # We need to change the active order
      state.active_order = new_orders[0].id

    # Set the new orders
    state.orders = new_orders

    @setState(state)

  editOrder: (order)->
    state = @state
    state.active_order = order.id
    @setState(state)

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

  completeOrder: ->
    console.log "Post to server and show ThankYouBox"

    jQuery.ajax
      url: "/api/gifts"
      method: "POST"
      data:
        card: @state.checkout_info
        subscriptions: ({
          recipient_first_name:   order.first_name
          recipient_last_name:    order.last_name
          recipient_email:        order.email
          recipient_phone:        order.phone
          recipient_message:      order.gift_message
          shipping_address_line1: order.address_1
          shipping_address_line2: order.address_2
          shipping_city:          order.city
          shipping_state:         order.state
          shipping_zipcode:       order.zip_code
          gift_id:                order.meal.id
        }) for order in @state.orders

      success: (response, status, jqxhr)=>
        @handleOpen "#thank-you", (new_state)->
          new_state.show_thank_you = true
          new_state

      failure: (jqxhr, status, response)=>
        alert @generateErrorMessage(jqxhr.responseJSON.errors)

  render: ->
    R.div null,
      PageTitle({ title: "Give the Gift of Great Taste" })
      R.section
        id: "how-it-works",
        MealExplanation({ weeks: m.weeks for m in @props.meals })
      R.section
        id: "choose-gift",
        GiftChooser({
          plans: @props.meals
          changed: @giftChanged
          currentMeal: @activeOrder().meal.value
          finished: @showGiftTo
        })
      R.section
        id: "gift-to"
        className: "#{"hidden" unless @state.show_gift_to}",
        DeliveryForm({
          order: @activeOrder(),
          orderChanged: @orderChanged,
          finished: @showCheckout,
        })
      R.section
        id: "checkout"
        className: "#{"hidden" unless @state.show_checkout}",
        CheckoutForm({ info: @state.checkout_info, checkoutChanged: @checkoutChanged, checkoutDone: @showAddAnother })
      R.section
        id: "add-another-gift"
        className: "#{"hidden" unless @state.show_add_another}",
        AddField(yes: @addAnother, no: @showConfirm)
      R.section
        id: "confirm"
        className: "#{"hidden" unless @state.show_confirm}",
        ConfirmationBox({ orders: @state.orders, edit: @editOrder, remove: @removeOrder, finished: @completeOrder })
      R.section
        id: "thank-you"
        className: "#{"hidden" unless @state.show_thank_you}",
        ThankYouBox({ referral_code: @props.referral_code })

window.GiftPage = GiftPage
