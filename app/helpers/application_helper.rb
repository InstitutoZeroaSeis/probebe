module ApplicationHelper

  def l(value, *args)
    I18n.localize(value, *args) if value
  end

  def template_for_association(form_builder, association, path='')
    new_object = form_builder.object.class.reflect_on_association(association).klass.new
    fields = form_builder.simple_fields_for association,  new_object  do |builder|
      render(path + association.to_s.singularize + "_fields", :f => builder)
    end
  end

  def add_fields_link(name, form_builder, association, path: "", callback: "")
    fields = template_for_association(form_builder, association, path)
    link_to name, '#', class: 'add_fields',
      data: {fields: fields.gsub("\n", ""), callback: callback}
  end

  def remove_fields_link(name, form_builder, container_to_hide: '', css_class: '')
    form_builder.hidden_field(:_destroy, value: false) +
      link_to(name, '#', class: 'remove_fields ' + css_class, data: { container_to_hide: container_to_hide })
  end

end
