FactoryGirl.define do
  factory :ticket do
    sequence(:title) { |n| "title #{n}" }
    sequence(:description) { |n| "description #{n}" }
    creator { User.last || create(:user) }
    project { Project.last || create(:project) }
  end
end
