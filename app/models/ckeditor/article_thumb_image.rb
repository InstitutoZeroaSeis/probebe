class Ckeditor::ArticleThumbImage < Ckeditor::Asset
  has_attached_file :data,
    styles: { content: '300x200', thumb: '118x100#' }
    url: :custom_url

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 2.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  def url_content
    url(:content)
  end

  def custom_url
    "articles/journalistic_articles/thumb_image_covers/#{image_partition}/:style/:filename"
  end

end
