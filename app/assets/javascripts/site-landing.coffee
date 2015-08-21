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

  carousel = $('.site-landing-carousel')
  carousel.owlCarousel
    autoplay: true
    autoplayHoverPause: true
    autoplayTimeout: 4000
    center: true
    dots: false
    items: 1
    loop: true
    margin: 0
    startPosition: 0



$(window).scroll ->
  # hide top content when scroll position is top of content
  if $(this).scrollTop() > 100
    if $('.how-works').css('display') != 'none'
      $('.how-works').slideUp 300
  return
