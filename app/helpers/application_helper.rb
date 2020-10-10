module ApplicationHelper

  FREQUENCY_UNITS = [
    # {value: "year",    display_name: "Year"},
    {value: "month",   display_name: "Month"},
    # {value: "week",    display_name: "Week"},
    # {value: "day",     display_name: "Day"},
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

  FREQUENCY_DAYS = [
    {value: "mon",     display_name: "Monday"},
    {value: "tue",     display_name: "Tuesday"},
    {value: "wed",     display_name: "Wednesday"},
    {value: "thu",     display_name: "Thursday"},
    {value: "fri",     display_name: "Friday"},
    {value: "sat",     display_name: "Saturday"},
    {value: "sun",     display_name: "Sunday"},
    {value: "date",    display_name: "Date"},
    {value: "day",     display_name: "Day"},
  ]
  VALID_FREQUENCY_DAYS = FREQUENCY_DAYS.map { |f| f[:value] }

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
