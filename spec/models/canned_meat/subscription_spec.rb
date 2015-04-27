require 'rails_helper'

module CannedMeat
  RSpec.describe Subscription, type: :model do

    describe "#unsubscribe!" do
      let(:subscription) { create(:canned_meat_subscription) }

      it "sets the unsubscribed_at timestamp" do
        expect{
          subscription.unsubscribe!
        }.to change(subscription, :unsubscribed_at)
        expect(subscription.unsubscribed_at).to be_within(3.seconds).of(Time.now)
      end
    end
  end
end
