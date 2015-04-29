require 'rails_helper'

module CannedMeat
  RSpec.describe SendCampaignJob, type: :job do
    let(:list) do
      create(:canned_meat_list, :with_3_users)
    end
    let(:campaign) { create(:canned_meat_campaign, list: list) }

    describe "#perform" do
      it "should send three mails" do
        SendCampaignJob.new.perform(campaign)
        expect(ActionMailer::Base.deliveries.size).to eq 3
      end
    end
  end
end
