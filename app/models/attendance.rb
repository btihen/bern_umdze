class Attendance < ApplicationRecord
  belongs_to :reservation

  # must have either user or participant as attendable
  belongs_to :user, optional: true
  belongs_to :participant, optional: true

  validates :reservation, presence: true
  validates :location,    presence: true,
                          inclusion: { in: ApplicationHelper::LOCATIONS }
  validate :valid_attendance

  def attendable
    user || participant
  end

  def display_name
    case attendable
    when User
      user.full_name || attendable.email
    when Participant
      participant.fullname
    end
  end

  private

  # exclusive or (XOR) is true if one or the other is true, but not both
  def valid_attendance
    return if (user_id.present? ^ participant_id.present?) || # saved, will have an id stored
              (user.present? ^ participant.present?)          # unsaved, will have a model, but no id

    # add to base since, some forms may not have the person/business fields
    errors.add :base, 'must be associated with a user or participant'
  end
end
