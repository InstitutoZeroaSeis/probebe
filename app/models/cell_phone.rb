class CellPhone < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :profile
  validates_presence_of :number, :area_code
  validates_format_of :number, with: /\A\d{4,5}\-\d{4,4}\Z/
  validates_format_of :area_code, with: /\A\d\d\Z/

  def full_number
    area_code + clean_number
  end

  def clean_number
    number.delete("^0-9")
  end

end
