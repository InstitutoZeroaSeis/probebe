require 'rails_helper'

feature 'Publisher edits article and sees existing tags' do
  before { login_as create(:user, :publisher) }

  scenario 'succesffully' do
    article = create(:article, tags: create_pair(:tag))
    visit edit_admin_article_path(article.id)

    tags = find('#articles_article_tag_names').value

    expect(tags).to eq(article.tags.map(&:name).join(', '))
  end
end
