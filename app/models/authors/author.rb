class Authors::Author < ActiveRecord::Base
  include Carnival::ModelHelper

  has_attached_file :photo

  validates_attachment_content_type :photo, content_type: /\Aimage/

  validates :name, presence: true
  validates :bio, presence: true

  delegate :url, to: :photo, prefix: true
end
