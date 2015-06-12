require 'rails_helper'

describe Admin::MessagesController do
  describe 'GET edit' do
    it 'redirects to admin/journalistic_articles#edit' do
      sign_in(build_stubbed(:user, :admin))
      article = create(:journalistic_article, :with_messages)

      get :edit, id: article.messages.first.id

      expect(response).to redirect_to(
        edit_admin_journalistic_article_path(article.id)
      )
    end

    it 'redirects to admin/authorial_articles#edit' do
      sign_in(build_stubbed(:user, :admin))
      article = create(:authorial_article, :with_messages)

      get :edit, id: article.messages.first.id

      expect(response).to redirect_to(
        edit_admin_authorial_article_path(article.id)
      )
    end
  end
end
