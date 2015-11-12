class Partner < ActiveRecord::Base
  belongs_to :picture, class_name: 'Ckeditor::Asset'
  belongs_to :logo, class_name: 'Ckeditor::Asset'
  include Rails.application.routes.url_helpers
  extend FriendlyId

  friendly_id :name, use: :slugged

  validates :name, uniqueness: { case_sensitive: false }

  def background_image
    self.picture.data
  end

  def should_generate_new_friendly_id?
    new_record? || name_changed? || slug.nil?
  end

  def show_path
    partner_path self
  end

end
