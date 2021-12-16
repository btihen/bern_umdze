class Users::SendRemoteLinksController < Users::ApplicationController

  def send_link
    reservation = Reservation.find(params[:reservation_id])
    remote_link = reservation.remote_link
    email_list  = Attendance.joins(:user)
                            .includes(:user)
                            .where(reservation_id: reservation.id)
                            .map(&:user)
                            .map(&:email)
    email_list += Attendance.joins(:participant)
                            .includes(:participant)
                            .where(reservation_id: reservation.id)
                            .map(&:participant)
                            .map(&:email)

    if remote_link.present? && email_list.count.positive?
      RemoteLinkMailer.send_link(email_list, reservation).deliver_later

      flash[:notice] = "Zoom-Link an #{reservation.event.event_name} Teilnehmer abgeschickt."
    else

      flash[:alert] =  "OOPS - missing remote link or no participants for: #{reservation&.event&.event_name}"
    end

    redirect_to root_path
  end

end
