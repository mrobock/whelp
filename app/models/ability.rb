class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :read, :update, :destroy, to: :rud
    if user.nil?
      # if no user logged in, use a dummy user, see later
      user = User.new
    end
    if user.has_role? :admin
      can :read, :all
      can :rud, User
      can :rud, Venue
    else user.has_role? :default
      can :read, :all
      can :manage, User, id: user.id
      can :create, Venue
      can :manage, Venue, user_id: user.id
    end
  end
end
