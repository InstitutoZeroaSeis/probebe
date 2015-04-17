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

  homeMenuActive = (btn) ->
    item =$(btn).attr('href').replace("#", "")
    $('.home-categories-item a').parent().removeClass('is-active')
    $(btn).parent().addClass('is-active')
    $('.home-categories-list').removeClass('category-health category-education category-emotional category-finances category-safety')
    $('.home-categories-list').addClass('category-'+item)

  $('.home-categories-item a').on 'click', -> 
    event.preventDefault();
    $(window).scrollTo($(@).attr('href'), '800')

  $(window).scroll ->
    # Fixa o menu da home após scroll passar o banner
    if $(@).scrollTop() >= 570
      $('.home-categories').addClass('is-fixed')
    else 
      $('.home-categories').removeClass('is-fixed')

    # Função para ativar e desativar itens do menu no scroll
    if $(@).scrollTop() >= $('#health').offset().top-85 && $(@).scrollTop() <= $('#health').offset().top+$('#health').height()
      homeMenuActive('.home-categories-item.category-health a')      

    else if $(@).scrollTop() >= $('#education').offset().top-85 && $(@).scrollTop() <= $('#education').offset().top+$('#education').height()
      homeMenuActive('.home-categories-item.category-education a')        

    else if $(@).scrollTop() >= $('#emotional').offset().top-85 && $(@).scrollTop() <= $('#emotional').offset().top+$('#emotional').height()
      homeMenuActive('.home-categories-item.category-emotional a')      

    else if $(@).scrollTop() >= $('#finances').offset().top-85 && $(@).scrollTop() <= $('#finances').offset().top+$('#finances').height()
      homeMenuActive('.home-categories-item.category-finances a')      

    else if $(@).scrollTop() >= $('#safety').offset().top-85 && $(@).scrollTop() <= $('#safety').offset().top+$('#safety').height()
      homeMenuActive('.home-categories-item.category-safety a')          