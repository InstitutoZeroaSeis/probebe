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
