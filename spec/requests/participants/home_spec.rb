require 'rails_helper'

RSpec.describe "route '/participants/home", type: :request do

  describe "'participant' logged in" do
    let(:participant)  { FactoryBot.create :participant }
    before do
      participant_session_in(participant)
    end
    after do
      participant_session_out(participant)
    end

    scenario 'returns success for hosts homepage with the agenda' do
      get participants_home_path

      expect(response).to  have_http_status(:success)
      expect(response.body).to include("<p hidden id='participant-home-#{participant.id}' class='pageName'>Participant-#{participant.email} Home</p>")
    end
  end

  def participant_session_in(participant = nil)
    participant ||= FactoryBot.create :participant
    get "/participants/sessions/#{participant.login_token}"

    expect(response.status).to eq(302) #redirected
    expect(response).to redirect_to(participants_home_path)

    participant.reload
    expect(participant.token_valid_until).to be > DateTime.now
  end

  def participant_session_out(participant)
    expect(participant.token_valid_until).to be > DateTime.now
    delete participants_session_path(participant)

    expect(response.status).to eq(302) #redirected
    expect(response).to redirect_to(landing_path)

    participant.reload
    expect(participant.token_valid_until).to be < DateTime.now
  end

end
