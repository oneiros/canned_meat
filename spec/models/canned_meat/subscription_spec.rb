require 'rails_helper'

module CannedMeat
  RSpec.describe Subscription, type: :model do
    let(:subscription) { create(:canned_meat_subscription) }

    describe "#subscriber_name" do
      it "should call the configured label method on the subscriber" do
        subscriber = double(:subscriber, CannedMeat.label_method => "test name")
        allow(subscription).to receive(:subscriber).and_return(subscriber)

        expect(subscription.subscriber_name).to eq "test name"
      end
    end

    describe "#subscriber_email" do
      it "should call the configured email method on the subscriber" do
        subscriber = double(:subscriber, CannedMeat.email_method => "john.test@example.com")
        allow(subscription).to receive(:subscriber).and_return(subscriber)

        expect(subscription.subscriber_email).to eq "john.test@example.com"
      end
    end

    describe "#unsubscribe!" do
      it "sets the unsubscribed_at timestamp" do
        expect{
          subscription.unsubscribe!
        }.to change(subscription, :unsubscribed_at)
        expect(subscription.unsubscribed_at).to be_within(3.seconds).of(Time.now)
      end
    end

    describe "#unsubscribe_token" do
      it "returns the id signed with the apps secret_key_base" do
        verifier = ActiveSupport::MessageVerifier.new(
          Rails.application.secrets.secret_key_base
        )
        token = subscription.unsubscribe_token

        expect(verifier.verify(token)).to eq subscription.id
      end
    end

    describe "#find_by_unsubscribe_token" do
      it "returns the matching subscription" do
        found_subscription = Subscription.find_by_unsubscribe_token(
          subscription.unsubscribe_token
        )

        expect(found_subscription).to eq subscription
      end
    end
  end
end
