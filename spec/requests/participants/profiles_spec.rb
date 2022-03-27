# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Participants::Profiles', type: :request do
  describe 'GET /edit' do
    let(:participant) { FactoryBot.create :participant }

    it 'returns a redirect without a valid session' do
      get '/participants/profiles/1/edit'

      expect(response.status).to eq(302) # redirected
      expect(response).to redirect_to(new_participants_magic_link_path)
    end

    it 'success auf participant profile with a valid token' do
      get "/participants/sessions/#{participant.login_token}"
      expect(response.status).to eq(302) # redirected
      expect(response).to redirect_to(participants_home_path)

      # get "/participants/profiles/#{participant.id}/edit"
      get edit_participants_profile_path(participant)
      expect(response).to have_http_status(:success)
      expect(response.body).to include "<p hidden id='participant-profile-edit-#{participant.id}' class='pageName'>Update Profile for #{participant.email}</p>"
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:participant)     { FactoryBot.create :participant, fullname: '' }
      let(:new_attributes)  { { fullname: 'Nyima' } }

      it 'update the participant name with a new name' do
        get "/participants/sessions/#{participant.login_token}"
        expect(response.status).to eq(302) # redirected
        expect(response).to redirect_to(participants_home_path)

        follow_redirect! # ensure that the central controller redirects to profile
        expect(response).to redirect_to(edit_participants_profile_path(participant))

        # get "/participants/profiles/#{participant.id}/edit"
        patch participants_profile_path(participant, participant: new_attributes)
        expect(response.status).to eq(302) # redirected
        expect(response).to redirect_to(participants_home_path)

        participant.reload
        expect(participant.fullname).to eq new_attributes[:fullname]
      end

      it 'redirects to profile page if empty name is entered' do
        new_attributes[:fullname] = ''
        get "/participants/sessions/#{participant.login_token}"
        expect(response.status).to eq(302) # redirected
        expect(response).to redirect_to(participants_home_path)

        follow_redirect! # ensure that the central controller redirects to profile
        expect(response).to redirect_to(edit_participants_profile_path(participant))

        # get "/participants/profiles/#{participant.id}/edit"
        patch participants_profile_path(participant, participant: new_attributes)
        expect(response).to have_http_status(:success)
        expect(response.body).to include "<p hidden id='participant-profile-edit-#{participant.id}' class='pageName'>Update Profile for #{participant.email}</p>"

        participant.reload
        expect(participant.fullname).to eq new_attributes[:fullname]
      end
    end
  end

  describe 'DESTROY /participants/profile/:id' do
    xit 'particpant logout' do
    end
  end
end
