ConfirmationBox = React.createClass
  total: ->
    total = 0.0
    total += o.meal.price for o in @props.orders

    (total / 100.0).toFixed(2)

  render: ->
    R.div
      className: "container",
        OrderSummariesList({ orders: @props.orders, edit: @props.edit, remove: @props.remove })
        R.div
          className: "complete-order",
          R.div
            className: "total"
            children: "Total: $#{this.total()}"
          R.a
            onClick: @props.finished
            className: "complete-order-link"
            children: "Complete Order"
            href: "#complete-order"

window.ConfirmationBox = ConfirmationBox
