$(document).ready ->

  # fonts tracking
  MTIProjectId = "a0be750d-361b-44dc-be2f-7424b385c642"
  (->
    mtiTracking = document.createElement("script")
    mtiTracking.type = "text/javascript"
    mtiTracking.async = "true"
    mtiTracking.src = ((if "https:" is document.location.protocol then "https:" else "http:")) + "//fast.fonts.net/t/trackingCode.js"
    (document.getElementsByTagName("head")[0] or document.getElementsByTagName("body")[0]).appendChild mtiTracking
    return
  )()
