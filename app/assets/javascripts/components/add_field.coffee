AddField = React.createClass
  render: ->
    R.div
      className: "container",
      R.h1 null, "Add another Gift?"
      R.div
        className: "yes"
        onClick: @props.yes,
        R.a
          href: "#yes-add-another",
          R.span null, "Yes"
          "I'm feeling more generous"
      R.div
        className: "no"
        onClick: @props.no,
        R.a
          href: "#no-im-done-adding-gifts",
          R.span null, "No"
          "Complete my order"

window.AddField = AddField
