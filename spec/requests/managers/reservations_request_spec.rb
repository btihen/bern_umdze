require 'rails_helper'

RSpec.describe "/managers/reservations", type: :request do

  #     managers_reservations POST   /managers/reservations(.:format)
  #  new_managers_reservation GET    /managers/reservations/new(.:format)
  # edit_managers_reservation GET    /managers/reservations/:id/edit(.:format)
  #      managers_reservation PATCH  /managers/reservations/:id(.:format)
  #                           PUT    /managers/reservations/:id(.:format)
  #                           DELETE /managers/reservations/:id(.:format)
  # let(:recurring_reservation) { FactoryBot.create :reservation }
  let(:reservation) { FactoryBot.create :reservation }
  let(:manager)     { FactoryBot.create :user, access_role: "manager" }
  before do
    sign_in manager
  end
  after do
    sign_out manager
  end

  # "reservation"=>{"space_id"=>"1", "event_id"=>"1", "host_name"=>"", "start_date(1i)"=>"2020", "start_date(2i)"=>"10", "start_date(3i)"=>"17", "start_time(1i)"=>"2000", "start_time(2i)"=>"1", "start_time(3i)"=>"1", "start_time(4i)"=>"18", "start_time(5i)"=>"30", "end_date(1i)"=>"2020", "end_date(2i)"=>"10", "end_date(3i)"=>"19", "end_time(1i)"=>"2000", "end_time(2i)"=>"1", "end_time(3i)"=>"1", "end_time(4i)"=>"17", "end_time(5i)"=>"30", "is_cancelled"=>"0", "alert_notice"=>""}, "commit"=>"Save", "id"=>"17"}
  # User. As you add validations to Managers::User, be sure to
  # adjust the attributes here as well.


  describe "GET /new" do
    it "renders a successful response" do
      get new_managers_reservation_path
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_managers_reservation_path(reservation)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    let(:new_attributes)  {
      { "space_id"       => "#{new_params[:space].id}",
        "event_id"       => "#{new_params[:event].id}",
        "host_name"      => "#{new_params[:host_name]}",
        "is_cancelled"   => "#{new_params[:is_cancelled]}",
        "alert_notice"   => "#{new_params[:alert_notice]}",

        "start_date(1i)" => "#{new_params[:start_date].year}",
        "start_date(2i)" => "#{new_params[:start_date].month}",
        "start_date(3i)" => "#{new_params[:start_date].day}",

        "start_time(1i)" => "#{new_params[:start_time].year}",
        "start_time(2i)" => "#{new_params[:start_time].month}",
        "start_time(3i)" => "#{new_params[:start_time].day}",
        "start_time(4i)" => "#{new_params[:start_time].hour}",
        "start_time(5i)" => "#{new_params[:start_time].min}",

        "end_date(1i)"   => "#{new_params[:end_date].year}",
        "end_date(2i)"   => "#{new_params[:end_date].month}",
        "end_date(3i)"   => "#{new_params[:end_date].day}",

        "end_time(1i)"   => "#{new_params[:end_time].year}",
        "end_time(2i)"   => "#{new_params[:end_time].month}",
        "end_time(3i)"   => "#{new_params[:end_time].day}",
        "end_time(4i)"   => "#{new_params[:end_time].hour}",
        "end_time(5i)"   => "#{new_params[:end_time].day}",

        "repeat_every"   => "#{new_params[:repeat_every]}",
        "repeat_unit"    => "#{new_params[:repeat_unit]}",
        "repeat_ordinal" => "#{new_params[:repeat_ordinal]}",
        "repeat_choice"  => "#{new_params[:repeat_choice]}",
        "repeat_until_date(1i)" => "#{new_params[:repeat_until_date].year}",
        "repeat_until_date(2i)" => "#{new_params[:repeat_until_date].month}",
        "repeat_until_date(3i)" => "#{new_params[:repeat_until_date].day}",
      }
    }
    context "with valid parameters - no repeats" do
      let(:new_params)      { FactoryBot.attributes_for :repeat_booking,
                                                        repeat_every: '0' }
      it "creates 1 new Reservation" do
        expect {
          post managers_reservations_path, params: { reservation: new_attributes }
        }.to change(Reservation, :count).by(1)
      end
      it "creates 1 new Reservation and redirects to the managers root_path" do
        post managers_reservations_path, params: { reservation: new_attributes }

        expect(response).to redirect_to(root_path(date: new_params[:start_date].to_s))
      end
    end
    context "with valid parameters - with repeats" do
      # let(:new_params)      { FactoryBot.attributes_for :repeat_booking,
      #                                                   repeat_every: '1' }
      let(:new_params)      { FactoryBot.attributes_for(:repeat_booking,
                                                        start_date: Date.parse('2021-01-06'),
                                                        end_date: Date.parse('2021-01-06'),
                                                        repeat_every: '1',
                                                        repeat_unit: 'month',
                                                        repeat_ordinal: 'first',
                                                        repeat_choice: 'wed',
                                                        repeat_until_date: Date.parse('2021-12-30')
                                                      )
                            }
      it "creates a new repeating reservation - the first reseration matches the pattern" do
        # new_attributes[:start_date] = '2021-01-06'
        expect {
          post managers_reservations_path, params: { reservation: new_attributes }
        }.to change(Reservation, :count).by(12)
      end
      it "creates a new repeating reservation - the first reseration is before the pattern and thus gets a reservation too" do
        new_params[:start_date] = Date.parse('2021-01-01')
        new_params[:end_date] = Date.parse('2021-01-01')
        expect {
          post managers_reservations_path, params: { reservation: new_attributes }
        }.to change(Reservation, :count).by(13)
      end
      it "creates repeat Reservations and redirects to the managers root_path" do
        post managers_reservations_path, params: { reservation: new_attributes }
        expect(response).to redirect_to(root_path(date: new_params[:start_date].to_s))
      end
    end

    context "with invalid parameters" do
      let(:new_params)          { FactoryBot.attributes_for :repeat_booking }
      let(:invalid_attributes)  {
        params = new_attributes
        params[:event_id] = ""
        params
      }
      it "does not create a new Managers::User" do
        expect {
          post managers_reservations_path, params: { reservation: invalid_attributes }
        }.to change(Reservation, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post managers_reservations_path, params: { reservation: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    let(:edit_params)     { FactoryBot.attributes_for(:reservation) }
    let(:edit_attributes) {
      { "space_id"=>"#{edit_params[:space].id}",
        "event_id"=>"#{edit_params[:event].id}",
        "host_name"=>"#{edit_params[:host_name]}",
        "is_cancelled"=>"#{edit_params[:is_cancelled]}",
        "alert_notice"=>"#{edit_params[:alert_notice]}",

        "start_date(1i)"=>"#{edit_params[:start_date].year}",
        "start_date(2i)"=>"#{edit_params[:start_date].month}",
        "start_date(3i)"=>"#{edit_params[:start_date].day}",

        "start_time(1i)"=>"#{edit_params[:start_time].year}",
        "start_time(2i)"=>"#{edit_params[:start_time].month}",
        "start_time(3i)"=>"#{edit_params[:start_time].day}",
        "start_time(4i)"=>"#{edit_params[:start_time].hour}",
        "start_time(5i)"=>"#{edit_params[:start_time].min}",

        "end_date(1i)"=>"#{edit_params[:end_date].year}",
        "end_date(2i)"=>"#{edit_params[:end_date].month}",
        "end_date(3i)"=>"#{edit_params[:end_date].day}",

        "end_time(1i)"=>"#{edit_params[:end_time].year}",
        "end_time(2i)"=>"#{edit_params[:end_time].month}",
        "end_time(3i)"=>"#{edit_params[:end_time].day}",
        "end_time(4i)"=>"#{edit_params[:end_time].hour}",
        "end_time(5i)"=>"#{edit_params[:end_time].day}",
      }
    }
    context "with valid parameters" do
      let(:update_attributes) {
        params = edit_attributes
        params[:host_name] = "Nyima"
        params
      }

      it "updates the requested managers_user" do
        patch managers_reservation_path(reservation), params: { reservation: update_attributes }
        reservation.reload

        expect(reservation.host_name).to eq update_attributes[:host_name]
      end

      it "redirects to the managers_user index page" do
        patch managers_reservation_path(reservation), params: { reservation: update_attributes }
        reservation.reload

        expect(response).to redirect_to(root_path(date: edit_params[:start_date].to_s))
      end
    end

    context "with invalid parameters" do

      let(:invalid_attributes) {
        params = edit_attributes
        params[:event_id] = ""
        params
      }
      it "renders a successful response (i.e. to display the 'edit' template)" do

        # try to reuse user_2 data for user_1 (invalid)
        patch managers_reservation_path(reservation), params: { reservation: invalid_attributes }

        expect(response).to be_successful
        # back to the edit page (until good params are sent)
        expect(response.body).to include "<p hidden id='manager-edit-resevation-#{reservation.id}' class='pageName'>Manager Edit Reservation #{reservation.id}</p>"
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested managers_user" do
      expect(reservation).to be

      expect {
        delete managers_reservation_path(reservation)
      }.to change(Reservation, :count).by(-1)
    end

    it "redirects to the managers_users list" do
      expect(reservation).to be
      delete managers_reservation_path(reservation)

      expect(response).to redirect_to(root_path(date: Date.today.to_s))
    end
  end
end
