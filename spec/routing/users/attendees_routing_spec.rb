# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::AttendancesController, type: :routing do
  describe 'routing' do
    it 'routes to #edit' do
      expect(get: '/users/attendances?reservation_id=1&location=onsite')
        .to route_to('users/attendances#edit', reservation_id: '1', location: 'onsite')
    end
  end
end
