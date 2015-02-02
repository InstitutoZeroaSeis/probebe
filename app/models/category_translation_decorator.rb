class CategoryTranslationDecorator < Category
  def parent_category
    if super
      I18n.t("simple_form.options.category.parent_category.#{super.downcase}")
    end
  end
end
