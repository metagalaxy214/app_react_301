GiftChooser = React.createClass
  componentDidMount: ->
    $(".gift-image").imgLiquid
      verticalAlign: "center"
      horizontalAlign: "center"
      fill: true

  submit: (e)->
    e.preventDefault()

    @props.finished()

  render: ->
    R.div
      className: "container",
      R.h3
        className: "title",
        "Choose A Gift"
      R.form
        id: "gift-selector"
        onSubmit: @submit,
        R.div
          className: "gift-container",
          OrderOption(meal: meal, onSelect: @props.changed, isCurrent: (meal.value == @props.currentMeal)) for meal in @props.plans
          R.div
            className: "field submit"
            R.input
              type: "submit"
              value: "Next"
              readOnly: true

window.GiftChooser = GiftChooser
