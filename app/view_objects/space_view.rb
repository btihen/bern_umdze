class SpaceView < ViewBase

  # alias method allows use to rename view_object to a clear name without the initializer
  alias_method :space,      :root_model
  # not valid with nested urls
  # alias_method :space_url,  :root_model_url
  # alias_method :space_path, :root_model_path

  # delegate to model for attributes needed
  delegate  :id, :onsite_limit, :space_name, :time_zone, to: :space

  def events
    EventView.collection(space.events)
  end

  def reservations(date_range=nil)
    return ReservationView.collection(space.reservations) if date_range.nil?

    ReservationView.collection( space.reservations.in_date_range(date_range) )
  end

  # avoid possible nils
  def space_location
    space.space_location.to_s
  end

end
