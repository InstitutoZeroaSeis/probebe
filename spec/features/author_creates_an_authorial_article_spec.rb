require 'rails_helper'

feature "Author create an authorial article" do
  scenario "successfully" do
    user = create(:user, :confirmed, :author)
    article_title = "Test title see if index showing title"
    create(:category, parent_category: create(:category), name: 'Saúde')
    sign_in(user.email, user.password)
    visit new_admin_authorial_article_path
    within '#articles_authorial_article_category_id' do
      find('option', text: 'Saúde').select_option
    end
    fill_in "articles_authorial_article_title", with: article_title
    fill_in "articles_authorial_article_text", with: "Text"
    fill_in "articles_authorial_article_summary", with: "Summary"

    click_on 'Criar'

    expect(current_path).to eq(carnival_root_path)
    expect(page).to have_content(article_title)
  end
end
