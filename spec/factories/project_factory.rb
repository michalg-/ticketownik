FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "Project no #{n}" }
  end
end
