class Event < ApplicationRecord
  has_many :reservations, inverse_of: :event, dependent: :destroy
  has_many :spaces, through: :reservations, source: :space

  validates :event_name, presence: true
end
