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

  it 'is valid with parent_category' do
    category = Category.new(parent_category: Category.new)

    category.valid?

    expect(category.errors[:parent_category])
      .to_not include('não pode ser vazio')
  end

  it 'is invalid without parent_category' do
    category = Category.new(parent_category: nil)

    category.valid?

    expect(category.errors[:parent_category]).to include('não pode ser vazio')
  end
end
