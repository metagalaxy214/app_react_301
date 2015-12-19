PageTitle = React.createClass
  render: ->
    R.section
      id: "page-title",
      R.div
        className: "container",
        R.div
          className: "title",
          R.h1 null, @props.title

window.PageTitle = PageTitle
