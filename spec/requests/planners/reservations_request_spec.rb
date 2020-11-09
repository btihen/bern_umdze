require 'rails_helper'

RSpec.describe "/planners/reservations", type: :request do

  # only: [:edit, :update, :new, :create, :destroy]
  #     planners_reservations  POST   /planners/reservations(.:format)
  #   new_planners_reservation GET    /planners/reservations/new(.:format)
  # edit_planners_reservation  GET    /planners/reservations/:id/edit(.:format)
  #       planners_reservation PATCH  /planners/reservations/:id(.:format)
  #                            PUT    /planners/reservations/:id(.:format)
  #                            DELETE /planners/reservations/:id(.:format)

  let(:planner)  { FactoryBot.create :user, access_role: "planner" }
  before do
    sign_in planner
  end
  after do
    sign_out planner
  end

  let(:valid_attributes) {
    event  = FactoryBot.create :event
    space  = FactoryBot.create :space
    params = FactoryBot.attributes_for(:reservation).transform_values { |v| v.nil? ? "" : v }
    params[:event_id] = event.id
    params[:space_id] = space.id
    params.except(:repeat_booking)
  }

  let(:invalid_attributes) {
    params = valid_attributes
    params[:start_date] = "2020-02-02"
    params[:end_date] = "1920-01-01"
    params
  }

  describe "GET /planners/reservations/new (new)" do
    it "renders a successful response" do
      FactoryBot.create :event
      FactoryBot.create :space
      get new_planners_reservation_path

      expect(response).to be_successful
    end
  end

  describe "GET /planners/reservations/:id/edit (edit)" do
    it "render a successful response" do
      reservation = Reservation.create! valid_attributes
      get edit_planners_reservation_path(reservation)

      expect(response).to be_successful
    end
  end

  describe "POST /planners/reservations (create)" do
    context "with valid parameters" do
      it "creates a new Reservation" do
        expect {
          post planners_reservations_path, params: { reservation: valid_attributes }
        }.to change(Reservation, :count).by(1)
      end

      it "redirects to the home agenda page" do
        post planners_reservations_path, params: { reservation: valid_attributes }
        expect(response).to redirect_to(root_path(date: Date.today.to_s))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Reservation" do
        expect {
          post planners_reservations_path, params: { reservation: invalid_attributes }
        }.to change(Reservation, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post planners_reservations_path, params: { reservation: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /planners/reservations/:id (update)" do
    context "with valid parameters" do
      let(:new_attributes) {
        { start_date: "2021-02-02", end_date: "2021-02-02" }
      }

      it "updates the requested managers_user" do
        reservation = Reservation.create! valid_attributes
        patch planners_reservation_path(reservation), params: { reservation: new_attributes }
        reservation.reload

        expect(reservation.start_date).to eq Date.parse(new_attributes[:start_date])
        expect(reservation.end_date).to   eq Date.parse(new_attributes[:end_date])
      end

      it "redirects to the planners home page" do
        reservation = Reservation.create! valid_attributes
        patch planners_reservation_path(reservation), params: { reservation: new_attributes }
        reservation.reload
        expect(response).to redirect_to(root_path(date: new_attributes[:start_date]))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        reservation = Reservation.create! valid_attributes
        patch planners_reservation_path(reservation), params: { reservation: invalid_attributes }

        expect(response).to be_successful
        # back to the edit page (until good params are sent)
        expect(response.body).to include "<p hidden id='planner-edit-resevation-#{reservation.id}' class='pageName'>Planner Edit Reservation #{reservation.id}</p>"
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested managers_user" do
      reservation = Reservation.create! valid_attributes
      expect {
        delete planners_reservation_path(reservation)
      }.to change(Reservation, :count).by(-1)
    end

    it "redirects to the planners agenda (home page)" do
      reservation = Reservation.create! valid_attributes
      delete planners_reservation_path(reservation)
      expect(response).to redirect_to(root_path(date: Date.today.to_s))
    end
  end
end
