class Participants::MagicLinksController < Participants::ApplicationController
  # skip_before_action :authenticate_user!
  skip_before_action :participant_only

  def new
    participant = Participant.new
    render :new, locals: {participant: participant}
  end

  def create
    participant = get_or_new_participant
    magic_params = magic_link_data(request.remote_ip)
    participant.assign_attributes(magic_params)

    if participant.valid? && participant.save
      magic_link_url = participants_session_auth_url(token: participant.login_token)

      SendLinkMailer.magic_link(participant, magic_link_url).deliver_later

      redirect_to landing_path, notice: "Access-Link an email #{participant.email} wird geschickt."

    else # email invalid oder IP created too many different requests
      flash[:alert] =  "OOPS - there was a problem."
      render :new, locals: {participant: participant}
    end

  end

  private

    # the participant might already exist in our db or possibly a new participant
    def get_or_new_participant
      email = participant_params[:email]
      Participant.find_by(email: email) || Participant.new(email: email)
    end

    def magic_link_data(ip_address, valid_minutes = 60)
      {
        ip_addr: ip_address,
        login_token: SecureRandom.hex(25),
        token_valid_until: DateTime.now + (valid_minutes.to_i).minutes,
      }
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:email)
    end
end
