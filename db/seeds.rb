Rpush::Gcm::App.create!(name: 'pro-bebe-android', connections: 1, auth_key: "AIzaSyCvHX8Wuiu5y8XjLiIw5QDoIITr7FHCza8") unless Rpush::Gcm::App.find_by(name: 'pro-bebe-android')
User.create!(email: 'admin@probebe.com.br', role: 'admin', password: 'v1z12010', profile: (Profile.create!(first_name: "Admin", last_name: "Admin"))).confirm! unless User.find_by(email: 'admin@probebe.com.br')
