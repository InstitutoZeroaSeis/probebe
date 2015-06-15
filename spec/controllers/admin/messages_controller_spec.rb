require 'rails_helper'

describe Admin::MessagesController do
  describe 'GET edit' do
    it 'redirects to admin/articles#edit' do
      sign_in(build_stubbed(:user, :admin))
      article = create(:article, :with_messages)

      get :edit, id: article.messages.first.id

      expect(response).to redirect_to(
        edit_admin_article_path(article.id)
      )
    end
  end
end
