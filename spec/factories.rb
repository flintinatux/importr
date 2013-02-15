FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"
  end

  factory :transaction do
    sequence(:date)   { |n| n.days.from_now }
    sequence(:amount) { |n| n.to_f }
    description 'This is just a transaction.'
    user
  end

  factory :invalid_transaction do
    date          nil
    description   'a' * 256
    amount        0.00
    user
  end
end