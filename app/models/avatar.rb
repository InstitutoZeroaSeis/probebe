class Avatar < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :profile
  belongs_to :child

  has_attached_file :photo, styles: { full: '640x480', thumb: '160x120'}

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :photo, :in => 0..1.megabyte

  def self.create_from_url(url, options={})
    photo = Http::Download.download(url)
    Avatar.create(options.merge(photo: photo))
  end

end
