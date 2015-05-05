require 'rails_helper'

module CannedMeat
  RSpec.describe CampaignSender do
    let(:list) do
      create(:canned_meat_list, :with_3_users)
    end
    let(:campaign) { create(:canned_meat_campaign, status: 'sending', list: list) }

    before(:example) { ActionMailer::Base.deliveries.clear }

    describe "#send_to_all_subscribers!" do

      it "should send three mails" do
        CampaignSender.new(campaign).send_to_all_subscribers!

        expect(ActionMailer::Base.deliveries.size).to eq 3
      end

      it "should set the campaign's status to 'sent' when finished" do
        CampaignSender.new(campaign).send_to_all_subscribers!

        expect(campaign.status).to eq 'sent'
      end

      it "should call send_to for sending out individual mails" do
        sender = CampaignSender.new(campaign)
        allow(sender).to receive(:send_to)
        sender.send_to_all_subscribers!

        expect(sender).to have_received(:send_to).exactly(3).times
      end
    end

    describe "#send_to" do

      it "should send one email" do
        CampaignSender.new(campaign).send_to(list.subscribers.first)

        expect(ActionMailer::Base.deliveries.size).to eq 1
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
          CampaignSender.new(campaign).send_to(user)

          expect(CampaignMailer).to have_received(:send_campaign)
            .with(
              "john@example.com",
              "campaign test subject",
              "<html>John <p>test content</p>\n</html>",
              "test content\n\n John"
            )
        end
      end
    end
  end
end
