require "rails_helper"

RSpec.describe SendLinkMailer, type: :mailer do
  xdescribe "magic_link" do
    let(:mail) { SendLinkMailer.magic_link }

    it "renders the headers" do
      expect(mail.subject).to eq("Magic link")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
