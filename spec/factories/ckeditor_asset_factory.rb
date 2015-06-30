FactoryGirl.define do
  factory :ckeditor_asset, class: 'Ckeditor::Picture' do
    data { File.new(Rails.root.join('spec', 'support', 'files', 'logo.png')) }
  end
end
