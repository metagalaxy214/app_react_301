$(document).ready ->

  # state select dropdown
  init_state_selects = () ->
    $(".field.state select, .field.billing_state select").chosen
      no_results_text: "Invalid State"
      placeholder_text_single: "State"

  Utilities.turbo_init(init_state_selects)

  # disable selection on checkboxes
  Utilities.disable_selection($("label.checkbox"))

  # home delivery slider
  get_active_slide = ($slider) ->
    return $slider.find(".slide.slick-active")

  show_slide_description = ($slide) ->
    $slide.siblings().find(".description").hide()
    $slide.find(".description").show()

  init_splash_slider = ()->
    $('#splash-slider').slick
      centerMode: true
      slidesToShow: 3
      centerPadding: '0px'
      infinite: true
      dots: false
      arrows: false
      onInit: ->
        show_slide_description($('#splash-slider .slide'))

      responsive: [
        {
          breakpoint: 1441
          settings:
            slidesToShow: 1
            centerPadding: '25%'
            dots: true
            onInit: ->
              show_slide_description(get_active_slide($('#splash-slider')))
            onReInit: ->
              show_slide_description(get_active_slide($('#splash-slider')))
            onAfterChange: ->
              show_slide_description(get_active_slide($('#splash-slider')))
        },
        {
          breakpoint: 1024
          settings:
            slidesToShow: 1
            centerPadding: '18%'
            dots: true
        },
        {
          breakpoint: 767
          settings:
            slidesToShow: 1
            centerPadding: '0'
            dots: true
        }
      ]

  Utilities.turbo_init(init_splash_slider)

  if $("body#home_delivery").length > 0
    React.renderComponent HomeDeliveryPage({
      slide_items: window.slide_items
    }), $("body#home_delivery main")[0]

  # sharing form
  if $("#thank-you").length
    $("#thank-you").on "click", ".social .email-button", (e) ->
      e.preventDefault()
      $(this).closest(".social").find("form").slideDown(100)
      Utilities.scroll_to($("#thank-you"))
