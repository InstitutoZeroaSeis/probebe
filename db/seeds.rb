Rpush::Gcm::App.create!(name: 'pro-bebe-android', connections: 1, auth_key: "AIzaSyCvHX8Wuiu5y8XjLiIw5QDoIITr7FHCza8") unless Rpush::Gcm::App.find_by(name: 'pro-bebe-android')
User.create!(email: 'admin@probebe.com.br', role: 'admin', password: 'v1z12010', profile: (Profile.create!(name: 'Admin'))) unless User.find_by(email: 'admin@probebe.com.br')
User.create!(email: 'contato@probebe.com.br', role: 'admin', password: 'v1z12010', profile: (Profile.create!(name: 'Probebe'))) unless User.find_by(email: 'contato@probebe.com.br')
User.create!(email: 'publisher@probebe.com.br', role: 'publisher', password: 'v1z12010', profile: (Profile.create!(name: 'Publisher'))) unless User.find_by(email: 'publisher@probebe.com.br')
