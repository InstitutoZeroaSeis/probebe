class Authors::Author < ActiveRecord::Base
  has_attached_file :photo

  validates_attachment_content_type :photo, content_type: /\Aimage/

  validates :name, presence: true
  validates :bio, presence: true
end
