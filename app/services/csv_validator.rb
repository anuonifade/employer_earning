# frozen_string_literal: true

class CsvValidator
  require 'csv'

  def initialize(csv_path, employer)
    @csv_path = csv_path
    @employer = employer
  end

  def call
    return response('Invalid file type') unless valid_csv_file?

    CSV.foreach(@csv_path, headers: true) do |row|
      row.each do |header, value|
        key = employer_mapping[header]
        return response("Invalid Header - #{header} or value - #{value}") unless key.present? && value.present?

        if key.is_a? Array
          return response("Invalid column in mapping #{key[0].upcase}") unless expected_rows.include?(key[0])
        else
          return response("Invalid column in mapping #{key.upcase}") unless expected_rows.include?(key)
        end
      end
    end

    OpenStruct.new(valid?: true)
  end

  private

  def employer_mapping
    @employer.mapping
  end

  def response(message)
    OpenStruct.new(message: message, status: :unprocessable_entity, valid?: false)
  end

  def valid_csv_file?
    @csv_path.split('.').last.downcase == 'csv'
  end

  def expected_rows
    @expected_rows ||= Earning.column_names
  end
end
