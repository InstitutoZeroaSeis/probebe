ActiveRecord::Base.transaction do
  user = User.create!(email: "francisca@probebe.com.br", password: '12345678')
  user.skip_confirmation!
  user.save!
  profile = user.create_profile!
  profile.create_personal_profile!(first_name: 'Francisca', last_name: 'Matsumoto', gender: 'female')
  profile.create_mother_profile!(is_mother: true, children_attributes: [name: 'Hideki', gender: 'male', birth_date: 6.months.ago, born: true])

  user = User.create!(email: "eri@probebe.com.br", password: '12345678')
  user.skip_confirmation!
  user.save!
  profile = user.create_profile!
  profile.create_personal_profile!(first_name: 'Eri', last_name: 'Jonen', gender: 'female')
  profile.create_mother_profile!(is_mother: true, children_attributes: [
    { gender: 'male', birth_date: nil, born: false, pregnancy_start_date: 3.months.ago },
    { name: 'Joana', gender: 'female', birth_date: nil, born: true, birth_date: (1.years + 6.months).ago }
  ])

  prevention_category = Category.create!(name: 'Prevenção', parent_category: Category.create!(name: 'Saúde'))
  savings_category = Category.create!(name: 'Poupar', parent_category: Category.create!(name: 'Financeira'))

  # Bebe da francisca
  Message.create!(text: 'Mensagem para bebê nascido do sexo masculino entre 5 e 7 meses', gender: 'male', baby_target_type: 'born', category: prevention_category, minimum_valid_week: 20, maximum_valid_week: 30)
  # Bebe em gestação da Eri
  Message.create!(text: 'Mensagem para bebê em gestação do sexo masculino de 5 a 7 meses', gender: 'male', baby_target_type: 'pregnancy', category: savings_category, minimum_valid_week: 20, maximum_valid_week: 30)
  # Bebe nascido da Eri
  Message.create!(text: 'Mensagem para bebê nascido do sexo feminino de 1 a 2 anos', gender: 'female', baby_target_type: 'born', category: prevention_category, minimum_valid_week: 52, maximum_valid_week: 104)
  # Nenhum bebê
  Message.create!(text: 'Mensagem para bebê nascido do sexo feminino com menos de 1 anos', gender: 'female', baby_target_type: 'born', category: prevention_category, maximum_valid_week: 52)
  # Bebe da francisca e bebe nascido da Eri
  Message.create!(text: 'Mensagem para bebê nascido independente do sexo com mais de 6 meses', gender: 'both', baby_target_type: 'born', category: prevention_category, minimum_valid_week: 24)

end
