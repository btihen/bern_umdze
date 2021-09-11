# https://railsapps.github.io/rails-authorization.html
class Participants::ApplicationController < ApplicationController
  # skip_before_action :authenticate_user!
  # skip_before_action :configure_permitted_parameters
  before_action :participant_only

  # find valid participants
  def current_participant(login_token = session[:login_token])
    Participant.where(login_token: login_token)
               .where('participants.token_valid_until > ?', DateTime.now)
               .first
  end

  private

  def participant_only
    participant = current_participant(session[:login_token])

    # one if is required to avoid ensure we only render ONCE!
    if participant.blank?
      redirect_back fallback_location: new_participants_magic_link_path, :alert => "New Access-Link Necessary"

    # force user to give us their name
    # (do not re-reoute if they already going to 'participants/profiles' - to avoid an endless loop)
    elsif participant.fullname.blank? && !request.url.include?('participants/profiles')
      flash[:notice] = 'Please tell us your name.'
      redirect_to edit_participants_profile_path(participant)
    end
  end

end
