# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Earning, type: :model do
  it { should belong_to(:employer) }
  it { should validate_presence_of(:employee_id) }
  it { should validate_presence_of(:earning_date) }
  it { should validate_presence_of(:amount) }
end
