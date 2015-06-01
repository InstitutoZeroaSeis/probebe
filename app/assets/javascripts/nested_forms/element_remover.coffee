@NestedForms ||= {}
class @NestedForms.ElementRemover

  constructor: (element) ->
    @element = $(element)

  remove: ->
    @marksAsDestroyable()
    @hideContainer()

  marksAsDestroyable: ->
    @element.prev('input[type=hidden]').val("1")

  hideContainer: ->
    if (@containerToHide())
      @element.closest(@containerToHide()).hide()
    else
      @element.parent().hide()

  containerToHide: ->
    @element.data('containerToHide')
