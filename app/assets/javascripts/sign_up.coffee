class SignUpFormWithError
  constructor: (form, errors) ->
    @form = $(form)
    @errors = transform_errors_object errors

  clean_existing_errors: ->
    @form.find('.has-error').removeClass 'has-error'
    @form.find('.help-block').remove()

  add_errors: ->
    @clean_existing_errors()
    @add_error(error, @errors[error]) for error of @errors

  add_error: (property, description) ->
    @form.find("div.#{property}").addClass 'has-error'
    @form.find("input.#{property}").after help_block(description)

  help_block = (text) ->
    $('<span/>').addClass('help-block').text(text)

  transform_errors_object = (object) ->
    new_object = $.extend {},
      name: object['profile.name']
      cell_phone: object['profile.cell_phone']
      email: object.email
      password: object.password

class SignUp
  constructor: (element) ->
    @element = $(element)

  bind: ->
    @element.bind 'ajax:success', => @sign_up_success()
    @element.bind 'ajax:error', (event, data) =>
      @sign_up_fail(event.target, data.responseJSON.errors)

  sign_up_success: ->
    location.href = '/profile/edit'

  sign_up_fail: (form, errors) ->
    new SignUpFormWithError(form, errors).add_errors()


$ ->
  sign_up = new SignUp('.sign-up-form')
  sign_up.bind()

  phoneMask = (phone) ->
    has_ninth_digit = phone.replace(/[^\d]/g, '').length > 10
    if has_ninth_digit
      '00 00000-0000'
    else
      '00 0000-0000'

  $(".phone").mask phoneMask,
    onKeyPress: (phone, e, currentField, options) ->
      $(currentField).mask(phoneMask(phone), options)

