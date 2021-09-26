# frozen_string_literal: true

class AttendanceError < StandardError; end

class AttendanceCommand

  # helpful for debugging
  attr_reader :location, :attendance, :reservation

  def initialize(attendance_info)
    @location    = attendance_info[:location]
    @attendance  = attendance_info[:attendance]
    @reservation = attendance_info[:reservation]
  end

  def self.call(attendance_info)
    new(attendance_info).run
  end

  # try to save the attendance
  # return truthy (flash message) or falsey value (nil)
  def run
    if delete? && @attendance.destroy
      notice_msg

    # no limit to remote participants
    elsif remote? && @attendance.valid? && @attendance.save
      notice_msg

    # user shouldn't see the 'onsite' button when full
    elsif onsite? && @attendance.valid? && onsite_limit_ok? && @attendance.save
      notice_msg
    end
  end

  private

    def notice_msg
      {notice: "#{location.capitalize} attendance for #{event_display}."}
    end

    def alert_msg
      {alert: "OOPS - unexpected error for event #{event_display}"}
    end

    def event_display
      "#{reservation.event.event_name} on #{reservation.start_date}"
    end

    def delete?
      location.eql?('delete')
    end

    def onsite?
      location.eql?('onsite')
    end

    def remote?
      location.eql?('remote')
    end

    def onsite_limit_ok?
      reservation.onsite_space_available?
    end
end
