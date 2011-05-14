class Ability
  include CanCan::Ability

  def initialize(user)
    if super_admin?(user)
      can :manage, :all
    elsif admin?(user)
      can :manage, [Webpage, Subpage, Widget, Image, Contact]
      can :view, [User]
      can :manage, user
    elsif manager?(user)
      can :edit, [Webpage, Subpage]
      can :manage, user
    else
      can :view, [Webpage, Subpage, Widget, Image, Contact]
    end
  end

  private

  def viewer?(user)
    user.role == User::Roles::DEFAULT
    end

  def manager?(user)
    user.role == User::Roles::MANAGER
  end

  def admin?(user)
    user.role == User::Roles::ADMIN
  end

  def super_admin?(user)
    user.role == User::Roles::SUPER_ADMIN
  end
end
