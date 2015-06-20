$ ->
  homeMenuActive = (btn) ->
    item =$(btn).attr('href').replace("", "")
    $('.home-categories-item a').parent().removeClass('is-active')
    $(btn).parent().addClass('is-active')
    $('.home-categories-list').removeClass('category-health category-education category-behavior category-finance category-security')
    $('.home-categories-list').addClass('category-'+item)

  $('.home-categories-item.home-categories-click a').on 'click', ->
    event.preventDefault()
    $(window).scrollTo($(@).attr('href'), '800')

  $('.sign-up').on 'click', (event) ->
    event.preventDefault()
    $('html').animate
      scrollTop: $('.footer-sign-up').offset().top
    , 800

  $('.home-categories').scrollToFixed
    marginTop: 10
    limit: $('footer').offset().top - 450
    zIndex: 9


  isUserSeeingThisCategory = (categoryId) =>
    scrollTop = $(@).scrollTop()
    if scrollTop >= $("##{categoryId}").offset().top-85 && scrollTop <= $("##{categoryId}").offset().top+$("##{categoryId}").height()
      selector = ".home-categories-item.category-#{categoryId} a"
      homeMenuActive(selector)

  subjectButtonHoverIn = () ->
    $(@).css('background-color', $(@).data('color2'))
    $(@).css('border', "1px solid " + $(@).data('color1'))
    $(@).css('color', $(@).data('color1'))
  subjectButtonHoverOut = () ->
    $(@).css('background-color', $(@).data('color1'))
    $(@).css('border', "1px solid rgba(0, 0, 0, 0.1)")
    $(@).css('color', $(@).data('color2'))
  $('.subject-description-buttons-read').hover(subjectButtonHoverIn, subjectButtonHoverOut)
  $('.subject-description-buttons-sign-in').hover(subjectButtonHoverIn, subjectButtonHoverOut)

  $(window).scroll ->
    # Função para ativar e desativar itens do menu no scroll
    categories = [ 'health', 'education', 'behavior'
                   'security', 'finance' ]
    for category in categories
      isUserSeeingThisCategory(category)

