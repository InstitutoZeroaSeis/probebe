$(document).ready ->
  # scroll to top and show top content
  $('#how-works-button').on 'click', ->
    $('html, body').stop().animate { scrollTop: 0 }, 300, ->
      $('.how-works').slideDown 300
      return
    return
  # hide top content on click close icon
  $('#close-how-works').on 'click', ->
    $('.how-works').slideUp 300
    return
  return
$(window).scroll ->
  # hide top content when scroll position is top of content
  if $(this).scrollTop() > 100
    if $('.how-works').css('display') != 'none'
      $('.how-works').slideUp 300
  return
