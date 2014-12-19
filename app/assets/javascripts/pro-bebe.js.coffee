$ ->
addField =  (event) ->
  event.preventDefault()

  new_element = $($(@).data('fields'))
  replaceNameByCurrentTime(new_element)
  parent_container = $(@).closest('.add_fields_container')
  if (parent_container.length > 0)
    $(parent_container).before(new_element)
  else
    $(@).parent().append(new_element)

  fn = window[$(@).data('callback')]
  if Object.prototype.toString.call(fn) == "[object Function]"
    fn(new_element)
  setupDatePickers()

removeField = (event) ->
  event.preventDefault()

  $(@).prev('input[type=hidden]').val("1")
  containerToHide = $(@).data('containerToHide')
  if (containerToHide)
    $(@).closest(containerToHide).hide()
  else
    $(@).parent().hide()

replaceNameByCurrentTime = (jqElement) ->
  time = new Date().getTime()
  form_elements = jqElement.find('input, select, textarea')
  form_elements.each ->
    name = $(@).attr('name')
    pattern = /^(.*)(\[\d+\])(.*)$/g
    new_name = name.replace(pattern, "$1[#{time}]$3")
    $(@).attr('name', new_name)

    id = $(@).attr('id')
    pattern = /^(.*)(\d+)(.*)$/g
    new_id = id.replace(pattern, "$1[#{time}]$3")
    $(@).attr('id', new_id)

setupDatePickers = ->
  $('.datepicker').datepicker(
    changeMonth: true
    changeYear: true
    yearRange: "-80:+1"
    beforeShow: ->
    setTimeout(->
      $('.ui-datepicker').css('z-index', 99)
    , 0)
  , dateFormat: 'dd/mm/yy'
  )

$ ->
  $.datepicker.setDefaults( $.datepicker.regional[ "pt-BR" ] )
  $('body').on 'click', '.add_fields', addField
  $('body').on 'click', '.remove_fields', removeField
  $('#area_code').mask("00")
  $('#cell_phone_number').mask('00000-0000', {reverse: true});
  setupDateFromWeek()
  setupDatePickers()
