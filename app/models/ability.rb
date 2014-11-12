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

      can [:read], Articles::JournalisticArticle
      can [:read], Message
      can [:read], Category
    end
  end

  def set_journalist_permissions(user)
    if user.journalist?
      can [:read, :create], Articles::JournalisticArticle
      can [:update], Articles::JournalisticArticle, user_id: user.id
      can [:create_journalistic_article], Articles::AuthorialArticle
      can [:read], Articles::AuthorialArticle
      can [:read], Message
      can [:read], Category
    end
  end

end
