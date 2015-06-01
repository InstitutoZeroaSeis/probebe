#= require nested_forms/element_remover

@NestedForms ||= {}
class @NestedForms.FormRemover
  constructor: (@remove_button_selector, root) ->
    @root = $(root)

  bind: ->
    self = @
    @root.on 'click', @remove_button_selector, (event) ->
      event.preventDefault()
      self.removeElement(@)

  removeElement: (element) ->
    element_remover = new NestedForms.ElementRemover(element)
    element_remover.remove()
