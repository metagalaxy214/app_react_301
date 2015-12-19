OrderSummary = React.createClass
  editOrder: ->
    @props.edit(@props.order)

  deleteOrder: ->
    @props.remove(@props.order)

  address: ->
    [
      "#{@props.order.first_name} #{@props.order.last_name}"
      @props.order.address_1
      @props.order.address_2
      "#{@props.order.city}, #{@props.order.state} #{@props.order.zip_code}"
    ].join("\n")

  validAddress: ->
    o = @props.order

    o.first_name && o.last_name && o.address_1 && o.city && o.state && o.zip_code

  render: ->
    R.div
      className: "subscription",
      R.div
        className: "description"
        children: this.props.order.meal.description
      R.div
        className: "user"
        children: if @validAddress() then @address() else "Address"
      if @props.edit
        R.a
          className: "edit-order"
          children: "Edit My Order >"
          href: "#edit-my-order"
          onClick: @editOrder
      if @props.remove
        R.a
          className: "delete-order"
          children: "Delete My Order >"
          href: "#delete-my-order"
          onClick: @deleteOrder

window.OrderSummary = OrderSummary
