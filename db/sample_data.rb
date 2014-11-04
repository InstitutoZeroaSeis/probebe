ActiveRecord::Base.transaction do
  user = User.create!(email: "francisca@probebe.com.br", password: '12345678')
  user.skip_confirmation!
  user.save!
  profile = user.create_profile!(first_name: 'Francisca', last_name: 'Matsumoto', gender: 'female', birth_date: 25.years.ago,
                                 children_attributes: [{name: 'Hideki', gender: 'male', birth_date: 6.months.ago}],
                                 cell_phones_attributes: [{ number: '12345678' }])

  user = User.create!(email: "eri@probebe.com.br", password: '12345678')
  user.skip_confirmation!
  user.save!
  profile = user.create_profile!(first_name: 'Eri', last_name: 'Jonen', gender: 'female', birth_date: 22.years.ago,
                                 children_attributes: [{ name: 'Joana', gender: 'female', birth_date: (1.years + 6.months).ago }],
                                 cell_phones_attributes: [{ number: '87654321' }])

  prevention_category = Category.create!(name: 'Prevenção', parent_category: Category.create!(name: 'Saúde'))
  savings_category = Category.create!(name: 'Poupar', parent_category: Category.create!(name: 'Financeira'))

  # Bebe da Francisca
  Message.create!(text: 'Mensagem para bebê nascido do sexo masculino entre 5 e 7 meses', gender: 'male', baby_target_type: 'born', category: prevention_category, minimum_valid_week: 20, maximum_valid_week: 30)
  # Gestação da Eri
  Message.create!(text: 'Mensagem para bebê em gestação do sexo masculino de 5 a 7 meses', gender: 'male', baby_target_type: 'pregnancy', category: savings_category, minimum_valid_week: 20, maximum_valid_week: 30)
  # Bebe da Eri
  Message.create!(text: 'Mensagem para bebê nascido do sexo feminino de 1 a 2 anos', gender: 'female', baby_target_type: 'born', category: prevention_category, minimum_valid_week: 52, maximum_valid_week: 104)
  # Nenhum bebê
  Message.create!(text: 'Mensagem para bebê nascido do sexo feminino com menos de 1 anos', gender: 'female', baby_target_type: 'born', category: prevention_category, maximum_valid_week: 52)
  # Bebe da Francisca e bebe da Eri
  Message.create!(text: 'Mensagem para bebê nascido independente do sexo com mais de 6 meses', gender: 'both', baby_target_type: 'born', category: prevention_category, minimum_valid_week: 24)

end
