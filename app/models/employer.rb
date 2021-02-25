# frozen_string_literal: true

class Employer < ApplicationRecord
  has_many :earnings, dependent: :destroy

  validates_presence_of :name, :mapping
end
