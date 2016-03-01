if User.count == 0
  User.create!(email: 'admin@probebe.com.br', role: 'admin', password: 'v1z12010', profile: (Profile.create!(name: 'Admin'))) unless User.find_by(email: 'admin@probebe.com.br')
  User.create!(email: 'contato@probebe.com.br', role: 'admin', password: 'v1z12010', profile: (Profile.create!(name: 'Probebe'))) unless User.find_by(email: 'contato@probebe.com.br')
  User.create!(email: 'publisher@probebe.com.br', role: 'publisher', password: 'v1z12010', profile: (Profile.create!(name: 'Publisher'))) unless User.find_by(email: 'publisher@probebe.com.br')
end

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

# if SiteHeader.count == 0
#   SiteHeader.create( path: '/about')
#   SiteHeader.create( path: '/what')
#   SiteHeader.create( path: '/partners')
#   SiteHeader.create( path: '/articles')
#   SiteHeader.create( path: '/posts')
# end

if SiteLandingPage.count == 0
  SiteLandingPage.create( title: 'Receba mensagens surpreendentes em seu celular',
                          text: 'Cadastre-se no ProBebê e receba informações importantes para o bom desenvolvimento de seu bebê, desde o inicio da gravidez até os 18 meses. ProBebê vai ajudar você e seus familiares a cuidar e dar o melhor para seu bebê.  Conheça nosso conteúdo ->'
                        )
end

if SiteMobileImage.count == 0
  SiteMobileImage.create(name: 'Gravidez', title: 'VOCÊ SABIA?',
                        text: 'A partir do quarto mês de gestação o bebê já consegue ouvir a sua voz?')
  SiteMobileImage.create(name: '1 a 4 meses', title: 'VOCÊ SABIA?',
                        text: 'O recém nascido possui 300 ossos e quando cresce esse volume diminui para 206 ossos?')
  SiteMobileImage.create(name: '5 a 8 meses', title: 'VOCÊ SABIA?',
                        text: 'Que com 5 meses os bebês já reconhecem o próprio nome?')
  SiteMobileImage.create(name: '9 a 12 meses', title: 'VOCÊ SABIA?',
                        text: 'Que bebês não podem ingerir mel até completarem um ano de idade?')
  SiteMobileImage.create(name: '13 a 18 meses', title: 'VOCÊ SABIA?',
                        text: 'Aos 18 meses, o bebê já tem um vocabulário com cerca de 50 palavras.')

end

