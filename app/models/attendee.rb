class Attendee < ApplicationRecord
  belongs_to :reservation

  # must have either user or participant
  belongs_to :user, optional: true
  belongs_to :participant, optional: true

  validates :location, presence: true
  validate :valid_attendee

  private
    def valid_attendee
    end
end
