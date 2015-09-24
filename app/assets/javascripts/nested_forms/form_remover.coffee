#= require nested_forms/element_remover
#= require nested_forms/form_utils

@NestedForms ||= {}
class @NestedForms.FormRemover
  constructor: (@remove_button_selector, root) ->
    @root = $(root)
    @utils = new NestedForms.FormUtils()

  bind: ->
    self = @
    @root.on 'click', @remove_button_selector, (event) ->
      event.preventDefault()
      self.removeElement(@)

  removeElement: (element) ->
    element_remover = new NestedForms.ElementRemover(element)
    element_remover.remove()
    @utils.replaceChildrenFormIndexes()

