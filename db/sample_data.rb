require 'factory_girl'
Dir.glob(Rails.root.join('spec/factories/**/*.rb')).each {|factory| require factory }

class SampleData
  include FactoryGirl::Syntax::Methods

  def seed
    ActiveRecord::Base.transaction do
      create(:category, name: "Prevenção", parent_category: :health)
      create(:category, name: "Poupar", parent_category: :finance)
      create(:user, :journalist, email: 'journalist@probebe.com.br')

      create(:user, :author, email: 'author@probebe.com.br')

      create(:user, :site_user, email: 'francisca@probebe.com.br',
                          profile: create(:profile, children: create_list(:child, 2, birth_date: 7.months.from_now, gender: 'male')))
      create(:user, :site_user, email: 'eri@probebe.com.br',
                    profile: create(:profile, children: create_list(:child, 1, birth_date: 3.months.ago, gender: 'female')))

      create(:user, :site_user, email: 'ana@probebe.com.br',
                    profile: create(:profile, children: create_list(:child, 1, birth_date: 3.months.ago, gender: 'male')))

      create(:journalistic_article, maximum_valid_week: 12, baby_target_type: 'pregnancy', messages:
              create_list(:message, 1, text: "Mensagem para bebê em gestação sexo masculino ate 3 meses"))
      create(:journalistic_article, maximum_valid_week: 16, baby_target_type: 'born', gender: 'both', messages:
              create_list(:message, 1, text: "Mensagem para bebê nascido de ambos sexo, em gestação de ate 5 meses"))
      create(:journalistic_article, minimum_valid_week: 8, baby_target_type: 'born', gender: 'female', messages:
              create_list(:message, 1, text: "Mensagem para bebê nascido de sexo feminino, em gestação minima de 2 meses"))
      create(:journalistic_article, maximum_valid_week: 40, baby_target_type: 'pregnancy', messages:
              create_list(:message, 1, text: "Mensagem para bebê em gestação do sexo masculino ate 9 meses"))



    end

  end
end

SampleData.new.seed
