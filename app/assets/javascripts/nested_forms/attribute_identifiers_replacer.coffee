@NestedForms ||= {}
class @NestedForms.AttributeIdentifiersReplacer
  constructor: (element) ->
    @element = $(element)

  replaceAttributeNames: ->
    self = @
    @needsReplacementElements().each -> self.replaceNames(@)

  needsReplacementElements: ->
    @element.find('input, select, textarea')

  replaceNames: (element) ->
    time = new Date().getTime()
    name = $(element).attr('name')
    pattern = /^(.*)(\[\d+\])(.*)$/g
    new_name = name.replace(pattern, "$1[#{time}]$3")
    $(element).attr('name', new_name)
