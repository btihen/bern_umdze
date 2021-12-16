class RemoteLinkMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.remote_link_mailer.send_link.subject
  #
  def send_link(email_list, reservation)
    @greeting = "Hi"

    @email_list = email_list
    @reservation  = reservation

    # email_list.each do |email|
      # send email to each participant individually to prevent everyone from seeing all email addresses
      mail( to: email_list,
            from: 'zoom-link@bernumdze.org',
            subject: "Zoom-Link für #{reservation.event.event_name}"
          )
    # end
  end

end
