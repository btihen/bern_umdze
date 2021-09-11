class SendLinkMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.send_link_mailer.magic_link.subject
  #
  def magic_link(participant, magic_link_url)
    @participant = participant
    @magic_link_url  = magic_link_url

    mail(to: @participant.email, subject: 'Access für bernumdze.org')
  end
end
