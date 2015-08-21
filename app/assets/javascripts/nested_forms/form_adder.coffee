#= require nested_forms/attribute_identifiers_replacer

@NestedForms ||= {}
class @NestedForms.FormAdder
  constructor: (@selector, element) ->
    @element = $(element)

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
