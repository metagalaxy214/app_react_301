OrderOption = React.createClass
  getInitialState: ->
    @meal = @props.meal

  mealSelected: ->
    @props.onSelect(@props.meal)

  render: ->
    input_data =
      className: "gift-input"
      type: "radio"
      name: "gift"
      value: @meal.value
      readOnly: true
      id: @meal.value

    input_data['checked'] = 'checked' if @props.isCurrent

    R.div
      className: "gift"
      onClick: @mealSelected,
      R.input input_data
      R.label
        htmlFor: @meal.value,
        R.div
          className: "gift-name"
          children: @meal.name
        R.div
          className: "gift-image",
          R.img
            src: @meal.image
        R.div
          className: "gift-price"
          children: "$" + (@meal.price / 100.0).toFixed(2)
        R.div className: "gift-description",
          R.p null,
            R.strong
              children: @meal.title
          R.p null,
            children: @meal.description

window.OrderOption = OrderOption
