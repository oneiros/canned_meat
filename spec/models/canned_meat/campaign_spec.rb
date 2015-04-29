require 'rails_helper'

module CannedMeat
  RSpec.describe Campaign, type: :model do

    describe "#send!" do
      context "a campaign with status 'draft'" do
        let(:campaign) { create(:canned_meat_campaign, status: 'draft') }

        before(:each) do
          allow(CannedMeat::SendCampaignJob).to receive(:perform_later)
          campaign.send!
        end

        it "should change the campaign's status to 'sending'" do
          expect(campaign.status).to eq "sending"
        end

        it "should queue the send job" do
          expect(CannedMeat::SendCampaignJob).to have_received(:perform_later).with(campaign)
        end
      end

      %w(sending sent).each do |status|
        context "a campaign with status #{status}" do
          let(:campaign) { create(:canned_meat_campaign, status: status) }

          it "should raise an error" do
            expect{
              campaign.send!
            }.to raise_error
          end
        end
      end
    end

    describe "#draft?" do
      context "a campaign with status 'draft'" do
        let(:campaign) { create(:canned_meat_campaign, status: 'draft') }

        it "should return true" do
          expect(campaign.draft?).to eq true
        end
      end

      %w(sending sent).each do |status|
        context "a campaign with status #{status}" do
          let(:campaign) { create(:canned_meat_campaign, status: status) }

          it "should return false" do
            expect(campaign.draft?).to eq false
          end
        end
      end
    end
  end
end
