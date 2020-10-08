module ApplicationHelper

  USER_ROLES_AND_PERMISSIONS = [
    {role: "trustee", permissions: "Full access"},
    {role: "planner", permissions: "Create/edit reservations"},
    {role: "umdze",   permissions: "Update umdze/koord."},
    {role: "member",  permissions: "Read only"},
  ]

  VALID_ROLES = USER_ROLES_AND_PERMISSIONS.map { |rp| rp[:role] }

end
