FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"
  end

  factory :transaction do
    sequence(:date)   { |n| Date.today + n * 1.day }
    sequence(:amount) { |n| n.to_f }
    description 'This is just a transaction.'
    user
  end
end