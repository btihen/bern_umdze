class TokensController < ApplicationController

  def new
    participant = Participant.new
    render :new, locals: {participant: participant}
  end

  def create
    email = get_params[:email]
    person = User.find_by(email: email) || Participant.find_by(email: email) || Participant.new(email: email)

    if person.is_a?(User) || (person.is_a?(Participant) && person.valid? && person.save)
      auth_sgid = person.to_sgid(expires_in: 1.hour, for: 'access')
      auth_token = auth_sgid.to_s
      auth_url = Rails.application.routes.url_helpers
                      .auth_tokens_url(auth: auth_token)
      SendLinkMailer.magic_link(person, auth_url).deliver_later
    end
    # always respond the same to avoid email mining
    redirect_to landing_path, notice: "Access-Link auf #{email} würde geschickt."
  end

  def auth
    sgid_token = params[:auth].to_s
    person = GlobalID::Locator.locate_signed(sgid_token, for: 'access')

    case person
    when User
      sign_in(person)
      flash[:notice] = "Wilkommen #{person.email}"
      redirect_to root_path
    when Participant
      session[:participant] = person
      session[:login_token] = sgid_token
      flash[:notice] = "Wilkommen #{person.email}"
      redirect_to participants_home_path
    else
      flash[:alert] = 'Oops - unbekannte Fehler'
      redirect_to root_path
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def get_params
      params.require(:participant).permit(:email)
    end

end
