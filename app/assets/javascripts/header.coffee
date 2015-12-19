$(document).ready ->

  # close login box
  initialize_login_close = ->
    $("section#login").on "click", ".close", () ->
      $(this).closest("#login").fadeOut(100)
  Utilities.turbo_init(initialize_login_close)