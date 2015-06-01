#= require nested_forms/form_remover
#= require nested_forms/form_adder

@setupDatePickers = ->
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
  setupDatePickers()

  new NestedForms.FormRemover('.remove_fields', document).bind()
  new NestedForms.FormAdder('.add_fields', document).bind()
