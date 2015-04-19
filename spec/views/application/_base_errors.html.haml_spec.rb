require 'rails_helper'

describe 'application/_base_errors.html.haml' do
  it 'renders base errors of a model' do
    errors = ActiveModel::Errors.new(nil)
    model = double(errors: errors)
    errors.add(:base, 'some error')

    render 'application/base_errors', model: model

    expect(rendered).to have_selector('.alert.alert-danger')
  end

  it 'renders only if there are errors' do
    errors = ActiveModel::Errors.new(nil)
    model = double(errors: errors)

    render 'application/base_errors', model: model

    expect(rendered).to eq('')
  end

  it 'renders only if there are errors in base' do
    errors = ActiveModel::Errors.new(nil)
    model = double(errors: errors)
    errors.add(:non_base, 'some error')

    render 'application/base_errors', model: model

    expect(rendered).to eq('')
  end
end
