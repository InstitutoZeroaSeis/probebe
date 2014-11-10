class Ability
  include CanCan::Ability

  def initialize(user)
    set_admin_permissions(user)
    set_author_permissions(user)
    set_journalist_permissions(user)
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
    end
  end

  def set_journalist_permissions(user)
    if user.journalist?
    end
  end

end
