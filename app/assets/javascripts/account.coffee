window.R = React.DOM

jQuery ($)->

  if $("body#manage-account").length > 0
    React.renderComponent ManageAccountPage(), $("main")[0]
