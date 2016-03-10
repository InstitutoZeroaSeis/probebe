require 'rails_helper'

# feature 'Publisher create an article' do
#   before { login_as create(:user, :publisher) }

#   scenario 'successfully', js: true do
#     article_title = 'Test title see if index showing title'
#     create(:category, :with_parent, name: 'Saúde')
#     author = create(:author)

#     visit new_admin_article_path
#     within '#articles_article_category_id' do
#       find('option', text: 'Saúde').select_option
#     end
#     within '#articles_article_original_author_id' do
#       find('option', text: author.name).select_option
#     end
#     pic = FactoryGirl.create :ckeditor_asset
#     fill_in 'articles_article_cover_picture_id', with: pic.id

#     fill_in 'articles_article_title', with: article_title
#     fill_in 'articles_article_text', with: 'Text'
#     fill_in 'articles_article_summary', with: 'Summary'
#     within '#articles_article_baby_target_type' do
#       find('option', text: 'Nascido').select_option
#     end
#     fill_in 'articles_article_minimum_valid_week', with: 10
#     click_on 'Criar'
#     visit admin_articles_path

#     expect(page).to have_content(article_title)
#   end
# end
