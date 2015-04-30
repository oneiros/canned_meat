module CannedMeat
  class SendCampaignJob < ActiveJob::Base
    queue_as :default

    def perform(campaign)

      campaign.list.subscribers.each do |subscriber|
        CampaignMailer.send_campaign.deliver_now
      end
      campaign.update_attributes!(status: 'sent')
    end
  end
end
