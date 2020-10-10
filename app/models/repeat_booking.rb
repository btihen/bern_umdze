class RepeatBooking < ApplicationRecord

  has_many  :reservations, inverse_of: :repeat_config, dependent: :destroy

  validates :settings,     presence: true

end
