module CannedMeat
  FactoryGirl.define do
    factory :canned_meat_campaign, :class => 'CannedMeat::Campaign' do
      sequence(:name) {|n| "campaign-#{n}"}
      association :list, factory: :canned_meat_list
      association :template, factory: :canned_meat_template
      status "draft"
      subject "MyString"
      body "MyString"
    end
  end
end
