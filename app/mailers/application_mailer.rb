# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no_response@bernumdze.org'
  layout 'mailer'
end
