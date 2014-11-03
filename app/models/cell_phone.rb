class CellPhone < ActiveRecord::Base
  belongs_to :profile
  validates_presence_of :number
end
