require "rails_helper"

module CannedMeat
  RSpec.describe CampaignMailer, type: :mailer do
    describe "send_campaign" do
      let(:mail) do
        CampaignMailer.send_campaign(
          "test@example.com",
          "Send campaign",
          "<html>content</html>",
          "content"
        )
      end

      it "uses from email from config" do
        expect(mail.from).to eq [CannedMeat.email_from]
      end

      it "uses recipient from args" do
        expect(mail.to).to eq ["test@example.com"]
      end

      it "uses subject from args" do
        expect(mail.subject).to eq("Send campaign")
      end

      it "uses the html content from args" do
        html_part = mail.parts.find do |part|
          part.content_type.match /^text\/html/
        end

        expect(html_part.body.decoded).to eq "<html>content</html>"
      end

      it "uses the text content from args" do
        text_part = mail.parts.find do |part|
          part.content_type.match /^text\/plain/
        end

        expect(text_part.body.decoded).to eq "content"
      end
    end
  end
end
