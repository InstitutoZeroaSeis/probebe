class Ckeditor::ArticleCoverImage < Ckeditor::Asset
  has_attached_file :data, styles: { content: '1920>', thumb: '118x100#' },
    path: ":path_root/articles/journalistic_articles/covers/:image_partition/:style/:filename",
    url: ":url_root/articles/journalistic_articles/covers/:image_partition/:style/:filename"


  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 2.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  def url_content
    url(:content)
  end

end
