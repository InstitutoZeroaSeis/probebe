module ApplicationHelper
  @@date_helper = Class.new do
    include ActionView::Helpers::DateHelper
  end.new

  def l(value, *args)
    I18n.localize(value, *args) if value
  end

  def template_for_association(form, association, partial)
    new_object =
      form.object.class.reflect_on_association(association).klass.new

    form.simple_fields_for association, new_object do |builder|
      render partial, f: builder
    end
  end

  def remove_fields_link(name, form_builder, container_to_hide: '')
    html_data = { container_to_hide: container_to_hide }
    form_builder.hidden_field(:_destroy, value: false) +
      link_to(name, '#', class: 'remove_fields', data: html_data)
  end

  def distance_of_time_in_words_to_now(time, *args)
    return unless time
    @@date_helper.distance_of_time_in_words_to_now(time, *args)
  end
  alias_method :time_ago_in_words, :distance_of_time_in_words_to_now
end
