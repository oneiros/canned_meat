FactoryGirl.define do
  factory :canned_meat_list, :class => 'CannedMeat::List' do
    sequence(:name) {|n| "List#{n}" }

    trait :with_3_users do
      after(:create) do |list|
        (1..3).map do |n|
          name = "user-#{n}"
          User.create!(name: name, email: "#{name}@example.com")
        end.each do |user|
          list.subscribe!(user)
        end
      end
    end
  end
end
