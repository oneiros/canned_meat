module CannedMeat
  FactoryGirl.define do
    factory :canned_meat_template, :class => 'CannedMeat::Template' do
      sequence(:name) {|n| "template-#{n}" }
      html "{{content}}"
      text "{{content}}"
    end
  end
end
