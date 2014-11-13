class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :messageable, polymorphic: true
  has_many :message_deliveries

  validates_presence_of :text

end
