require 'rails_helper'

feature 'Admin site user access admin namespace' do
  before { login_as create(:user, :admin) }

  scenario 'and is not redirected from the admin root path' do
    visit carnival_root_path

    expect(current_path).to eq(carnival_root_path)
  end
end
