module CannedMeat
  class CampaignMailer < ActionMailer::Base

    def send_campaign
      mail from: CannedMeat.email_from, to: "to@example.org" do |format|
        format.html { render text: "<html></html>" }
        format.text { render text: "test" }
      end
    end
  end
end
