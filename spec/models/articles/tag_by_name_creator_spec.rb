require 'rails_helper'

describe Articles::TagByNameCreator do
  it 'creates new tags and return existing ones' do
    existing_tag = create(:tag, name: 'pregnancy')
    new_tags = ['health', 'education']
    tag_names = new_tags + ['pregnancy']

    creator = Articles::TagByNameCreator.new(tag_names)
    tags = creator.find_or_create_tags

    expect(tags.map(&:name)).to match_array(tag_names)
  end

  it 'persists new tags' do
    tag_names = ['health', 'education']

    creator = Articles::TagByNameCreator.new(tag_names)
    tags = creator.find_or_create_tags

    expect(tags.all?(&:persisted?)).to eq(true)
  end

  it 'creates all valid tags new or existing ones' do
    existing_tag = create(:tag, name: 'pregnancy')
    new_tags = ['health', 'education']
    tag_names = new_tags + ['pregnancy']

    creator = Articles::TagByNameCreator.new(tag_names)
    tags = creator.find_or_create_tags

    expect(tags.all?(&:valid?)).to eq(true)
  end

  it 'creates new tags only if required' do
    existing_tag = create(:tag, name: 'pregnancy')
    new_tags = ['health', 'education']
    tag_names = new_tags + ['pregnancy']

    creator = Articles::TagByNameCreator.new(tag_names)

    expect{
      creator.find_or_create_tags
    }.to change {
      Tag.count
    }.by(new_tags.size)
  end
end
