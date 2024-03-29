# frozen_string_literal: true

class RepeatBooking < ApplicationRecord
  belongs_to :event
  belongs_to :space

  has_many   :reservations, inverse_of: :repeat_booking, dependent: :destroy

  # specific to repeat_booking
  validates  :repeat_every,      presence: true, inclusion: { in: ApplicationHelper::VALID_REPEAT_EVERY }
  validates  :repeat_unit,       presence: true, inclusion: { in: ApplicationHelper::VALID_REPEAT_UNITS }
  validates  :repeat_ordinal,    inclusion: { in: ApplicationHelper::VALID_REPEAT_ORDINALS }, allow_blank: true
  validates  :repeat_choice,     inclusion: { in: ApplicationHelper::VALID_REPEAT_CHOICES },  allow_blank: true
  validates  :repeat_until_date, presence: true

  # same as for reservation (template info)
  before_validation :create_date_times

  # simplifies user input (maybe remove?)
  validates :start_date,      presence: true
  validates :start_time,      presence: true
  validates :end_date,        presence: true
  validates :end_time,        presence: true
  # simplifies sorting (build in model)
  validates :start_date_time, presence: true
  validates :end_date_time,   presence: true

  validate  :validate_start_date_time_before_end_date_time
  validate  :validate_start_date_time_before_repeat_until_date
  validate  :validate_repeat_input_combinations

  def start_end_time_delta
    end_date_time - start_date_time
  end

  private

  # https://stackoverflow.com/questions/12181444/ruby-combine-date-and-time-objects-into-a-datetime
  def create_date_times
    return if start_date.blank? || start_time.blank? || end_date.blank? || end_time.blank?

    unless start_date_time.is_a? DateTime
      self.start_date_time = start_date.to_datetime + start_time.seconds_since_midnight.seconds
    end
    unless end_date_time.is_a? DateTime
      self.end_date_time = end_date.to_datetime + end_time.seconds_since_midnight.seconds
    end
  end

  def validate_start_date_time_before_end_date_time
    return  if start_date_time.blank? || end_date_time.blank?
    return  if start_date.blank? || start_time.blank? || end_date.blank? || end_time.blank?
    return  if start_date_time < end_date_time

    errors.add(:start_date, 'must be before end-date') if start_date > end_date
    errors.add(:start_time, 'must be before end-time') if start_date == end_date && start_time > end_time
  end

  def validate_start_date_time_before_repeat_until_date
    return  if start_date.blank? || repeat_until_date.blank?
    return  if start_date < repeat_until_date

    errors.add(:repeat_until_date, 'must be after start_date') if start_date > repeat_until_date
  end

  def validate_repeat_input_combinations
    # validate only unit 'year & month' are allowed to use 'this' 'date'
    return if %w[year month].include?(repeat_unit) && repeat_ordinal.eql?('this') && repeat_choice.eql?('date')

    if repeat_ordinal.eql?('this')
      errors.add(:repeat_ordinal, "'this' must be used with unit-'year or month' and choice-'date'")
    end
    if repeat_choice.eql?('date')
      errors.add(:repeat_choice, "'date' must be used with unit-'year or month' and ordinal-'this'")
    end
    if %w[year month].include?(repeat_unit) && (repeat_ordinal.blank? || repeat_choice.blank?)
      errors.add(:repeat_ordinal, "'year & month' require and 'ordinal'")
      errors.add(:repeat_choice, "'year & month' require and 'choice'")
    end

    # validate usage of unit-week
    return if repeat_unit.eql?('week') && repeat_ordinal.blank? && %w[mon tue wed thu fri sat
                                                                      sun].include?(repeat_choice)

    if repeat_unit.eql?('week') && !repeat_ordinal.blank?
      errors.add(:repeat_unit, "'week' cannot be paired with an ordinal")
    end
    if repeat_unit.eql?('week') && ['', 'date'].include?(repeat_choice)
      errors.add(:repeat_unit, "'week' must be paired with a weekday choice")
    end

    # validate usage of unit-day
    return if repeat_unit.eql?('day') && repeat_ordinal.blank? && repeat_choice.blank?

    errors.add(:repeat_unit, "'day' can only be paired with the 'frequency' (every)") if repeat_unit.eql?('day')
  end
end
