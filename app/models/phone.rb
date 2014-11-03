class Phone < ActiveRecord::Base
  belongs_to :profile

  PHONE_TYPE_ENUM = [:smartphone, :dumbphone, :residential]

  enum phone_type: PHONE_TYPE_ENUM

  validates_presence_of :number, :phone_type, :area_code

end
