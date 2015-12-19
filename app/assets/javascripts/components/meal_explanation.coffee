MealExplanation = React.createClass
  weekOptions: ->
    last = @props.weeks[@props.weeks.length - 1]
    rest = @props.weeks[0..@props.weeks.length - 2]

    "#{rest.join(", ")} or #{last}"

  render: ->
    R.div
      className: "container",
      R.h3
        className: "title"
        children: "How It Works"
      R.p
        children: "Deliver the gift of great taste right to someone's doorstep each Monday morning."
      R.p
        children: "Choose among #{@weekOptions()} week options."
      R.img
        className: "splash-image"
        src: "/assets/img.gift-how-it-works.png"

window.MealExplanation = MealExplanation
