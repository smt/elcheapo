class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    #if user.role? :admin
      can :manage, :all 
    #else
      #can :read, :all #if user.role? :user
      #can :create, Message
      #can :update, Message do |message|
        #message.try(:user) == user
      #end
    #end
  end
end
