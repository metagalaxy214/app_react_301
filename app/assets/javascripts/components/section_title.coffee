SectionTitle = React.createClass
  render: ->
    R.h2
      className: "section-title"
      children: @props.text

window.SectionTitle = SectionTitle
