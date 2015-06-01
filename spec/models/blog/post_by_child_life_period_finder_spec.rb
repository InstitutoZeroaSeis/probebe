  require 'rails_helper'

  RSpec.describe Blog::PostByChildLifePeriodFinder do
    context 'with some post' do
      it 'returns only post with expected category' do
        first_to_fourth_post = create(:post, minimum_valid_week: 3,
                                      maximum_valid_week: 12, baby_target_type: 'born')
        fifth_to_eighth_post = create(:post, minimum_valid_week: 20,
                                      maximum_valid_week: 25, baby_target_type: 'born')

        finder = Blog::PostByChildLifePeriodFinder.new('first_to_fourth', Blog::Post)

        expect(finder.find).to eq([first_to_fourth_post])
      end
  end
end
