$ ->
  $('#partner-about-partner').on 'click', (event) ->
    event.preventDefault()
    $('html, body').animate
      scrollTop: $('.partner-section').offset().top
    , 800

  $('#partner-how-works').on 'click', (event) ->
    event.preventDefault()
    $('html, body').animate
      scrollTop: $('.how-works-partner').offset().top
    , 800

  $('#partner-what').on 'click', (event) ->
    event.preventDefault()
    $('html, body').animate
      scrollTop: $('.what-title').offset().top
    , 800

  $('.sign-up-partner').on 'click', (event) ->
    event.preventDefault()
    window.location.href = '/#sign-up'

