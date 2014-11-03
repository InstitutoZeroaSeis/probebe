module OmniAuthStub
  module Google
    BasicInfo = OmniAuth::AuthHash.new({
      uid: '1337',
      provider: 'google_oauth2',
      info: {
        email: 'name@example.com',
        first_name: 'Name',
        last_name: 'Surname'
      }
    })
    WithoutEmail = OmniAuth::AuthHash.new({
      uid: '1337',
      provider: 'google_oauth2',
      info: {
      }
    })
  end
  MissingNameHash = OmniAuth::AuthHash.new({
    'provider' => 'google',
    'uid' => '12345678',
    'info' => {
      'email' => 'name@server.com'
    }
  })
  StubbedHash = OmniAuth::AuthHash.new({
    'provider' => 'google',
    'uid' => '12345678',
    'info' => {
      'name' => 'Name Surname',
      'email' => 'name@server.com',
      'first_name' => 'Name',
      'last_name' => 'Surname'
    },
    'extra' => {
      'raw_info' => {
        'gender' => 'male'
      }
    }
  })
end
