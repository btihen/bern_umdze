class Participants::MagicLinksController < Participants::ApplicationController
  # skip_before_action :authenticate_user!
  skip_before_action :participant_only

  def new
    participant = Participant.new
    render :new, locals: {participant: participant}
  end

  def create
    email = participant_params[:email]
    ip_address = request.remote_ip
    # the participant might already exist in our db or possibly a new participant
    participant = Participant.find_by(email: email) || Participant.new(email: email)
    participant.magic_link_data(ip_address)

    if participant.valid?
      participant.save
      magic_link_url = participants_session_auth_url(token: participant.login_token)
      SendLinkMailer.magic_link(participant, magic_link_url).deliver_later

      redirect_to landing_path, notice: "Access-Link an email #{participant.email} wird geschickt."

    else # email invalid oder IP created too many different requests
      flash[:alert] =  "OOPS - there was a problem."
      render :new, locals: {participant: participant}
    end

  end

  private

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:email)
    end
end
