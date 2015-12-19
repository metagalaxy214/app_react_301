JoinUs = React.createClass
  render: ->
    R.section
      id: "join-us"
      R.div
        className: "container",
        R.div
          className: "join-link"
          R.a
            href: "#join-link",
            R.span null, "Sign Up"

window.JoinUs = JoinUs
