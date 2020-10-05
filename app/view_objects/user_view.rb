class UserView < ViewBase

  # alias method allows use to rename view_object to a clear name without the initializer
  alias_method :user,      :root_model

  # delegate to model for attributes needed
  delegate  :id, :username, :email, :real_name, :access_role,
            to: :user

  def display_name
    return real_name unless real_name.blank?
    return username  unless username.blank?

    email
  end

end
