class FacebookSignin

  constructor: (button)->
    jQuery(button).on "click", (e)=>
      e.preventDefault()

      @checkLoginStatus()

  checkLoginStatus: ->
    FB.getLoginStatus (response)=>
      if response.status is "connected"
        @redirectToAccount()
      else
        @loginViaFacebook()

  loginViaFacebook: ->
    FB.login (response) =>
      if response.status is "connected"
        @redirectToAccount()
      else if response.status is "not_authorized"
        alert "Unable to register through Facebook."

  redirectToAccount: ()->
    auth = FB.getAuthResponse()
    token = auth.accessToken
    uid = auth.userID

    jQuery.ajax
      method: "POST"
      url: "/account/facebook-signin"
      data:
        uid: uid
        access_token: token

      success: (response, statux, xhr)->
        window.location = "/account"

      failure: (xhr, status, response)->
        alert "Unable to login with Facebook"

jQuery ($)->

  $fb_button = $("#facebook-login a")

  if $fb_button.length > 0
    fbs = new FacebookSignin($fb_button)
