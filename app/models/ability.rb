class Ability
  include CanCan::Ability

  def initialize(user, params)
    # Define abilities for the passed in user here. For example:
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new

    # Authorization settings on DriverReviews
    can :read, DriverReview
    can [:update,:destroy], DriverReview, user_id: user.id
    can :create, DriverReview, request: { user_id: user.id, accepted: true}

    # Authorization settings on Drivers
    can :update, Driver, user_id: user.id
    can :update_location, Driver, user_id: user.id

    # Authorization settings on Requests
    # can :update, Request do |request|
      # user.driver && user.driver.id == request.driver_id
    # end
    # can :index, Request, through: :user
    # can :read, Request, user_id: user.id
    # can :create, Request, driver: { active: true } #unless user.id.nil?

    # Authorization settings on Requests
    can [:create,:index], Request
    can :update, Request, trip: { owner_id: user.id }

    # Authorization settings on Posts
    can [:create,:read], Post do |post|
      post.trip.includes?(user)
    end
    can :update, Post, user_id: user.id

    # Authorization settings on Comments
    can [:create,:read], Comment do |comment|
      comment.post.trip.includes?(user)
    end
    can :update, Comment, user_id: user.id
    can :destroy, Comment do |comment|
      comment.user_id == user.id || comment.post.trip.owner_id == user.id
    end

    # Authorization settings on Users
    can :update, User, id: user.id
    can [:read,:create], User

    # Authorization settings for Trips
    can :update, Trip, owner_id: user.id
    can [:create,:read], Trip
    can :summary, Trip do |trip|
      Rails.logger.info 'summary'
      Rails.logger.info user.to_yaml
      trip.includes?(user) || trip.owner_id == user.id
    end

    # Authorization settings on Cars
    can :create, Car do |driver|
      current_user.id == driver.user_id
    end

  end
end
