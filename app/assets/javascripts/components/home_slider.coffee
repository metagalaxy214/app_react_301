HomeSlider = React.createClass
  getInitialState: -> 
    unavailableDialogisOpen: false
    unallowedDialogisOpen: false

  getServerResponse: (url, callback) ->
    availability = {}
    jQuery.ajax
      url: url 
      method: "GET"
      success: (response, status, xhr)=>
        availability = response
        callback(availability)
      error: (response, status, xhr) =>
        alert "#{status}"

  handleZipCode: (event) ->
    event.preventDefault()
    zip = this.refs.zipInput.getDOMNode().value
    resource_url = "/availability/#{zip}.json"
    @getServerResponse resource_url, (availability) ->
      if availability.available == "false"
        window.location = "http://testing.tablerunner.com:9000/static_pages/unavailable"
      else if availability.available == "true" and availability.allowed == "false"
        window.location = "http://testing.tablerunner.com:9000/static_pages/booked"
      else 
        window.location = "http://testing.tablerunner.com:9000/subscribe/home-delivery"
        #sign up 
  handleCloseUnavailableDialog: ->
    new_state = @state
    new_state.unavailableDialogisOpen = false
    @setState(new_state)
  handleCloseUnallowedDialog: ->
    new_state = @state
    new_state.unallowedDialogisOpen = false
    @setState(new_state)

  openUnavailable: ->
    console.log "inside open unavailable" 
    new_state = @state
    new_state.dialogIsOpen = true
    @setState(new_state)
    console.log @state

  openUnallowed: ->
    console.log "inside open unallowed" 
    new_state = @state
    new_state.dialogIsOpen = true
    @setState(new_state)


  render: ->
    R.section
      id: "splash",
      R.div
        className: "slider-box"
        R.h3 null, "OUR KITCHEN."
        R.h3 
          className: "italics" 
          " YOUR "
        R.h3 null, "PERSONAL CHEF"
        R.p null, "Chef-crafted meals with seasonally inspired ingredients deliverd* fresh to you" 
        R.form
          onSubmit: @handleZipCode
          id: "zip-locator-form"
          R.input
            ref: "zipInput"
            className: "slider-input"
            type: "text"
            placeholder: "enter your zip code"
            pattern: ".{5,5}"
            title: "Invalid Zip Code"
            maxlength: "5"
            required: true
          R.input
            className: "slider-submit"
            type:"submit"
            value:"SIGN UP"
        HandleUnavailable({
            open: @state.unavailableDialogIsOpen
            onClose: @handleCloseUnavailableDialog
          }, PairingBox({
          }))
        HandleUnallowed({
            open: @state.unallowedDialogIsOpen
            onClose: @handleCloseUnallowedDialog
          }, PairingBox({
          }))



      R.div
        id: "splash-slider",
        R.div
          className: "slide",
          R.div
            className: "wrap",
            R.img
              alt: "Img.slide #{@props.slide_number}"
              src: "/assets/wk1_BeefMeal_1440x700.jpg"
        R.div
          className: "slide",
          R.div
            className: "wrap",
            R.img
              alt: "Img.slide #{@props.slide_number}"
              src: "/assets/Fall_Beets_1440x700.jpg"
        R.div
          className: "slide",
          R.div
            className: "wrap",
            R.img
              alt: "Img.slide #{@props.slide_number}"
              src: "/assets/greenchef_1440x700.jpg"

window.HomeSlider = HomeSlider
