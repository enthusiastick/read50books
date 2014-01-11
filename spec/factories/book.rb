FactoryGirl.define do
  factory :book do
    sequence(:title) {|n| "#{n} Book" }
    sequence(:author) {|n| "#{n} Author" }
    date_completed "1982-3-21"
    user
  end
end
