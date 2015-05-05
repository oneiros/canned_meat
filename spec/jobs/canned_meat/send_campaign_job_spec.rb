require 'rails_helper'

module CannedMeat
  RSpec.describe SendCampaignJob, type: :job do
    let(:list) do
      create(:canned_meat_list, :with_3_users)
    end
    let(:campaign) { create(:canned_meat_campaign, status: 'sending', list: list) }

    describe "#perform" do

      it "should user a CampaignSender to actually send out mails" do
        sender = double(:campaign_sender, :send_to_all_subscribers! => true)
        allow(CampaignSender).to receive(:new).and_return(sender)
        SendCampaignJob.new.perform(campaign)

        expect(sender).to have_received(:send_to_all_subscribers!)
      end
    end
  end
end
