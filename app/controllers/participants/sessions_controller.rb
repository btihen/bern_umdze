class Participants::SessionsController < Participants::ApplicationController
  # skip_before_action :authenticate_user!
  skip_before_action :participant_only, only: :auth

  def auth
    token = params[:token].to_s
    participant = current_participant(token)

    if participant.present?
      participant_authorize_session!(participant)
      redirect_to participants_home_path, notice: 'You have been signed in!'
    else
      flash[:alert] = 'Oops - you need a new login link'
      redirect_to new_participants_magic_link_path
    end
  end

  def destroy
    participant = current_participant(session[:login_token])
    participant.expire_token_validity!
    session[:participant] = nil
    session[:login_token] = nil
    redirect_to landing_path
  end

  private

  def participant_authorize_session!(participant)
    participant.extend_token_validity!
    session[:participant] = participant
    session[:login_token] = participant.login_token
  end

end
