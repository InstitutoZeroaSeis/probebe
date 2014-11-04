class ProfileFinder
  attr_reader :message

  def initialize(message)
    @message = message
    @scope = message.baby_target_type == 'pregnancy' ? 'pregnant' : 'mother'
  end

  def find_profiles_by_message
    find_profiles_by_children
  end

  protected

  def find_profiles_by_children
    Profile.select do |profile|
      children_finder = ChildrenFinder.new(message, profile.children)
      children_finder.any_children_found?
    end
  end

end
