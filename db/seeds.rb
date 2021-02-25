# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Employer.create(name: 'Employer A',
                mapping: { 'EmployeeID' => 'employee_id', 'CheckDate' => %w[earning_date DD-MM-YYYY],
                           'Amount' => ['amount', '$'] })
Employer.create(name: 'Employer B',
                mapping: { 'employee' => 'employee_id', 'earningDate' => ['earning_date', 'DD/MM/YYYY'],
                           'netAmount' => ['amount', ''] })
