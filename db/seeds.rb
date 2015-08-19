Rpush::Gcm::App.create!(name: 'pro-bebe-android', connections: 1, auth_key: "AIzaSyCvHX8Wuiu5y8XjLiIw5QDoIITr7FHCza8") unless Rpush::Gcm::App.find_by(name: 'pro-bebe-android')
User.create!(email: 'admin@probebe.com.br', role: 'admin', password: 'v1z12010', profile: (Profile.create!(name: 'Admin'))) unless User.find_by(email: 'admin@probebe.com.br')
User.create!(email: 'contato@probebe.com.br', role: 'admin', password: 'v1z12010', profile: (Profile.create!(name: 'Probebe'))) unless User.find_by(email: 'contato@probebe.com.br')
User.create!(email: 'publisher@probebe.com.br', role: 'publisher', password: 'v1z12010', profile: (Profile.create!(name: 'Publisher'))) unless User.find_by(email: 'publisher@probebe.com.br')

if SiteBanner.count == 0
  background_img = Rails.root.join('app', 'assets', 'images', 'banner-1.jpg')
  SiteBanner.create( position: 1,
                     name: 'Gravidez',
                     title: 'Você Sabia?',
                     text: 'A partir do quarto mês de gestação o bebê já consegue ouvir a sua voz?',
                     background_image: File.new( background_img ) )

  background_img = Rails.root.join('app', 'assets', 'images', 'banner-2.jpg')
  SiteBanner.create( position: 2,
                     name: '1 a 4 meses',
                     title: 'Você Sabia?',
                     text: 'O recém nascido possui 300 ossos e quando cresce esse volume diminui para 206 ossos?',
                     background_image: File.new( background_img ) )
  background_img = Rails.root.join('app', 'assets', 'images', 'banner-3.jpg')
  SiteBanner.create( position: 3,
                     name: '5 a 8 meses',
                     title: 'Você Sabia?',
                     text: 'Que com 5 meses os bebês já reconhecem o próprio nome?',
                     background_image: File.new( background_img ) )
  background_img = Rails.root.join('app', 'assets', 'images', 'banner-4.jpg')
  SiteBanner.create( position: 4,
                     name: '9 a 12 meses',
                     title: 'Você Sabia?',
                     text: 'Que bebês não podem ingerir mel até completarem um ano de idade?',
                     background_image: File.new( background_img ) )
  background_img = Rails.root.join('app', 'assets', 'images', 'banner-5.jpg')
  SiteBanner.create( position: 5,
                     name: '13 a 18 meses',
                     title: 'Você Sabia?',
                     text: 'Aos 18 meses, o bebê já tem um vocabulário com cerca de 50 palavras.',
                     background_image: File.new( background_img ) )
end

if Category.to_show_in_home.count == 0
  img = Rails.root.join('app', 'assets', 'images', 'category-health.jpg')
  category = Category.find 14
  category.position_in_home = 1
  category.show_in_home = true
  category.color = '#CA3343'
  category.second_color = '#FFF6F9'
  category.slug = 'saude'
  category.title = '<p>Fique atenta a sua <strong><span style="color:#CA3343;">sa&uacute;de</span></strong></p>'
  category.subtitle = '<p>Mais de <strong><span style="color:#CA3343;">300</span></strong> artigos</p>'
  category.text = '<p>com orienta&ccedil;&otilde;es simples e pr&aacute;ticas para garantir uma gesta&ccedil;&atilde;o tranquila e o nascimento de um beb&ecirc; saud&aacute;vel.</p>'
  category.category_image_text = '<p>Voc&ecirc; acha que precisa comer por dois? Esque&ccedil;a disso e veja como se alimentar de forma correta.</p>'
  category.category_image = File.new(img)
  category.save

  img = Rails.root.join('app', 'assets', 'images', 'category-education.jpg')
  category = Category.find 18
  category.position_in_home = 2
  category.show_in_home = true
  category.color = '#F69343'
  category.second_color = '#FFFBF2'
  category.title = '<p><strong><span style="color:#F69343;">Educa&ccedil;&atilde;o</span></strong> come&ccedil;a na barriga</p>'
  category.subtitle = ''
  category.text = '<p>Educar uma crian&ccedil;a exige dedica&ccedil;&atilde;o, mas n&atilde;o &eacute; um bicho de sete cabe&ccedil;as. Aprenda com nossos especialistas.</p>'
  category.category_image_text = '<p>Com poucos meses, o beb&ecirc; j&aacute; consegue distinguir entre bons e maus comportamentos.</p>'
  category.category_image = File.new(img)
  category.save


  img = Rails.root.join('app', 'assets', 'images', 'category-behavior.jpg')
  category = Category.find 20
  category.position_in_home = 3
  category.show_in_home = true
  category.color = '#6859AA'
  category.second_color = '#F8F5FC'
  category.title = '<p><strong><span style="color:#6859AA;">Desenvolvimento</span></strong> e cuidados com o beb&ecirc;</p>'
  category.subtitle = '<p><strong><span style="color:#6859AA;">Desenvolvimento</span></strong> e cuidados com a mente do beb&ecirc;</p>'
  category.text = '<p>Descubra como acontece o fant&aacute;stico desenvolvimento dos beb&ecirc;s, desde o &uacute;tero, e o que voc&ecirc; pode fazer para torn&aacute;-lo ainda melhor.</p>'
  category.category_image_text = '<p>O c&eacute;rebro do beb&ecirc; n&atilde;o nasce totalmente formado. Cabe aos pais terminar essa delicada tarefa.</p>'
  category.category_image = File.new(img)
  category.save


  img = Rails.root.join('app', 'assets', 'images', 'category-security.jpg')
  category = Category.find 16
  category.position_in_home = 4
  category.show_in_home = true
  category.color = '#FABE67'
  category.second_color = '#FFF8F0'
  category.title = '<p>A <strong><span style="color:#FABE67;">seguran&ccedil;a</span></strong> dos seus filhos</p>'
  category.subtitle = '<p>Mais de <strong><span style="color:#FABE67;">100</span></strong> dicas</p>'
  category.text = '<p>Voc&ecirc; pode proteger melhor o seu filho. Veja como tornar a sua casa mais segura</p>'
  category.category_image_text = '<p>No Brasil, os acidentes s&atilde;o a principal causa de morte de crian&ccedil;as de at&eacute; 9 anos.</p>'
  category.category_image = File.new(img)
  category.save


  img = Rails.root.join('app', 'assets', 'images', 'category-finance.jpg')
  category = Category.find 15
  category.position_in_home = 5
  category.show_in_home = true
  category.color = '#00AEEF'
  category.second_color = '#9FD6EA'
  category.title = '<p>O b&ecirc;-&aacute;-b&aacute; das <strong><span style="color:#00AEEF;">finan&ccedil;as</span></strong></p>'
  category.subtitle = '<p>Finan&ccedil;as</p>'
  category.text = '<p>N&atilde;o &eacute; f&aacute;cil criar um filho hoje em dia. Mas, com a ajuda de nossos especialistas, voc&ecirc; vai aprender a fazer seu dinheiro render muito mais.</p>'
  category.category_image_text = '<p>Quanto custa ter um filho? Voc&ecirc; j&aacute; fez as contas?</p>'
  category.category_image = File.new(img)
  category.save
end

if SiteHeader.count == 0
  SiteHeader.create( path: '/about')
  SiteHeader.create( path: '/what')
  SiteHeader.create( path: '/partners')
  SiteHeader.create( path: '/articles')
  SiteHeader.create( path: '/posts')
end
