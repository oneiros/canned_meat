require 'rails_helper'

module CannedMeat
  RSpec.describe SendCampaignJob, type: :job do
    let(:list) do
      create(:canned_meat_list, :with_3_users)
    end
    let(:campaign) { create(:canned_meat_campaign, status: 'sending', list: list) }

    describe "#perform" do

      it "should send three mails" do
        SendCampaignJob.new.perform(campaign)

        expect(ActionMailer::Base.deliveries.size).to eq 3
      end

      it "should set the campaign's status to 'sent' when finished" do
        SendCampaignJob.new.perform(campaign)

        expect(campaign.status).to eq 'sent'
      end

      describe "assembling of contents" do
        let(:list) { create(:canned_meat_list) }
        let!(:user) do
          User.create!(name: "John", email: "john@example.com").tap {|u| list.subscribe!(u)}
        end
        let(:template) do
          create(:canned_meat_template,
            html: "<html>{{subscriber_name}} {{content}}</html>",
            text: "{{content}} {{subscriber_name}}"
          )
        end
        let(:campaign) do
          create(:canned_meat_campaign,
            status: 'sending',
            list: list,
            template: template,
            subject: "campaign test subject",
            body: "test content"
          )
        end

        before(:example) do
          email = double(:email, deliver_now: true)
          allow(CampaignMailer).to receive(:send_campaign).and_return(email)
        end

        it "should feed the mailer all necessary information" do
          SendCampaignJob.new.perform(campaign)

          expect(CampaignMailer).to have_received(:send_campaign)
            .with(
              "john@example.com",
              "campaign test subject",
              "<html>John test content</html>",
              "test content John"
            )
        end
      end
    end
  end
end
