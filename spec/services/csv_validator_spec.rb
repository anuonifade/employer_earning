# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvValidator do
  subject { described_class.new(invalid_mapping_csv_path, employer) }
  let(:employer) { create(:employer) }
  let(:csv_path) { valid_csv_path }
  let(:valid_single_csv_path) { "#{Rails.root}/spec/fixtures/single_valid.csv" }
  let(:valid_csv_path) { "#{Rails.root}/spec/fixtures/valid.csv" }
  let(:invalid_csv_path) { "#{Rails.root}/spec/fixtures/invalid_file_type.pdf" }
  let(:invalid_mapping_csv_path) { "#{Rails.root}/spec/fixtures/invalid_mapping.csv" }
  let(:service) { described_class.new(csv_path, employer).call }


  describe '#call' do
    context 'a valid CSV uploaded for an employer' do
      it 'should return valid true' do
        service
        expect(service.valid?).to eq(true)
      end
    end

    context 'when an invalid CSV upload for an employer' do
      context 'when an invalid file format' do
        let(:csv_path) { invalid_csv_path }
        it 'should return valid false with error message of invalid file type' do
          service
          expect(service.valid?).to eq(false)
          expect(service.message).to match(/Invalid file type/)
        end
      end

      context 'when an invalid mapping or missing column' do
        let(:csv_path) { invalid_mapping_csv_path }
        it 'should return valid false and error message invalid mapping' do
          service
          expect(service.valid?).to eq(false)
          expect(service.message).to match(/Invalid Header - employee or value - 423/)
        end
      end
    end

    it 'should call employer_mapping methods' do
      expect_any_instance_of(described_class).to receive(:employer_mapping).and_return(employer.mapping)
      subject.call
    end

    it 'should call response methods' do
      expect_any_instance_of(described_class).to receive(:response).with('Invalid Header - employee or value - 423').and_return(validator_response('Invalid Header - employee or value - 423'))
      subject.call
    end

    it 'should call valid_csv_file? methods' do
      expect_any_instance_of(described_class).to receive(:valid_csv_file?).and_return(validator_response('Invalid Header - employee or value - 423'))
      subject.call
    end

    context 'when file is valid' do
      subject { described_class.new(valid_csv_path, employer) }
      it 'should call expected_rows methods' do
        expect_any_instance_of(described_class).to receive(:expected_rows).at_least(:once).and_return(Earning.column_names)
        subject.call
      end
    end
  end
end
