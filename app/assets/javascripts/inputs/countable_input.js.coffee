@countChar = (event) ->
  $(event.target).next('span').find('span.char_count').text("(#{$(event.target).val().length})")
