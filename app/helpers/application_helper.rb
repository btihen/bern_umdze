module ApplicationHelper

  FREQUENCY_UNITS = [
    # {value: "yearly",  display_name: "Yearly"},
    {value: "monthly", display_name: "Monthly"},
    # {value: "weekly",  display_name: "Weekly"},
    # {value: "daily",   display_name: "Daily"},
  ]
  VALID_FREQUENCY_UNITS = FREQUENCY_UNITS.map { |f| f[:value] }

  FREQUENCY_ORDINALS = [
    {value: "first",   display_name: "First"},
    {value: "second",  display_name: "Second"},
    {value: "third",   display_name: "Third"},
    {value: "fourth",  display_name: "Fourth"},
    {value: "fifth",   display_name: "Fifth"},
    {value: "last",    display_name: "Last"},
  ]
  VALID_FREQUENCY_WEEK_ORDINALS = FREQUENCY_ORDINALS.map { |f| f[:value] }

  FREQUENCY_WEEKDAYS = [
    {value: "mon",     display_name: "on Mondays"},
    {value: "tue",     display_name: "on Tuesdays"},
    {value: "wed",     display_name: "on Wednesdays"},
    {value: "thu",     display_name: "on Thursdays"},
    {value: "fri",     display_name: "on Fridays"},
    {value: "sat",     display_name: "on Saturdays"},
    {value: "sun",     display_name: "on Sundays"},
  ]
  VALID_FREQUENCY_WEEKDAYS = FREQUENCY_WEEKDAYS.map { |f| f[:value] }

  USER_ROLES_AND_PERMISSIONS = [
    {role: "manager",  permissions: "Full Manager Access"},
    {role: "planner",  permissions: "Create/Edit Bookings"},
    {role: "host",     permissions: "Update Coordinators"},
    {role: "viewer",   permissions: "View Calendar Plan"},
    # {role: "umdze",   permissions: "Update (Depricated)"},
    # {role: "trustee", permissions: "Full access (Depricated)"},
    # {role: "member",  permissions: "Read only (Depricated)"},
  ]
  VALID_ROLES = USER_ROLES_AND_PERMISSIONS.map { |r| r[:role] }

end
