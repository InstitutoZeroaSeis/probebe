module TimelineHelper
  def definition_list_item(definition_term, description)
    content_tag(:dt) { definition_term } +
      content_tag(:dd) { description }
  end
end
