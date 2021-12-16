# Preview all emails at http://localhost:3000/rails/mailers/remote_link
class RemoteLinkPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/remote_link/send_link
  def send_link
    RemoteLinkMailer.send_link
  end

end
