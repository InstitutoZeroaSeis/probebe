class String
  def pluralize_current_locale(count = nil)
    self.pluralize(count, I18n.locale)
  end
end
