class @ZipCodeLocator
  constructor: (zipcode)->
    @resource_url = "/availability/#{zipcode}.json"
    @response = {}
    @error = {}

  check_availability: ()->
    console.log("inside check_availability")
    jQuery.ajax
      url: @resource_url
      method: "GET"
      success: (response, status, xhr)=>
        alert "#{status}"
      error: (response, status, xhr) =>
        alert "#{status}"
