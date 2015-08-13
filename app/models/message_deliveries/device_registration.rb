module MessageDeliveries
  class DeviceRegistration < ActiveRecord::Base
    belongs_to :profile
    validates_presence_of :platform, :platform_code

    validates_uniqueness_of :platform_code, scope: :platform

    after_create :set_profile_as_possible_donor

    protected

    def set_profile_as_possible_donor
      self.profile.possible_donor! if self.profile.recipient?
    end
  end
end
