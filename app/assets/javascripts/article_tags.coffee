$ ->
  $('[name*="[tag_names]"]').each ->
    $(@).tagit
      availableTags:$(@).attr('data-tags').split(',')
