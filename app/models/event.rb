# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :reservations,    inverse_of: :event, dependent: :destroy
  has_many :spaces,          through: :reservations, source: :space

  has_many :repeat_bookings, inverse_of: :event, dependent: :destroy

  validates :event_name, presence: true
end
