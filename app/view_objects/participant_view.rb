class ParticipantView < ViewBase

  # alias method allows use to rename view_object to a clear name without the initializer
  alias_method :participant,      :root_model

  # delegate to model for attributes needed
  delegate  :id, :fullname, :email,
            to: :participant

  def display_name
    return fullname unless fullname.blank?

    email
  end

end