if Site::Page.count == 0
  page_institute = Site::Page.create( title: "<h2>Quem Somos</h2>", text:'<figure><img alt="" height="205" src="http://www.probebe.org.br/assets/logo-zero-a-seis-b1f5af3630d57753aae23267c73ab555.png" width="383" /></figure> <p>&nbsp;</p> <p><span style="font-size:20px;">O Programa ProBeb&ecirc; &eacute; um dos projetos do Instituto Zero a Seis &ndash; Primeira Inf&acirc;ncia e Cultura de Paz. O Instituto &eacute; uma OSCIP (Organiza&ccedil;&atilde;o da Sociedade Civil de Interesse P&uacute;blico) apartid&aacute;ria, humanit&aacute;ria e sem fins lucrativos, formado por estudiosos, cientistas, pesquisadores e formadores de opini&atilde;o que acreditam na constru&ccedil;&atilde;o de uma sociedade melhor por meio da aten&ccedil;&atilde;o e cuidado com a primeira inf&acirc;ncia.</span></p> <p><span style="font-size:20px;">Os projetos do Zero a Seis (ZAS) est&atilde;o focados fortemente na comunica&ccedil;&atilde;o, com o intuito de promover mobiliza&ccedil;&atilde;o social e mudan&ccedil;a cultural, de paradigmas e de valores, rumo aos fundamentos da cultura da paz preconizada pela ONU e suas ag&ecirc;ncias.</span></p> <p><span style="font-size:20px;">Al&eacute;m de atuar junto a todas as esferas do governo brasileiro (federal, estadual e municipal) e trabalhar em redes nacionais e internacionais, em sintonia com in&uacute;meras entidades n&atilde;o governamentais, o ZAS tem colaborado para que empresas e empres&aacute;rios promovam iniciativas e neg&oacute;cios que amparem a primeira inf&acirc;ncia no Brasil.</span></p> <p><span style="font-size:20px;">Criado em 2006, com sede na cidade de S&atilde;o Paulo, o ZAS organiza, ainda, a&ccedil;&otilde;es voltadas diretamente ao p&uacute;blico em geral, apresentando informa&ccedil;&otilde;es relevantes sobre educa&ccedil;&atilde;o e cuidados com as crian&ccedil;as - da concep&ccedil;&atilde;o at&eacute; seis anos de idade - ressaltando o aprendizado social e emocional precoce como um dos principais fundamentos da constru&ccedil;&atilde;o de uma sociedade mais saud&aacute;vel, pac&iacute;fica e cooperativa.</span></p> <p><span style="font-size:20px;">Posicionar a primeira inf&acirc;ncia como prioridade nacional, assegurando, na pr&aacute;tica, o que est&aacute; determinado no Artigo 227 da Constitui&ccedil;&atilde;o Brasileira &eacute; o desafio fundamental do Zero a Seis.</span></p>')
  page_history =  Site::Page.create( title: "<h2>O que &eacute; o ProBeb&ecirc;</h2>", text:'<figure><img alt="" src="http://www.probebe.org.br/assets/logo-orange-probebe-3e7e207356e6c718a3f9f93cb27a42e8.png" /></figure> <p><span style="font-size:20px;"><strong>Mensagem certa,&nbsp;<br /> para a pessoa certa,&nbsp;<br /> na hora certa!</strong></span></p> <p><span style="font-size:20px;">O ProBeb&ecirc; &eacute; um servi&ccedil;o inovador que leva, gratuitamente, informa&ccedil;&otilde;es personalizadas sobre os cuidados b&aacute;sicos do beb&ecirc;, por meio de mensagens via celular. Direcionado prioritariamente &agrave;s m&atilde;es, pais ou cuidadores, o aplicativo envia orienta&ccedil;&otilde;es semanais desde o inicio da gravidez at&eacute; os 18 meses de vida.</span></p> <p><span style="font-size:20px;">A utiliza&ccedil;&atilde;o do aplicativo &eacute; simples e pr&aacute;tica. Basta preencher o cadastro - dispon&iacute;vel no site - indicando a data do nascimento do beb&ecirc; ou a data prevista para o nascimento dele e o n&uacute;mero do celular. As mensagens passam a ser encaminhadas (pelo menos tr&ecirc;s por semana), trazendo informa&ccedil;&otilde;es sobre cada etapa da gesta&ccedil;&atilde;o e ajustadas ao momento de vida do beb&ecirc;.</span></p> <p><span style="font-size:20px;">Dentro da &ldquo;Linha do Tempo&rdquo;, espa&ccedil;o que o site do ProBeb&ecirc; oferece aos usu&aacute;rios, &eacute; poss&iacute;vel encontrar o detalhamento das mensagens recebidas.</span></p> <p><span style="font-size:20px;">Tanto os textos transmitidos pelo celular como os artigos publicados no site contam com a participa&ccedil;&atilde;o de qualificada equipe de especialistas, profissionais respons&aacute;veis por reunir conhecimento atualizado sobre as v&aacute;rias &aacute;reas abordadas: sa&uacute;de, educa&ccedil;&atilde;o, seguran&ccedil;a, comportamento, desenvolvimento, finan&ccedil;as, entre outras.</span></p> <p><span style="font-size:20px;">Toda essa estrutura visa a possibilitar aumento no grau de seguran&ccedil;a e de autoconfian&ccedil;a, sobretudo das m&atilde;es, para cuidar, nutrir e fazer com que o beb&ecirc; tenha condi&ccedil;&otilde;es essenciais para um saud&aacute;vel crescimento.</span></p> <p><span style="font-size:20px;"><strong>Programa do Instituto Zero a Seis, o ProBeb&ecirc; foi um dos premiados do Desafio de Impacto Social Google | Brasil em maio de 2014.</strong></span></p>')
  page_team =  Site::Page.create( title: "<h2>Coordenadores</h2>", text:'<p><span style="font-size:20px;"><strong>Jo&atilde;o Augusto Figueir&oacute;</strong>&nbsp;- &Eacute; diretor cient&iacute;fico do ProBeb&ecirc;</span></p> <p><span style="font-size:20px;">M&eacute;dico, psicoterapeuta, neurocientista, endocrinologista, tamb&eacute;m especializado em medicina nuclear, tendo trabalhado por quase 40 anos no Hospital das Cl&iacute;nicas da Faculdade de Medicina da Universidade de S&atilde;o Paulo (HC-FMUSP, dedicados especialmente ao estudo, ensino e pesquisa da rela&ccedil;&atilde;o entre c&eacute;rebro, mente, meio ambiente, social e influ&ecirc;ncias culturais, o desenvolvimento da crian&ccedil;a e a aplica&ccedil;&atilde;o do conhecimento cient&iacute;fico sobre a primeira inf&acirc;ncia no desenvolvimento de pol&iacute;ticas p&uacute;blicas que atendam a esse grupo et&aacute;rio. Atuou na implanta&ccedil;&atilde;o das a&ccedil;&otilde;es e atividades da Universidade para a Paz (Na&ccedil;&otilde;es Unidas) no Brasil, foi membro do grupo fundador da Rede Gandhi em parceria com o Conselho Nacional de Secret&aacute;rios Municipais de Sa&uacute;de (Conasems). Participou do Conselho T&eacute;cnico Consultivo do Minist&eacute;rio da Sa&uacute;de para a estrat&eacute;gia &ldquo;Brasileirinhos Saud&aacute;veis&rdquo;. &Eacute; membro da Rede Nacional para a Primeira Inf&acirc;ncia e colaborou na elabora&ccedil;&atilde;o do Plano Nacional de Primeira Inf&acirc;ncia. Trabalha em parceria com o Laborat&oacute;rio de An&aacute;lise e Preven&ccedil;&atilde;o da Viol&ecirc;ncia da Universidade Federal de S&atilde;o Carlos em v&aacute;rios projetos, contando com a presen&ccedil;a de ag&ecirc;ncias internacionais. Como conselheiro do Minist&eacute;rio da Cultura ajudou a configurar o Programa Cultura da Crian&ccedil;a no &acirc;mbito do Plano Nacional de Cultura Precoce. Em parceria com o Minist&eacute;rio da Educa&ccedil;&atilde;o e da Secretaria Especial de Direitos Humanos desenvolveu projeto educacional associado &agrave; Declara&ccedil;&atilde;o Universal dos Direitos da Crian&ccedil;a. Foi membro do Grupo Revisor da Conven&ccedil;&atilde;o dos Direitos da Crian&ccedil;a (ONU) e &eacute; presidente do F&oacute;rum Nacional da Primeira Inf&acirc;ncia. Administrador membro da Crian&ccedil;a e Rede Paz, coordenou o Projeto de Mapeamento de programas de primeira inf&acirc;ncia no Brasil em parceria com o Banco Mundial, BID, com o Conselho Empresarial da Am&eacute;rica Latina, com o Committe for Economic Development e com a Universidade de S&atilde;o Paulo. &Eacute; membro da delega&ccedil;&atilde;o dos &ldquo;Forums for Change &ndash; Brazil&rdquo; organizado pela Yale University. Autor de v&aacute;rios livros destinados a leigos e a m&eacute;dicos. S&atilde;o publica&ccedil;&otilde;es especialmente voltadas aos cuidados da sa&uacute;de mental, com foco na educa&ccedil;&atilde;o e preven&ccedil;&atilde;o da cultura de paz no Brasil. Foi reconhecido pela organiza&ccedil;&atilde;o internacional Ashoka como empreendedor social. &Eacute; fundador e atual presidente do Instituto Zero a Seis - Primeira Inf&acirc;ncia e Cultura de Paz.</span></p> <p>&nbsp;</p> <p>&nbsp;</p> <p><span style="font-size:20px;"><strong>Andr&eacute; L. Stabel</strong>&nbsp;- Coordenador do ProBeb&ecirc;</span></p> <p><span style="font-size:20px;">&Eacute; engenheiro e empres&aacute;rio com ampla experi&ecirc;ncia em consultoria com foco especial em Tecnologia da Informa&ccedil;&atilde;o e Modelagem de Banco de Dados aplicada &agrave;s atividades de marketing, como CRM, programas de relacionamento B2B e Programas de Marketing Direto. Consultor e instrutor em Tecnologia da Informa&ccedil;&atilde;o, Banco de Dados, Modelagem Matem&aacute;tica e Otimiza&ccedil;&atilde;o na Funda&ccedil;&atilde;o Get&uacute;lio Vargas e Escola de Engenharia Mau&aacute;.</span></p> <p>&nbsp;</p> <p>&nbsp;</p> <p><span style="font-size:20px;"><strong>Ana Luiza Guimaro</strong>&nbsp;- Respons&aacute;vel pela comunica&ccedil;&atilde;o do ProBeb&ecirc;</span></p> <p><span style="font-size:20px;">&Eacute; formada pela Escola de Comunica&ccedil;&atilde;o e Artes da Universidade de S&atilde;o Paulo em jornalismo e tamb&eacute;m em editora&ccedil;&atilde;o. Estudou Hist&oacute;ria na USP, al&eacute;m de ter seguido cursos suplementares na Escola Superior de Propaganda e Marketing (ESPM) e na Funda&ccedil;&atilde;o Get&uacute;lio Vargas (FGV). Fez especializa&ccedil;&atilde;o na Universit&eacute; de Provence Aix - Marseille /Fran&ccedil;a. Atua na &aacute;rea de comunica&ccedil;&atilde;o empresarial, desenvolvendo projetos jornal&iacute;sticos, institucionais, promocionais e educacionais para diversas empresas brasileiras.</span></p> <p>&nbsp;</p> <p>&nbsp;</p> <p><span style="font-size:20px;"><a href="http://www.zeroaseis.org.br/">www.zeroaseis.org.br</a></span></p>')
  page_partners =  Site::Page.create( title: "<h2>Parceiros</h2>", text:'<figure><img alt="" height="138" src="http://www.probebe.org.br/assets/logo-google-69e424fbcd03eb4757ca6a424e2c184d.png" width="403" /></figure> <p>&nbsp;</p> <p><span style="font-size:20px;">Empresa multinacional americana de servi&ccedil;os online e software, que hospeda e desenvolve uma s&eacute;rie de servi&ccedil;os e produtos baseados na internet. O Google surgiu, no ano de 1998, como uma empresa privada e com a miss&atilde;o de organizar a informa&ccedil;&atilde;o mundial e torn&aacute;-la universalmente acess&iacute;vel e &uacute;til. Cresceu tamb&eacute;m para oferecer produtos al&eacute;m da pesquisa, tecnologias desenvolvidas como Google Chrome e o Gmail.</span></p> <p>&nbsp;</p> <figure><img alt="" src="http://www.probebe.org.br/assets/logo-cria-d1009238ba7caf1e5c6afabf20053be9.png" /></figure> <p>&nbsp;</p> <p><span style="font-size:20px;">Consultoria estrat&eacute;gica que ajuda as organiza&ccedil;&otilde;es a desenhar neg&oacute;cios promovendo inova&ccedil;&atilde;o, valor compartilhado e intraempreendedorismo.</span></p> <p>&nbsp;</p> <figure><img alt="" src="http://www.probebe.org.br/assets/logo-sitawi-5134150a47521db97ce18e0cc1e3bade.png" /></figure> <p>&nbsp;</p> <p><span style="font-size:20px;">Organiza&ccedil;&atilde;o sem fins lucrativos que atua como think-and-do-tank: desenvolve e opera solu&ccedil;&otilde;es financeiras inovadoras para impacto socioambiental, incluindo empr&eacute;stimos sociais e gest&atilde;o de fundos socioambientais para grandes doadores; aconselha investidores na incorpora&ccedil;&atilde;o de quest&otilde;es socioambientais na gest&atilde;o e avalia&ccedil;&atilde;o de investimentos e compartilha conhecimento por meio de pesquisas e publica&ccedil;&otilde;es.</span></p>')
end
if Site::Menu.count == 0
  base_menu1 = Site::Menu.create(name: "O que é o ProBebê?", position: 1)
  Site::Menu.create(name: "O Instituto Zero a Seis", position: 1, parent_menu: base_menu1, page: page_institute)
  Site::Menu.create(name: "História", position: 2, parent_menu: base_menu1, page: page_history)
  Site::Menu.create(name: "Equipe", position: 3, parent_menu: base_menu1, page: page_team)

  base_menu2 = Site::Menu.create(name: "Rede", position: 2)
  Site::Menu.create(name: "Parceiros", position: 1, parent_menu: base_menu2, page: page_partners)
  Site::Menu.create(name: "Colaboradores", position: 2, parent_menu: base_menu2, link: "http://www.probebe.org.br/colaborators")
end
