require 'rails_helper'

feature "Standard Authentication" do
  scenario "Confirmed user authenticates through registration form" do
    user = create(:user, :confirmed)
    sign_in(user.email, user.password)
    expect(current_path).to eq(new_profile_path)
  end

  scenario "User with complete profile authenticates through registration form" do
    user = create(:user, :with_profile, :confirmed)
    sign_in(user.email, user.password)
    expect(current_path).to eq(root_path)
  end

  scenario "User with incomplete profile authenticates through registration form" do
    user = create(:user, :confirmed, profile: create(:profile, :without_cell_phone))
    sign_in(user.email, user.password)
    expect(current_path).to eq(new_profile_path)
  end
end
