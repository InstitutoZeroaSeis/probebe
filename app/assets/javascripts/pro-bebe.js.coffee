$ ->
  window.replaceNameByCurrentTime = (jqElement) ->
    time = new Date().getTime()
    form_elements = jqElement.find('input, select, textarea')
    form_elements.each ->
      name = $(@).attr('name')
      pattern = /^(.*)(\[\d+\])(.*)$/g
      new_name = name.replace(pattern, "$1[#{time}]$3")
      $(@).attr('name', new_name)

  $('body').on 'click', '.add_fields', (event) ->
    event.preventDefault()

    new_element = $($(@).data('fields'))
    replaceNameByCurrentTime(new_element)
    $(@).before(new_element)

    fn = window[$(@).data('callback')]
    if Object.prototype.toString.call(fn) == "[object Function]"
      fn(new_element)

  $('body').on 'click', '.remove_fields', (event) ->
    event.preventDefault()

    $(@).prev('input[type=hidden]').val("1")
    containerToHide = $(@).data('containerToHide')
    if (containerToHide)
      $(@).closest(containerToHide).hide()
    else
      $(@).parent().hide()