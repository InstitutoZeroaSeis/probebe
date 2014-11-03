class ProfileFinder
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def find_profiles_by_message
    Profile.select do |profile|
      children_finder = ChildrenFinder.new(message, profile.children)
      children_finder.any_children_found?
    end
  end

end
