class ProfileFinder
  attr_reader :message

  def initialize(message)
    @message = message
    @scope = message.baby_target_type == 'pregnancy' ? 'pregnant' : 'mother'
  end

  def find_profiles_by_message
    find_by_profile +
      find_by_children
  end

  protected

  def find_by_profile
    Profile.send(@scope).select do |profile|
      min_week = @message.minimum_valid_week || 0
      max_week = @message.maximum_valid_week || Message::MAXIMUM_POSSIBLE_WEEK
      (min_week..max_week).include? profile.pregnancy_age_in_weeks
    end
  end

  def find_by_children
    Profile.select do |profile|
      children_finder = ChildrenFinder.new(message, profile.children)
      children_finder.any_children_found?
    end
  end

end
