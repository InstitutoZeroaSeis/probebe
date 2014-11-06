class ArticleReference < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :article
end
