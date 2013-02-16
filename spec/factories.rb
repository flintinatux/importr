FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"
  end

  factory :transaction do
    sequence(:date)   { |n| Random.rand(10).days.ago }
    sequence(:amount) { |n| n.to_f }
    description 'This is just a transaction.'
    user
  end

  factory :invalid_transaction, parent: :transaction do
    amount 0.00
  end
end