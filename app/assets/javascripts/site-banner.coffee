$ ->
  if $('.site-banner-list li').length <= 1
    return
  carousel = $('.site-banner-list')
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

  .on 'changed.owl.carousel', (event) ->
    current = carousel.data('owlCarousel').current() - 2
    $(".site-banner-dot").removeClass('is-active')
    $(".step-#{current}").addClass('is-active')

  if $('.blog-tags ul').outerHeight() > 160
    $('.blog-tags').addClass('collapsed')

  $('.more').on 'click', (event) ->
    event.preventDefault()
    $('.blog-tags').removeClass('collapsed')

  $('.site-banner-dot').click ->
    carousel_position = carousel.data('owlCarousel').current() - 2
    index_difference = Math.abs(carousel_position - $(@).index())
    fn_name = if carousel_position > $(@).index() then 'prev' else 'next'

    i = 0
    while i < index_difference
      setTimeout ->
        carousel.data('owlCarousel')[fn_name]()
      , 50 * i
      i++
