# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employer, type: :model do
  it { should have_many(:earnings).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:mapping) }
end
