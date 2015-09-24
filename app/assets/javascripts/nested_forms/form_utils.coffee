@NestedForms ||= {}
class @NestedForms.FormUtils
  constructor: () ->

  replaceChildrenFormIndexes: ->
    childrenIndex = 1
    $('.profile-form-child').each( ->
      if($(@).is(':visible'))
        legend = $(@).find('legend')
        newText = $(legend).text().trim().replace(/^[0-9]*/, childrenIndex)
        $(legend).text(newText)
        childrenIndex += 1
    )

