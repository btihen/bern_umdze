class UserView < ViewBase

  # alias method allows use to rename view_object to a clear name without the initializer
  alias_method :user,      :root_model

  # delegate to model for attributes needed
  delegate  :id, :username, :email, :real_name, :access_role,
            to: :user

  RolePermission = Struct.new(:role, :permissions)

  # convert Constant into a struct for the views to use
  # https://stackoverflow.com/questions/11962192/convert-a-hash-into-a-struct
  def self.role_permission_list
    ApplicationHelper::USER_ROLES_AND_PERMISSIONS.map do |rp_hash|
      RolePermission.new(*rp_hash.values_at(*RolePermission.members))
    end
  end

  def access_permissions
    # first version allowed default access blank
    return "member" if username.present? && access_role.blank?

    ApplicationHelper::USER_ROLES_AND_PERMISSIONS
                      .detect{ |rp| rp[:role].eql?(access_role)}[:permissions]
  end

  def display_name
    return real_name unless real_name.blank?
    return username  unless username.blank?

    email
  end

end
