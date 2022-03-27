# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/send_link
class SendLinkPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/send_link/magic_link
  def magic_link
    SendLinkMailer.magic_link
  end
end
