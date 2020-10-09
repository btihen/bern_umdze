class UserView < ViewBase

  # alias method allows use to rename view_object to a clear name without the initializer
  alias_method :user,      :root_model

  # delegate to model for attributes needed
  delegate  :id, :username, :email, :real_name, :access_role,
            to: :user

  RolePermission = Struct.new(:role, :permissions, keyword_init: true)
  # https://stackoverflow.com/questions/11962192/convert-a-hash-into-a-struct
  # Person = Struct.new(:first_name, :last_name, :age, keyword_init: true)
  # person_hash = { first_name: "Foo", last_name: "Bar", age: 29 }
  # person = Person.new(person_hash)

  # convert Constant into a struct for the views to use
  # https://stackoverflow.com/questions/11962192/convert-a-hash-into-a-struct
  def self.role_permission_list
    ApplicationHelper::USER_ROLES_AND_PERMISSIONS.map do |rp_hash|
      RolePermission.new(rp_hash)  # works with Ruby 2.5 and Struct with `keyword_init: true`
      # older clumsy way (but always works)
      # RolePermission.new(*rp_hash.values_at(*RolePermission.members))
    end
  end

  def access_permissions
    # first version allowed default access blank
    role  = if username.present? && access_role.blank?
              "member"
            else
              access_role
            end

    ApplicationHelper::USER_ROLES_AND_PERMISSIONS
                      .detect{ |rp| rp[:role].eql?(role)}[:permissions]
  end

  def display_name
    return real_name unless real_name.blank?
    return username  unless username.blank?

    email
  end

end
