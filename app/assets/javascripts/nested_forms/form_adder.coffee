#= require nested_forms/attribute_identifiers_replacer
#= require nested_forms/form_utils

@NestedForms ||= {}
class @NestedForms.FormAdder
  constructor: (@selector, element) ->
    @element = $(element)
    @utils = new NestedForms.FormUtils()

  bind: ->
    self = @
    @element.on 'click', @selector, (event) ->
      event.preventDefault()
      self.addNewElement(@)

  addNewElement: (button) ->
    new_element = $($(button).data('fields'))

    new NestedForms.AttributeIdentifiersReplacer(new_element)
      .replaceAttributeNames()

    childrenForm = $(button).parent().parent().find('.children-form')
    childrenForm.append(new_element)
    setupDatePickers()
    @utils.replaceChildrenFormIndexes()
