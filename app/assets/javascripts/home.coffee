$(document).ready ->
  get_active_slide = ($slider) ->
    return $slider.find(".slide.slick-active")

  show_slide_description = ($slide) ->
    $slide.siblings().find(".description").hide()
    $slide.find(".description").show()

  init_splash_slider = ()->
    $('#splash-slider').slick
      centerMode: true
      slidesToShow: 1
      centerPadding: '0px'
      infinite: true
      dots: true
      autoplay: true
      autospeed: 2000
      speed: 500
      arrows: false
      onInit: ->
        show_slide_description($('#splash-slider .slide'))

      responsive: [
        {
          breakpoint: 1441
          settings:
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



  if $("body#home").length > 0
    React.renderComponent HomePage(), $("body#home main")[0]



  if $("body#home").length > 0
    React.renderComponent HomePage(), $("body#home main")[0]


  $(".back-to-top a").click ->
    console.log 'Test'
    $("body,html").animate
      scrollTop: 0
    , 900
    false

