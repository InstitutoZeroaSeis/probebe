$ ->
  homeMenuActive = (btn) ->
    item =$(btn).attr('href').replace("#", "")
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

  $(window).scroll ->
    # Função para ativar e desativar itens do menu no scroll
    if $(@).scrollTop() >= $('#health').offset().top-85 && $(@).scrollTop() <= $('#health').offset().top+$('#health').height()
      homeMenuActive('.home-categories-item.category-health a')

    else if $(@).scrollTop() >= $('#education').offset().top-85 && $(@).scrollTop() <= $('#education').offset().top+$('#education').height()
      homeMenuActive('.home-categories-item.category-education a')

    else if $(@).scrollTop() >= $('#behavior').offset().top-85 && $(@).scrollTop() <= $('#behavior').offset().top+$('#behavior').height()
      homeMenuActive('.home-categories-item.category-emotional a')

    else if $(@).scrollTop() >= $('#finance').offset().top-85 && $(@).scrollTop() <= $('#finance').offset().top+$('#finance').height()
      homeMenuActive('.home-categories-item.category-finances a')

    else if $(@).scrollTop() >= $('#security').offset().top-85 && $(@).scrollTop() <= $('#security').offset().top+$('#security').height()
      homeMenuActive('.home-categories-item.category-safety a')