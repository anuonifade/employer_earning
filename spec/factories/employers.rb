# frozen_string_literal: true

FactoryBot.define do
  factory :employer do
    name { Faker::Lorem.word }
    mapping do
      {
        'EmployeeID' => 'employee_id',
        'CheckDate' => %w[earning_date DD/MM/YYYY],
        'Amount' => ['amount', '$']
      }
    end
  end
end
