# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participants::SessionsController, type: :routing do
  describe 'routing' do
    it 'routes to #auth' do
      expect(get: '/participants/sessions/1234567890').to route_to('participants/sessions#auth', token: '1234567890')
    end

    it 'routes to #destroy' do
      expect(delete: '/participants/sessions/1').to route_to('participants/sessions#destroy', id: '1')
    end
  end
end
