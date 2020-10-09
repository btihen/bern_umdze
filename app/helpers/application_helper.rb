module ApplicationHelper

  USER_ROLES_AND_PERMISSIONS = [
    {role: "manager", permissions: "Full Manager Access"},
    {role: "planner", permissions: "Create/Edit bookings"},
    {role: "host",    permissions: "Update Coordinators"},
    {role: "viewer",  permissions: "View Calendar Plan"},
    # {role: "umdze",   permissions: "Update (Depricated)"},
    # {role: "trustee", permissions: "Full access (Depricated)"},
    # {role: "member",  permissions: "Read only (Depricated)"},
  ]

  VALID_ROLES = USER_ROLES_AND_PERMISSIONS.map { |rp| rp[:role] }

end
