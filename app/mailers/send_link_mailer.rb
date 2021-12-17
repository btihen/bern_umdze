class SendLinkMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.send_link_mailer.magic_link.subject
  #
  def magic_link(person, auth_url)
    @person   = person
    @auth_url = auth_url

    mail(to:      @person.email,
         from:    'access-link@bernumdze.org',
         subject: 'Access für bernumdze.org')
  end
end
