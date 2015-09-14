class RemoveAuthorialArticlesMessages < ActiveRecord::Migration
  class Message < ActiveRecord::Base

  end

  def up
    Message.where(messageable_type: 'Articles::AuthorialArticle').destroy_all
    Message.where(messageable_type: nil).destroy_all
  end

  def down
  end
end
