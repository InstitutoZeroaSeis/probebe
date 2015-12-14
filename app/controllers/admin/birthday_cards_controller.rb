class Admin::BirthdayCardsController < Admin::AdminController
  layout 'carnival/admin'
  defaults resource_class: BirthdayCard

  def permitted_params
    params.permit(birthday_card: [:avatar, :age, :text, :type])
  end
end
