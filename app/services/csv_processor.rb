# frozen_string_literal: true

class CsvProcessor
  require 'csv'

  def initialize(file_path, employer)
    @file_path = file_path
    @employer = employer
  end

  def call
    @error = []
    @status = true

    map = @employer.mapping

    CSV.foreach(@file_path, headers: true) do |row|
      data = {}

      row.each do |k, v|
        key = map[k]
        if key.is_a? Array
          v = change_date_format(v, key[1]) if key[0].to_sym == :earning_date
          v = currency_value(v, key[1]) if key[0].to_sym == :amount
          data[key[0].to_sym] = v
        else
          data[key.to_sym] = v
        end
      end
      @employer.earnings.create! data
    end
    OpenStruct.new(data: @employer.earnings.all, status: :created)
  rescue StandardError => e
    OpenStruct.new(message: e.message, status: :unprocessable_entity)
  end

  private

  def change_date_format(date_value, incoming_format)
    return incoming_format if incoming_format == 'YYYY-MM-DD'

    begin
      date = Date.parse(date_value)
      date.strftime('%Y-%m-%d')
    rescue StandardError => e
      # Logs on error loggers.
      puts "Date format error #{e.message}"
    end
  end

  def currency_value(value, currency_sym)
    return value[1..].to_f if currency_sym.present?

    value
  end
end
