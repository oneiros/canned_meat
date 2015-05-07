require 'rails_helper'

module CannedMeat
  RSpec.feature "Subscriptions", type: :feature do

    describe "#unsubscribe" do
      let!(:subscription) { create(:canned_meat_subscription) }

      it "should set unsubscribed_at date" do
        expect{
          visit "/canned_meat/u/#{subscription.unsubscribe_token}"
          subscription.reload
        }.to change(subscription, :unsubscribed_at)
      end

      describe "access" do
        before(:context) { CannedMeat.authenticator = proc { false } }
        after(:context) { CannedMeat.authenticator = nil }

        it "should work without authentication" do
          visit "/canned_meat/u/#{subscription.unsubscribe_token}"

          expect(page).to have_content(
            I18n.t('canned_meat.views.subscriptions.unsubscribe.headline')
          )
        end
      end
    end
  end
end
