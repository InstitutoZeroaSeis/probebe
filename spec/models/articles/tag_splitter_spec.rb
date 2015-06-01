require 'rails_helper'

describe Articles::TagSplitter do
  it 'splits tag by comma' do
    tags = 'a,b'

    splitter = Articles::TagSplitter.new(tags)
    splitted = splitter.split_by_comma

    expect(splitted).to match_array(['a', 'b'])
  end

  it 'strips white spaces' do
    tags = 'a, b'

    splitter = Articles::TagSplitter.new(tags)
    splitted = splitter.split_by_comma

    expect(splitted).to match_array(['a', 'b'])
  end

  it 'removes blank items' do
    tags = 'a, ,c'

    splitter = Articles::TagSplitter.new(tags)
    splitted = splitter.split_by_comma

    expect(splitted).to match_array(['a', 'c'])
  end
end
