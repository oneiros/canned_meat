require "rails_helper"

module CannedMeat
  RSpec.describe CampaignMailer, type: :mailer do
    describe "send_campaign" do
      let(:mail) { CampaignMailer.send_campaign }

      it "renders the headers" do
        expect(mail.subject).to eq("Send campaign")
        expect(mail.to).to eq(["to@example.org"])
      end
    end
  end
end
