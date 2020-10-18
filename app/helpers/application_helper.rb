module ApplicationHelper

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

  VALID_REPEAT_EVERY = (1..12).to_a

  REPEAT_UNITS = [
    {value: "year",    display_name: "Year"},
    {value: "month",   display_name: "Month"},
    {value: "week",    display_name: "Week"},
    {value: "day",     display_name: "Day"},
  ]
  VALID_REPEAT_UNITS = REPEAT_UNITS.map { |f| f[:value] }

  REPEAT_ORDINALS = [
    {value: "first",   display_name: "First"},
    {value: "second",  display_name: "Second"},
    {value: "third",   display_name: "Third"},
    {value: "fourth",  display_name: "Fourth"},
    # {value: "fifth",   display_name: "Fifth"},
    # {value: "last",    display_name: "Last"},
    {value: "this",    display_name: "This (date)"},
  ]
  VALID_REPEAT_ORDINALS = REPEAT_ORDINALS.map { |f| f[:value] }

  REPEAT_CHOICES = [
    {value: "mon",     display_name: "Monday"},
    {value: "tue",     display_name: "Tuesday"},
    {value: "wed",     display_name: "Wednesday"},
    {value: "thu",     display_name: "Thursday"},
    {value: "fri",     display_name: "Friday"},
    {value: "sat",     display_name: "Saturday"},
    {value: "sun",     display_name: "Sunday"},
    # {value: "day",     display_name: "Day"},   # for 'first/last' day of 'month/year'
    {value: "date",    display_name: "Date"},
  ]
  VALID_REPEAT_CHOICES = REPEAT_CHOICES.map { |f| f[:value] }

end
