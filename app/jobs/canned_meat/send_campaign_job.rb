module CannedMeat
  class SendCampaignJob < ActiveJob::Base
    queue_as :default

    def perform(campaign)
      CampaignSender.new(campaign).send_to_all_subscribers!
    end
  end
end
