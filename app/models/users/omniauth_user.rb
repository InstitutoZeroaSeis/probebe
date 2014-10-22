module Users
  class OmniauthUser
    include ActiveModel::Validations

    validates_presence_of :email, :first_name, :last_name

    attr_accessor :user, :email, :first_name, :last_name

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
      create_user and create_profile
    end

    def create_user
      @user = User.find_by(email: email) || User.create(email: email)
      @user.valid?
    end

    def create_profile
      build_profile_creator
      @profile_creator.save
    end

    def build_profile_creator
      @profile_creator = Profiles::ProfileCreator.new(profile_attributes)
    end

    def profile_attributes
      { user: @user, first_name: @first_name, last_name: @last_name }
    end

  end
end
