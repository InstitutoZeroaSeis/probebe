MILLIS_IN_WEEK = 1000 * 60 * 60 * 24 * 7

weeksToDate = (weeks) ->
  date = new Date()
  new Date(date.getTime() - weeks * MILLIS_IN_WEEK)


@setDateFromWeek = (event) ->
  weeks = $(event.target).val()
  date = weeksToDate(weeks)
  console.log(date.toISOString())
  $(event.target).parent().prev().find('.datepicker').val(date.toISOString())