class Blog::Post
  def self.method_missing(name, *args, &block)
    Articles::JournalisticArticle.send(name, *args, &block)
  end
end
