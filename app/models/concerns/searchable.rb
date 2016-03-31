module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    include Indexing
    after_touch() { __elasticsearch__.index_document }

    settings index: { number_of_shards: 1 } do

      mappings dynamic: 'false' do

        indexes :id, type: 'long'
        indexes :title, index: 'not_analyzed', type: 'string'
        indexes :text, index: 'not_analyzed', type: 'string'
        indexes :summary, index: 'not_analyzed', type: 'string'
        indexes :box, index: 'not_analyzed', type: 'string'
        indexes :gender, index: 'not_analyzed', type: 'string'
        indexes :category_id, type: 'long'
        indexes :teenage_pregnancy, type: 'boolean'
        indexes :baby_target_type, index: 'not_analyzed', type: 'string'
        indexes :minimum_valid_week, type: 'long'
        indexes :maximum_valid_week, type: 'long'
        indexes :journalistic_articles_count, type: 'long'
        indexes :user_id, type: 'long'
        indexes :original_author_id, type: 'long'

        indexes :tags do
          indexes :id, type: 'long'
          indexes :name, index: 'not_analyzed', type: 'string'
        end
      end
    end
  end

  module Indexing

    # Customize the JSON serialization for Elasticsearch
    def as_indexed_json(options={})
      self.as_json(
        include: { tags: {except: [:created_at, :updated_at]} })
    end
  end
end
