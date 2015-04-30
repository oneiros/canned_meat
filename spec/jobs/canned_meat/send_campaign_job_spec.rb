require 'rails_helper'

module CannedMeat
  RSpec.describe SendCampaignJob, type: :job do
    let(:list) do
      create(:canned_meat_list, :with_3_users)
    end
    let(:campaign) { create(:canned_meat_campaign, status: 'sending', list: list) }

    describe "#perform" do
      before(:each) { SendCampaignJob.new.perform(campaign) }

      it "should send three mails" do
        expect(ActionMailer::Base.deliveries.size).to eq 3
      end

      it "should set the campaign's status to 'sent' when finished" do
        expect(campaign.status).to eq 'sent'
      end
    end
  end
end
