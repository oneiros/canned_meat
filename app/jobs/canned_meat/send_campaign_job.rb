module CannedMeat
  class SendCampaignJob < ActiveJob::Base
    queue_as :default

    def perform(campaign)
    end
  end
end
