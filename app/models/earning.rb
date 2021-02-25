# frozen_string_literal: true

class Earning < ApplicationRecord
  belongs_to :employer

  validates_presence_of :employee_id, :earning_date, :amount
end
