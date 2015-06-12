require 'rails_helper'

describe Articles::AuthorialArticle do
  it_behaves_like 'a article', :authorial_article
end
