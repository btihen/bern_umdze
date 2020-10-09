module ApplicationHelper

  USER_ROLES_AND_PERMISSIONS = [
    {role: "trustee", permissions: "Full access (Depricated)"},
    {role: "manager", permissions: "Full access"},
    {role: "planner", permissions: "Create/edit booking"},
    {role: "umdze",   permissions: "Update (Depricated)"},
    {role: "host",    permissions: "Update Umdze/Koord."},
    {role: "viewer",  permissions: "View only"},
    {role: "member",  permissions: "Read only (Depricated)"},
  ]

  VALID_ROLES = USER_ROLES_AND_PERMISSIONS.map { |rp| rp[:role] }

end
