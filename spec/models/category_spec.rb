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

  it 'is invalid if a category with children is updated with a parent' do
    parent_category = create(:category)
    create_pair(:category, parent_category: parent_category)
    parent_category.parent_category = Category.new

    parent_category.valid?

    expect(parent_category.errors[:parent_category])
      .to include('não pode ter mais do que dois níves')
  end

  it 'is invalid with an existing name' do
    category_name = 'Existing Category'
    create(:category, name: category_name)
    category = Category.new(name: category_name)

    category.valid?

    expect(category.errors[:name]).to include('não está disponível')
  end

  it 'can be destroyed if has no articles associated' do
    category = create(:category)

    category.destroy

    expect(category).to be_destroyed
  end

  it 'can\'t be destroyed if has articles associated' do
    category = create(:category, :with_parent)
    create(:article, category: category)

    category.destroy

    expect(category).to_not be_destroyed
    expect(category.errors[:base])
      .to include('não pode remover categoria com artigos')
  end

  it 'lists only base categories(without parent_category)' do
    base_category = create(:category)
    create(:category, parent_category: base_category)

    expected_base_categories = Category.base_categories

    expect(expected_base_categories.map(&:name))
      .to match_array([base_category.name])
  end

  it 'lists only sub categories(with parent_category)' do
    base_category = create(:category)
    sub_category = create(:category, parent_category: base_category)

    expected_sub_categories = Category.sub_categories

    expect(expected_sub_categories.map(&:name))
      .to match_array([sub_category.name])
  end
end
