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

  it 'is valid with another parent category' do
    category = Category.new
    category.parent_category = Category.new

    category.valid?

    expect(category.errors[:parent_category])
      .to_not include('não pode ser igual a categoria')
  end

  it 'is invalid with parent category equals to self' do
    category = Category.new
    category.parent_category = category

    category.valid?

    expect(category.errors[:parent_category])
      .to include('não pode ser igual a categoria')
  end

  it 'is valid with at most two leves of category depth' do
    category = Category.new(parent_category: Category.new)

    category.valid?

    expect(category.errors[:parent_category])
      .to_not include('não pode ter mais que dois níveis')
  end

  it 'is invalid with more than two leves of category depth' do
    category_with_parent = Category.new(parent_category: Category.new)
    category = Category.new(parent_category: category_with_parent)

    category.valid?

    expect(category.errors[:parent_category])
      .to include('não pode ter mais que dois níveis')
  end

  it 'is valid with no cycles in the parent_category' do
    parent_category = Category.new
    child_category = Category.new(parent_category: parent_category)

    parent_category.valid?

    expect(parent_category.errors[:parent_category])
      .to_not include('não pode ser igual a uma subcategoria')
  end

  it 'is invalid with a parent_category a cycle in the parent_category' do
    parent_category = Category.new
    child_category = Category.new(parent_category: parent_category)
    parent_category.parent_category = child_category

    parent_category.valid?

    expect(parent_category.errors[:parent_category])
      .to include('não pode ser igual a uma subcategoria')
  end
end
