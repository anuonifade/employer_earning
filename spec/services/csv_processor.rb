# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvProcessor do
  subject { described_class.new(valid_single_csv_path, employer) }
  let(:employer) { create(:employer) }
  let(:valid_single_csv_path) { "#{Rails.root}/spec/fixtures/single_valid.csv" }
  let(:valid_csv_path) { "#{Rails.root}/spec/fixtures/valid.csv" }
  let!(:service) { described_class.new(valid_csv_path, employer).call }

  describe '#call' do
    context 'a valid CSV uploaded for an employer' do
      it 'should return status of a status of :create' do
        expect(service.status).to eq(:created)
      end

      it 'should return the employer earnings' do
        expect(Earning.count).to eq(service.data.count)
      end
    end

    it 'should call change_date_format methods' do
      expect_any_instance_of(described_class).to receive(:change_date_format).with('01/01/2021',
                                                                                   'DD/MM/YYYY').and_return('2021-01-01')
      subject.call
    end

    it 'should call currency_value methods' do
      expect_any_instance_of(described_class).to receive(:currency_value).with('$800', '$').and_return(800.0)
      subject.call
    end
  end
end
