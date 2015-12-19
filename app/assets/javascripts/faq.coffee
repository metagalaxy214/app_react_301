$(document).ready ->
  $('#faq-accordion').find('.accordion-toggle').click ->
    $(this).next() .slideToggle('fast')
    $('.accordion-content').not(($this).next()).slideUp('fast')
