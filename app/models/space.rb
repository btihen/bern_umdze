# frozen_string_literal: true

class Space < ApplicationRecord
  has_many :reservations,     inverse_of: :space, dependent: :destroy
  has_many :events,           through: :reservations, source: :event

  has_many :repeat_bookings,  inverse_of: :space, dependent: :destroy

  validates :space_name,      presence: true
  validates :onsite_limit, presence: true,
                           numericality: { only_integer: true,
                                           greater_than_or_equal_to: 0 }
end
