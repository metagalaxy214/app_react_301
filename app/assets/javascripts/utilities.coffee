class @Utilities

  # settimeout
  @delay: (ms, func) -> setTimeout func, ms

  # smoothscroll
  @scroll_to: (area, modifier, callback) ->
    modifier = modifier || 0
    go_to_position = $(area).offset().top
    $("html,body").animate
      scrollTop: go_to_position + modifier
    , "slow", callback

  # run any function on window resize
  @run_on_resize: (callback, params)->
    $(window).on "resize", ->
      callback(params)

  # disable select on element
  @disable_selection: ($el) ->
    $el.attr('unselectable', 'on').css('user-select', 'none').on('selectstart', false)

  # init on page load and doc ready - turbolinks fix
  @turbo_init: (init) ->
    $(document).on "ready", init
    $(document).on "page:load", init

  @say_hi: ->
    "hi"