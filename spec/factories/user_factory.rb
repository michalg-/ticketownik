FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Johnny Doe #{n}" }
    sequence(:email) { |n| "johnny_doe_#{n}@example.com" }
    password 'abcd'
  end
end
