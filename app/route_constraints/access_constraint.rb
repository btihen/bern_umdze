# frozen_string_literal: true

# https://stackoverflow.com/questions/4753871/how-can-i-redirect-a-users-home-root-path-based-on-their-role-using-devise
class AccessConstraint
  def initialize(*roles)
    @roles = roles
  end

  def matches?(request)
    @roles.include? request.env['warden'].user.try(:access_role)
  end
end

# config/routes.rb
# root :to => 'admin#index', :constraints => AccessConstraint.new(:admin) #matches this route when the current user is an admin
# root :to => 'sites#index', :constraints => AccessConstraint.new(:user) #matches this route when the current user is an user
# root :to => 'home#index' #matches this route when the above two matches don't pass
