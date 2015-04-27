class Users::CreateAdminUser
  attr_reader :user

  def initialize(params)
    @params = params
  end

  def save
    @user = User.new(params_for_create)
  end

  def params_for_create
    @params.merge(password: Devise.friendly_token.first(10))
  end
end
