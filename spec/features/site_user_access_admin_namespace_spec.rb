require 'rails_helper'

feature 'Site user access admin namespace' do
  before { login_as create(:user, :site_user) }

  scenario 'and gets redirected back to root_path' do
    visit carnival_root_path

    expect(current_path).to eq(root_path)
  end
end
