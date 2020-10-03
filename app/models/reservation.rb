class Reservation < ApplicationRecord
  belongs_to :space
  belongs_to :event

  before_validation :create_date_times
  validates :space,      presence: true
  validates :event,      presence: true
  # simplifies user input
  validates :start_date, presence: true
  validates :end_date,   presence: true
  validates :start_time, presence: true
  validates :end_time,   presence: true
  # simplifies sorting (build in model)
  validates :start_date_time, presence: true
  validates :end_date_time,   presence: true

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
    # sd = start_date
    # st = start_time
    # self.start_date_time = DateTime.new(sd.year, sd.month, sd.day, st.hour, st.min, 0, st.zone)
    self.start_date_time = start_date.to_datetime + start_time.seconds_since_midnight.seconds

    # ed = end_date
    # et = end_time
    # self.end_date_time = DateTime.new(ed.year, ed.month, ed.day, et.hour, et.min, 0, et.zone)
    self.end_date_time = end_date.to_datetime + end_time.seconds_since_midnight.seconds
  end
end
