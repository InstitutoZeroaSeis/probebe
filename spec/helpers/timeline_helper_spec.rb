require 'rails_helper'

RSpec.describe TimelineHelper, :type => :helper do
  describe '.definition_list_item' do
    it "generates a definition list" do
      output = helper.definition_list_item('term', 'content')
      expect(output).to eq('<dt>term</dt><dd>content</dd>')
    end
  end
end
