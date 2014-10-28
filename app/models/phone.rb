class Phone < ActiveRecord::Base
  belongs_to :contact_profile

  PHONE_TYPE_ENUM = [:smartphone, :dumpphone, :residential] 
  
  enum phone_type: PHONE_TYPE_ENUM

  validates_presence_of :number, :phone_type, :area_code

end
