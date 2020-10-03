class Space < ApplicationRecord
  has_many :reservations, inverse_of: :space, dependent: :destroy
  has_many :events, through: :reservations, source: :event

  validates :space_name, presence: true
end
