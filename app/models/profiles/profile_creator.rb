class Profiles::ProfileCreator
  include ActiveModel::Validations

  validates_presence_of :first_name, :last_name, :user
  validate :valid_user?
  attr_accessor :first_name, :last_name, :user, :profile, :personal_profile

  def initialize(params)
    params.each do |attr, value|
      self.try("#{attr}=", value)
    end
  end

  def save
    if valid?
      save!
    else
      false
    end
  end

  protected

  def save!
    create_profile and create_personal_profile
  end

  def create_profile
    @profile = @user.profile || @user.create_profile
    @profile.valid?
  end

  def create_personal_profile
    @personal_profile = @profile.personal_profile ||
      @profile.create_personal_profile(personal_profile_attributes)
    @personal_profile.valid?
  end

  def personal_profile_attributes
    { first_name: @first_name, last_name: @last_name }
  end

  def valid_user?
    user and user.valid?
  end

end
