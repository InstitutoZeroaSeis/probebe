require 'factory_girl'
Dir.glob(Rails.root.join('spec/factories/**/*.rb')).each {|factory| require factory }

class SampleData
  include FactoryGirl::Syntax::Methods

  def seed
    ActiveRecord::Base.transaction do
      create(:category, name: "Prevenção", parent_category: create(:category, name: "Saúde"))
      create(:category, name: "Poupar", parent_category: create(:category, name: "Financeira"))
      admin = create(:user, :confirmed, :admin, email: 'admin@probebe.com.br')
      journalist = create(:user, :confirmed, :journalist, email: 'journalistic@probebe.com.br')
      author = create(:user, :confirmed, :author, email: 'author@probebe.com.br')

      francisca = create(:user, :confirmed, :site_user, email: 'francisca@probebe.com.br',
                          profile: create(:profile, children: create_list(:child, 1, birth_date: 7.months.from_now, gender: 'male')))
      eri = create(:user, :confirmed, :site_user, email: 'eri@probebe.com.br',
                    profile: create(:profile, children: create_list(:child, 1, birth_date: 3.months.ago, gender: 'female')))

      ana = create(:user, :confirmed, :site_user, email: 'ana@probebe.com.br',
                    profile: create(:profile, children: create_list(:child, 1, birth_date: 3.months.ago, gender: 'male')))

      article1 = create(:authorial_article, maximum_valid_week: 12, baby_target_type: 'pregnancy', user: author)
      article2 = create(:authorial_article, maximum_valid_week: 16, baby_target_type: 'born', gender: 'both', user: admin)
      article3 = create(:authorial_article, maximum_valid_week: 8, baby_target_type: 'born', gender: 'female', user: author)
      article4 = create(:authorial_article, maximum_valid_week: 40, baby_target_type: 'pregnancy', user: author)


      create(:journalistic_article, maximum_valid_week: 12, baby_target_type: 'pregnancy', parent_article: article1, original_author: article1.user, user: journalist, messages:
              create_list(:message, 1, text: "Mensagem para bebê em gestação sexo masculino ate 3 meses"))
      create(:journalistic_article, maximum_valid_week: 16, baby_target_type: 'born', parent_article: article2, original_author: article2.user, gender: 'both', user: admin, messages:
              create_list(:message, 1, text: "Mensagem para bebê nascido de ambos sexo, em gestação de ate 5 meses"))
      create(:journalistic_article, minimum_valid_week: 8, baby_target_type: 'born', parent_article: article3, original_author: article3.user, gender: 'female', user: journalist, messages:
              create_list(:message, 1, text: "Mensagem para bebê nascido de sexo feminino, em gestação minima de 2 meses"))
      create(:journalistic_article, maximum_valid_week: 40, baby_target_type: 'pregnancy', parent_article: article4, original_author: article4.user, user: journalist, messages:
              create_list(:message, 1, text: "Mensagem para bebê em gestação do sexo masculino ate 9 meses"))



    end

  end
end

SampleData.new.seed
