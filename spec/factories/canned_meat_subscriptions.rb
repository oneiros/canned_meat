module CannedMeat
  FactoryGirl.define do
    factory :canned_meat_subscription, :class => 'CannedMeat::Subscription' do
      unsubscribed_at nil
      association :list, factory: :canned_meat_list
    end
  end
end
