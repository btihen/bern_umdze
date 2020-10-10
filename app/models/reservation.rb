class Reservation < ApplicationRecord

  belongs_to :space
  belongs_to :event
  # had to update migration to allow null!
  belongs_to :repeat_booking, optional: true

  accepts_nested_attributes_for :space
  accepts_nested_attributes_for :event
  accepts_nested_attributes_for :repeat_booking

  before_validation :create_date_times

  validates :space,           presence: true
  validates :event,           presence: true
  # simplifies user input
  validates :start_date,      presence: true
  validates :end_date,        presence: true
  validates :start_time,      presence: true
  validates :end_time,        presence: true
  # simplifies sorting (build in model)
  validates :start_date_time, presence: true
  validates :end_date_time,   presence: true

  validate  :validate_start_date_time_before_end_date_time

  scope :in_date_range, ->(date_range) {
                          includes(:event, :space)
                          .where("start_date >= ?", date_range.first)
                          .where("end_date <= ?", date_range.last)
                        }
  scope :space_next,  ->(space_ids, date_time) {
                          where(space_id: space_ids)
                          .where("start_date_time > ?", date_time)
                          .limit(1)
                        }
  private

  # https://stackoverflow.com/questions/12181444/ruby-combine-date-and-time-objects-into-a-datetime
  def create_date_times
    self.start_date_time = start_date.to_datetime + start_time.seconds_since_midnight.seconds
    self.end_date_time = end_date.to_datetime + end_time.seconds_since_midnight.seconds
  end

  def validate_start_date_time_before_end_date_time
    return if start_date_time < end_date_time

    if start_date > end_date
      errors.add(:start_date, "must be before end-date")
    end
    if start_date == end_date && start_time > end_time
      errors.add(:start_time, "must be before end-time")
    end
  end

end
