Rpush::Gcm::App.create!(name: 'pro-bebe-android', connections: 1, auth_key: "AIzaSyCvHX8Wuiu5y8XjLiIw5QDoIITr7FHCza8") unless Rpush::Gcm::App.find_by(name: 'pro-bebe-android')
User.create!(email: 'admin@probebe.com.br', role: 'admin', password: 'v1z12010', profile: (Profile.create!(name: 'Admin'))) unless User.find_by(email: 'admin@probebe.com.br')
User.create!(email: 'contato@probebe.com.br', role: 'admin', password: 'v1z12010', profile: (Profile.create!(name: 'Probebe'))) unless User.find_by(email: 'contato@probebe.com.br')
User.create!(email: 'publisher@probebe.com.br', role: 'publisher', password: 'v1z12010', profile: (Profile.create!(name: 'Publisher'))) unless User.find_by(email: 'publisher@probebe.com.br')

background_img = Rails.root.join('app', 'assets', 'images', 'banner-1.jpg')
SiteBanner.create( banner_type: 0,
                   title: 'Você Sabia?',
                   text: 'A partir do quarto mês de gestação o bebê já consegue ouvir a sua voz?',
                   background_image: File.new( background_img ) )

background_img = Rails.root.join('app', 'assets', 'images', 'banner-2.jpg')
SiteBanner.create( banner_type: 1,
                   title: 'Você Sabia?',
                   text: 'O recém nascido possui 300 ossos e quando cresce esse volume diminui para 206 ossos?',
                   background_image: File.new( background_img ) )
background_img = Rails.root.join('app', 'assets', 'images', 'banner-3.jpg')
SiteBanner.create( banner_type: 2,
                   title: 'Você Sabia?',
                   text: 'Que com 5 meses os bebês já reconhecem o próprio nome?',
                   background_image: File.new( background_img ) )
background_img = Rails.root.join('app', 'assets', 'images', 'banner-4.jpg')
SiteBanner.create( banner_type: 3,
                   title: 'Você Sabia?',
                   text: 'Que bebês não podem ingerir mel até completarem um ano de idade?',
                   background_image: File.new( background_img ) )
background_img = Rails.root.join('app', 'assets', 'images', 'banner-5.jpg')
SiteBanner.create( banner_type: 4,
                   title: 'Você Sabia?',
                   text: 'Aos 18 meses, o bebê já tem um vocabulário com cerca de 50 palavras.',
                   background_image: File.new( background_img ) )
