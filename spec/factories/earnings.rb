# frozen_string_literal: true

FactoryBot.define do
  factory :earning do
    employee_id { Faker::Alphanumeric.alpha(number: 5) }
    earning_date { Faker::Date.between(from: '2014-09-23', to: '2020-09-25') }
    amount { Faker::Number.decimal(l_digits: 2) }
    employer_id { nil }
  end
end
