# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    user ||= User.new # guest user (not logged in)

    can :manage, User, id: user.id

    can :create, Order
    can [:read, :update], Order, user_id: user.id
    can [:read, :create], Restaurant
    can :read, Item
    can :read, Table

    if user.is_restaurant_owner?
      can [:read, :update], Order do |order|
        user.restaurant_ids.include?(order.restaurant.id)
      end
      can :read, User do |customer|
        !(user.restaurants.orders & customer.orders).empty?
      end
      can :manage, Restaurant, owner_id: user.id
      can :create, Item
      can :manage, Item do |item|
        user.restaurant_ids.include?(item.restaurant_id)
      end
      can :create, Table
      can :manage, Table do |table|
        user.restaurant_ids.include?(table.restaurant_id)
      end
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
