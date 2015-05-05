MILLIS_IN_WEEK = 1000 * 60 * 60 * 24 * 7

weeksToDate = (weeks) ->
  date = new Date()
  new Date(date.getTime() - weeks * MILLIS_IN_WEEK)


@setDateFromWeek = (event) ->
  weeks = $(event.target).val()
  date = weeksToDate(weeks)
  formattedDate = $.datepicker.formatDate('dd/mm/yy', date)
  console.log(formattedDate)
  $(event.target).parent().prev().find('.datepicker').val(formattedDate)