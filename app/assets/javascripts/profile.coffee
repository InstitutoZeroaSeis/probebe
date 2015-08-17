$(document).ready ->

  phoneMask = (phone) ->
    has_ninth_digit = false
    if phone
      has_ninth_digit = phone.replace(/[^\d]/g, '').length >= 11
    if has_ninth_digit
      $(".phone").mask '00 00000-0000'
    else
      $(".phone").mask '00 0000-00009'

  phoneMask($('.phone').val())

  $('.phone').focusout (event) ->
    phoneMask($(@).val())

  $('body').on 'change', '.born_child', (event) ->
    form = $(@).parents('fieldset.form-block')

    if @checked
      showBirthDate(form)
    else
      showWeeksToBorn(form)

  showBirthDate = (form) ->
    form.find('.week_to_date_number').hide()
    form.find('.date_picker').show()

  showWeeksToBorn = (form) ->
    form.find('.week_to_date_number').show()
    form.find('.date_picker').hide()

  $('.born_child').trigger 'change'

  $('.add_fields').click ->
    setTimeout (->
      $('.born_child').trigger 'change'
    ), 400

  $('.born-or-not-born').click ->
    setTimeout (->
      $('.born_child:last').prop('checked', true)
    ), 300
