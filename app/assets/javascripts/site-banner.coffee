$ ->
  $('.site-banner-list').owlCarousel
    autoplay: false
    autoplayHoverPause: true
    autoplayTimeout: 1000
    center: true
    dots: false
    items: 1
    loop: true
    margin: 0
    startPosition: 0

  .on 'changed.owl.carousel', (event) ->
    correct_index = event.item.index - 2
    $(".site-banner-dot").removeClass('is-active')
    $(".step-#{correct_index}").addClass('is-active')
