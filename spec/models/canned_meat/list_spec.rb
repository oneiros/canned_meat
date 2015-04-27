require 'rails_helper'

module CannedMeat
  RSpec.describe List, type: :model do

    describe "#subscribe!" do
      let(:list) { create(:canned_meat_list) }
      let(:user) { ::User.create!(name: "test") }

      it "adds a subscription" do
        expect{
          list.subscribe!(user)
        }.to change(Subscription, :count).by(1)
      end

      it "makes the given user a subscriber of this list" do
        list.subscribe!(user)

        expect(list.subscribers).to include(user)
      end
    end
  end

  describe "#unsubscribe!" do
    let(:list) { create(:canned_meat_list) }
    let(:subscribed_user) { ::User.create!(name: "existing subscriber") }
    let!(:subscription) { create(:canned_meat_subscription, list: list, subscriber: subscribed_user) }

    it "sets an unsubscribe date on the subscription" do
      expect{
        list.unsubscribe!(subscribed_user)
        subscription.reload
      }.to change(subscription, :unsubscribed_at)
    end

    it "removes the given user from the list of subscribers" do
      list.unsubscribe!(subscribed_user)

      expect(list.subscribers).to_not include(subscribed_user)
    end

    it "raises an error if user is not subscribed" do
      unsubscribed_user = ::User.create!(name: "another user")

      expect{
        list.unsubscribe!(unsubscribed_user)
      }.to raise_error(ArgumentError)
    end
  end
end
