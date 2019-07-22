# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    can :manage, User, id: user.id

    if user.is_chef?
      can [:read, :update], Order, chef_id: user.id
      can :read, User, orders: { chef_id: user.id }
      can :manage, Menu, chef_id: user.id
      can :manage, Item, chef_id: user.id 
    else
      can [:read, :update], Order, customer_id: user.id
      can :read, User, orders: { customer_id: user.id }
      can :read, Menu, is_current: true
      can :read, Item, menus: { is_current: true } 
    end
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
