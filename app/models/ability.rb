class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.has_role? :admin
      can :manage, :all
    end
    
    if user.has_role? :guest
      can :read, Post
      can :write, Post
    end
    
    if user.has_role? :moderator
      can :manage, Board
    end
    
    if User.count == 0
      can :manage, User
    end
  end
end
