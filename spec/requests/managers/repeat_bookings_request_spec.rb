# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/managers/repeat_bookings', type: :request do
  let(:manager) { FactoryBot.create :user, access_role: 'manager' }
  before do
    sign_in manager
  end
  after do
    sign_out manager
  end
  let(:bookings)        { FactoryBot.create :repeat_booking }
  let(:edit_params)     { bookings.attributes }
  let(:new_params)      { FactoryBot.attributes_for :repeat_booking }
  let(:new_attributes)  do # needed for the date/time formats
    { 'space_id' => new_params[:space].id.to_s,
      'event_id' => new_params[:event].id.to_s,
      'host_name' => new_params[:host_name].to_s,
      'is_cancelled' => new_params[:is_cancelled].to_s,
      'alert_notice' => new_params[:alert_notice].to_s,

      'start_date(1i)' => new_params[:start_date].year.to_s,
      'start_date(2i)' => new_params[:start_date].month.to_s,
      'start_date(3i)' => new_params[:start_date].day.to_s,

      'start_time(1i)' => new_params[:start_time].year.to_s,
      'start_time(2i)' => new_params[:start_time].month.to_s,
      'start_time(3i)' => new_params[:start_time].day.to_s,
      'start_time(4i)' => new_params[:start_time].hour.to_s,
      'start_time(5i)' => new_params[:start_time].min.to_s,

      'end_date(1i)' => new_params[:end_date].year.to_s,
      'end_date(2i)' => new_params[:end_date].month.to_s,
      'end_date(3i)' => new_params[:end_date].day.to_s,

      'end_time(1i)' => new_params[:end_time].year.to_s,
      'end_time(2i)' => new_params[:end_time].month.to_s,
      'end_time(3i)' => new_params[:end_time].day.to_s,
      'end_time(4i)' => new_params[:end_time].hour.to_s,
      'end_time(5i)' => new_params[:end_time].day.to_s,

      'repeat_every' => new_params[:repeat_every].to_s,
      'repeat_unit' => new_params[:repeat_unit].to_s,
      'repeat_ordinal' => new_params[:repeat_ordinal].to_s,
      'repeat_choice' => new_params[:repeat_choice].to_s,
      'repeat_until_date(1i)' => new_params[:repeat_until_date].year.to_s,
      'repeat_until_date(2i)' => new_params[:repeat_until_date].month.to_s,
      'repeat_until_date(3i)' => new_params[:repeat_until_date].day.to_s }
  end

  let(:edit_attributes) do
    { 'space_id' => edit_params[:space].id.to_s,
      'event_id' => edit_params[:event].id.to_s,
      'host_name' => edit_params[:host_name].to_s,
      'is_cancelled' => edit_params[:is_cancelled].to_s,
      'alert_notice' => edit_params[:alert_notice].to_s,

      'start_date(1i)' => edit_params[:start_date].year.to_s,
      'start_date(2i)' => edit_params[:start_date].month.to_s,
      'start_date(3i)' => edit_params[:start_date].day.to_s,

      'start_time(1i)' => edit_params[:start_time].year.to_s,
      'start_time(2i)' => edit_params[:start_time].month.to_s,
      'start_time(3i)' => edit_params[:start_time].day.to_s,
      'start_time(4i)' => edit_params[:start_time].hour.to_s,
      'start_time(5i)' => edit_params[:start_time].min.to_s,

      'end_date(1i)' => edit_params[:end_date].year.to_s,
      'end_date(2i)' => edit_params[:end_date].month.to_s,
      'end_date(3i)' => edit_params[:end_date].day.to_s,

      'end_time(1i)' => edit_params[:end_time].year.to_s,
      'end_time(2i)' => edit_params[:end_time].month.to_s,
      'end_time(3i)' => edit_params[:end_time].day.to_s,
      'end_time(4i)' => edit_params[:end_time].hour.to_s,
      'end_time(5i)' => edit_params[:end_time].day.to_s }
  end

  # "reservation"=>{"space_id"=>"1", "event_id"=>"1", "host_name"=>"", "start_date(1i)"=>"2020", "start_date(2i)"=>"10", "start_date(3i)"=>"17", "start_time(1i)"=>"2000", "start_time(2i)"=>"1", "start_time(3i)"=>"1", "start_time(4i)"=>"18", "start_time(5i)"=>"30", "end_date(1i)"=>"2020", "end_date(2i)"=>"10", "end_date(3i)"=>"19", "end_time(1i)"=>"2000", "end_time(2i)"=>"1", "end_time(3i)"=>"1", "end_time(4i)"=>"17", "end_time(5i)"=>"30", "is_cancelled"=>"0", "alert_notice"=>""}, "commit"=>"Save", "id"=>"17"}
  # User. As you add validations to Managers::User, be sure to
  # adjust the attributes here as well.

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_managers_repeat_booking_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_managers_repeat_booking_path(bookings)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates 1 new RepeatBooking' do
        expect do
          post managers_repeat_bookings_path, params: { repeat_booking: new_attributes }
        end.to change(RepeatBooking, :count).by(1)
      end
      it 'creates 1 new RepeatBooking' do
        expect do
          post managers_repeat_bookings_path, params: { repeat_booking: new_attributes }
        end.to change(Reservation, :count).by(13)
      end
      it 'after create redirect to the managers_reservations_path index' do
        post managers_repeat_bookings_path, params: { repeat_booking: new_attributes }

        expect(response).to redirect_to(managers_repeat_bookings_path)
      end
    end

    context 'with invalid parameters' do
      let(:new_params)          { FactoryBot.attributes_for :repeat_booking }
      let(:invalid_attributes)  do
        params = new_attributes
        params['event_id'] = ''
        params
      end
      it 'does not create a new Managers::User' do
        expect do
          post managers_repeat_bookings_path, params: { repeat_booking: invalid_attributes }
        end.to change(RepeatBooking, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post managers_repeat_bookings_path, params: { repeat_booking: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    let(:edit_params) { FactoryBot.attributes_for(:repeat_booking) }
    context 'with valid parameters' do
      let(:update_attributes) do
        params = edit_attributes
        params['host_name'] = 'Nyima'
        params
      end

      it 'updates the requested managers_user' do
        patch managers_repeat_booking_path(bookings), params: { repeat_booking: update_attributes }
        bookings.reload

        expect(bookings.host_name).to eq update_attributes['host_name']
      end

      it 'redirects to the managers_user index page' do
        patch managers_repeat_booking_path(bookings), params: { repeat_booking: update_attributes }
        bookings.reload

        expect(response).to redirect_to(managers_repeat_bookings_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        params = edit_attributes
        params['event_id'] = ''
        params
      end
      it "renders a successful response (i.e. to display the 'edit' template)" do
        # try to reuse user_2 data for user_1 (invalid)
        patch managers_repeat_booking_path(bookings), params: { repeat_booking: invalid_attributes }

        expect(response).to be_successful
        # back to the edit page (until good params are sent)
        expect(response.body).to include "<p hidden id='manager-edit-repeat-booking-#{bookings.id}' class='pageName'>Manager Edit Repeat Booking #{bookings.id}</p>"
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested managers_user' do
      expect do
        post managers_repeat_bookings_path, params: { repeat_booking: new_attributes }
      end.to change(RepeatBooking, :count).by(1)
      expect(RepeatBooking.count).to eq 1
      expect(Reservation.count).to   eq 13
      repeater = RepeatBooking.last
      expect do
        delete managers_repeat_booking_path(repeater)
      end.to change(RepeatBooking, :count).by(-1)
      expect(RepeatBooking.count).to eq 0
      expect(Reservation.count).to   eq 0
    end

    it 'redirects to the managers_users list' do
      expect(bookings).to be
      delete managers_repeat_booking_path(bookings)

      expect(response).to redirect_to(managers_repeat_bookings_path)
    end
  end
end
