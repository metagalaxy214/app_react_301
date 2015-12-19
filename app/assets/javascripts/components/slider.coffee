Slider = React.createClass
  render: ->
    R.section
      id: "splash",
      R.div
        id: "splash-slider",
        SlideItem(data) for data in @props.slides

window.Slider = Slider
