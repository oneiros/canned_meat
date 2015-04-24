FactoryGirl.define do
  factory :canned_meat_list, :class => 'CannedMeat::List' do
    sequence(:name) {|n| "List#{n}" }
  end
end
