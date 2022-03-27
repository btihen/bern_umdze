# frozen_string_literal: true

# https://railsapps.github.io/rails-authorization.html
module Participants
  class ApplicationController < ApplicationController
    before_action :participant_only

    # find valid participants
    def current_participant(login_token = session[:login_token])
      participant = GlobalID::Locator.locate_signed(login_token, for: 'access')
      return participant if participant.is_a?(Participant)

      Participant.where(login_token:)
                 .where('participants.token_valid_until > ?', DateTime.now)
                 .first
    end

    private

    def participant_only
      participant = current_participant(session[:login_token])

      # one if is required to avoid ensure we only render ONCE!
      if participant.blank?
        redirect_back fallback_location: new_participants_magic_link_path, alert: 'New Access-Link Necessary'

      # force new participants to give us their name
      elsif participant.fullname.blank? && !request.url.include?('participants/profiles')
        flash[:notice] = 'Please tell us your name.'
        redirect_to edit_participants_profile_path(participant)
      end
    end
  end
end
