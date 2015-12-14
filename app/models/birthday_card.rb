class BirthdayCard < ActiveRecord::Base
  include Carnival::ModelHelper
  TYPE_ENUM = [ :week, :month ]

  self.inheritance_column = nil #to use colunm with name type
  enum type: TYPE_ENUM

  validates :text, :age, :type, presence: true
  validates :age, numericality: true


  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
