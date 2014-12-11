class CellPhone < ActiveRecord::Base
  belongs_to :profile
  validates_presence_of :number, :area_code
  validates_format_of :number, with: /\d{4,5}\-\d{4,4}/
  validates_format_of :area_code, with: /\d\d/

end
