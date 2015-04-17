class ProfilePresenter < SimpleDelegator
  def class
    __getobj__.class
  end

  def options_to_gender_enum
    [
      ['male', I18n.t('general.gender.male')],
      ['female', I18n.t('general.gender.female')]
    ]
  end

  def phones_text
    I18n.t 'views.profile.phones'
  end

  def contact_information_text
    I18n.t 'views.profile.contact_informations'
  end

  def personal_information_text
    I18n.t 'views.profile.personal_information'
  end

  def children_text
    I18n.t 'views.profile.children'
  end
end
