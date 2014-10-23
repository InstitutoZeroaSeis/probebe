class Avatar < ActiveRecord::Base
  has_attached_file :photo, styles: { full: '640x480', thumb: '160x120'}

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :photo, :in => 0..1.megabyte

  def from_url(url)
    self.photo = open(url)
  end
end
