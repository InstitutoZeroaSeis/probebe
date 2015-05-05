require 'rails_helper'

describe Category do
  it 'is valid with name' do
    category = Category.new(name: 'Category Name')

    category.valid?

    expect(category.errors[:name]).to_not include('não pode ser vazio')
  end

  it 'is invalid without name' do
    category = Category.new(name: '')

    category.valid?

    expect(category.errors[:name]).to include('não pode ser vazio')
  end
end
