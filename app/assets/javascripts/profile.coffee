$ ->
  phoneMask = (phone) ->
    has_ninth_digit = phone.replace(/[^\d]/g, '').length > 10
    if has_ninth_digit
      '00 00000-0000'
    else
      '00 0000-0000'

  $(".phone").mask phoneMask,
    onKeyPress: (phone, e, currentField, options) ->
      $(currentField).mask(phoneMask(phone), options)

  $('body').on 'change', '.born_child', (event) ->
    form = $(@).parents('.form-block')
    clearWeeksToDateFields(form)

    if @checked
      showBirthDate(form)
    else
      showWeeksToBorn(form)

  clearWeeksToDateFields = (form) ->
    form.find('.week_to_date_number input').val("")
    form.find('.date_picker input').val("")

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
    ), 300