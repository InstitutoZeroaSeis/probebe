require 'rails_helper'

describe Users::CreateUserWithRandomPassword do
  it 'creates a user with a default random password' do
    user_attributes = {
      email: 'test@example.com',
      role: :publisher,
      profile_attributes: { name: 'Test' }
    }
    create_user = Users::CreateUserWithRandomPassword.new(user_attributes)

    create_user.save

    expect(create_user.user.password).to_not be_empty
  end
end
