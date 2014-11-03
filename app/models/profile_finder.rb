class ProfileFinder
  attr_reader :message

  def initialize(message)
    @message = message
    @scope = message.baby_target_type == 'pregnancy' ? 'pregnant' : 'mother'
  end

  def find_profiles_by_message
    if @scope == 'pregnant'
      find_by_profile
    else
      find_by_children
    end
  end

  protected

  def find_by_profile
    Profile.send(@scope).select do |profile|
      @message.age_valid_for_message?(profile.pregnancy_age_in_weeks)
    end
  end

  def find_by_children
    Profile.select do |profile|
      children_finder = ChildrenFinder.new(message, profile.children)
      children_finder.any_children_found?
    end
  end

end
