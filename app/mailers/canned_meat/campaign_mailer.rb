module CannedMeat
  class CampaignMailer < ActionMailer::Base

    def send_campaign(email, subject, html, text)
      mail from: CannedMeat.email_from, to: email, subject: subject do |format|
        format.html { render text: html }
        format.text { render text: text }
      end
    end
  end
end
