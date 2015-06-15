class Ability
  include CanCan::Ability

  def initialize(user)
    set_admin_permissions(user)
    set_publisher_permissions(user)
    set_site_user_permissions(user)
  end

  def set_admin_permissions(user)
    if user.admin?
      can :manage, :all
    end
  end

  def set_publisher_permissions(user)
    if user.publisher?
      can [:read, :create, :update], Articles::Article
      can [:read], Message
      can [:read, :update, :create], Category
      can [:read, :update, :create], Tag
    end
  end

  def set_site_user_permissions(user)
    if user.site_user?
      can [:read, :create, :update], Profile
      can [:show, :monthly], Child, profile_id: user.profile_id
    end
  end

end
