class Ability
  include CanCan::Ability

  def initialize(user)
    set_admin_permissions(user)
    set_author_permissions(user)
    set_journalist_permissions(user)
    set_site_user_permissions(user)
  end

  def set_admin_permissions(user)
    if user.admin?
      can :manage, :all
    end
  end

  def set_author_permissions(user)
    if user.author?
      can [:read, :create], Articles::AuthorialArticle
      can [:update], Articles::AuthorialArticle, user_id: user.id

      can [:read], Articles::JournalisticArticle
      can [:read], Message
      can [:read, :update, :create], Category
      can [:read, :update, :create], Tag
    end
  end

  def set_journalist_permissions(user)
    if user.journalist?
      can [:read, :create, :update], Articles::JournalisticArticle
      can [:read, :create_journalistic_article], Articles::AuthorialArticle
      can [:read], Message
      can [:read, :update, :create], Category
      can [:read, :update, :create], Tag
    end
  end

  def set_site_user_permissions(user)
    if user.site_user?
      can [:read, :create, :update], Profile
      can :show, Child, profile_id: user.profile_id
    end
  end

end
