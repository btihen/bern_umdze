class RepeatBooking < ApplicationRecord

  belongs_to :event
  belongs_to :space

  has_many   :reservations, inverse_of: :repeat_booking, dependent: :destroy

  validates  :repeat_every,      presence: true, inclusion: { in: ApplicationHelper::VALID_REPEAT_EVERY }
  validates  :repeat_unit,       presence: true, inclusion: { in: ApplicationHelper::VALID_REPEAT_UNITS }
  validates  :repeat_ordinal,    presence: true, inclusion: { in: ApplicationHelper::VALID_REPEAT_ORDINALS }
  validates  :repeat_choice,     presence: true, inclusion: { in: ApplicationHelper::VALID_REPEAT_CHOICES }
  validates  :repeat_until_date, presence: true

end
