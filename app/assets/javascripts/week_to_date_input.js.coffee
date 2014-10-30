MILLIS_IN_WEEK = 1000 * 60 * 60 * 24 * 7

weeksToDate = (weeks) ->
  date = new Date()
  new Date(date.getTime() - weeks * MILLIS_IN_WEEK)


setDateFromWeek = ->
  weeks = $(@).val()
  date = weeksToDate(weeks)
  console.log(date.toISOString())
  $(@).prev('input:hidden').val(date.toISOString())

@setupDateFromWeek = ->
  $('input.week_to_date').change(setDateFromWeek)
