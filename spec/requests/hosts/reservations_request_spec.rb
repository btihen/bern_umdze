require 'rails_helper'

RSpec.describe "/hosts/reservations", type: :request do

  # resources :reservations,    only: [:edit, :update]
  # edit_hosts_reservation GET    /hosts/reservations/:id/edit(.:format)
  #      hosts_reservation PATCH  /hosts/reservations/:id(.:format)

  let(:host)     { FactoryBot.create :user, access_role: "host" }
  let(:reservation) { reservation = FactoryBot.create :reservation }
  before do
    sign_in host
  end
  after do
    sign_out host
  end

  describe "GET /hosts/reservations/:id/edit (edit)" do
    it "render a successful response" do
      get edit_hosts_reservation_path(reservation)

      expect(response).to be_successful
    end
  end

  describe "PATCH /hosts/reservations/:id (update)" do
    context "with valid parameters" do
      let(:new_attributes) {
        { host_name: "Nyima" }
      }

      it "updates the requested managers_user" do
        patch hosts_reservation_path(reservation), params: { reservation: new_attributes }
        reservation.reload
        expect(reservation.host_name).to eq new_attributes[:host_name]
      end

      it "redirects to the planners home page" do
        patch hosts_reservation_path(reservation), params: { reservation: new_attributes }
        reservation.reload
        expect(response).to redirect_to(root_path(date: reservation.start_date))
      end
    end
  end

end
