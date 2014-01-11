# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "user#{n}name" }
    sequence(:email) {|n| "person#{n}@example.com" }
    password 'password123'
    password_confirmation 'password123'
  end
end
