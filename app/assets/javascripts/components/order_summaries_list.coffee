OrderSummariesList = React.createClass
  render: ->
    R.div
      className: "order-summary",
        OrderSummary({ order: order, edit: @props.edit, remove: @props.remove }) for order in this.props.orders

window.OrderSummariesList = OrderSummariesList
