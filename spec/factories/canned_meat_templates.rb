module CannedMeat
  FactoryGirl.define do
    factory :canned_meat_template, :class => 'CannedMeat::Template' do
      sequence(:name) {|n| "template-#{n}" }
    end
  end
end
