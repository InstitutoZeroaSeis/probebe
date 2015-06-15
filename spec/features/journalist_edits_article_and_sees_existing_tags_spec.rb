require 'rails_helper'

feature 'Journalist edits article and sees existing tags' do
  before { login_as create(:user, :journalist) }

  scenario 'succesffully' do
    article = create(:article, tags: create_pair(:tag))
    visit edit_admin_article_path(article)

    tags = find('#articles_article_tag_names').value

    expect(tags).to eq(article.tags.map(&:name).join(', '))
  end
end
