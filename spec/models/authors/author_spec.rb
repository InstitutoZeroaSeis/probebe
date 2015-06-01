require 'rails_helper'

describe Authors::Author do
  it 'is valid with name' do
    author = Authors::Author.new(name: 'Author Name')

    author.valid?

    expect(author.errors[:name]).to_not include('não pode ser vazio')
  end

  it 'is invalid without name' do
    author = Authors::Author.new(name: '')

    author.valid?

    expect(author.errors[:name]).to include('não pode ser vazio')
  end

  it 'is valid with bio' do
    author = Authors::Author.new(bio: 'Author Bio')

    author.valid?

    expect(author.errors[:bio]).to_not include('não pode ser vazio')
  end

  it 'is invalid without bio' do
    author = Authors::Author.new(bio: '')

    author.valid?

    expect(author.errors[:bio]).to include('não pode ser vazio')
  end
end
