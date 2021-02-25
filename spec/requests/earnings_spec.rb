# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Earnings API' do
  let!(:employer) { create(:employer) }
  let!(:earnings) { create_list(:earning, 20, employer_id: employer.id) }
  let(:employer_id) { employer.id }
  let(:id) { earnings.first.id }

  describe 'GET API /employers/:employer_id/earnings' do
    before { get "/api/v1/employers/#{employer_id}/earnings" }

    context 'when earnings exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all employers earnings' do
        expect(json.size).to eq(20)
      end
    end

    context 'when employer does not exist' do
      let(:employer_id) { 0 }

      it 'returns a status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Employer/)
      end
    end
  end

  describe 'GET API /employers/:employer_id/earnings/:id' do
    before { get "/api/v1/employers/#{employer_id}/earnings/#{id}" }

    context 'when employer earning exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the earning' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when the employer earning does not exist' do
      let(:id) { 0 }

      it 'returns a status code of 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found error message' do
        expect(response.body).to match(/Couldn't find Earning/)
      end
    end
  end

  describe 'POST /employers/:employer_id/earnings' do
    let(:valid_attributes) { { employee_id: '23411', earning_date: '2012-01-02', amount: 500.00 } }
    let(:file_path) { "#{Rails.root}/spec/fixtures/file.csv" }
    let(:type) { 'text/csv' }
    let(:file) { Rack::Test::UploadedFile.new file_path, 'text/csv' }

    context 'when bulk upload and valid file' do
      before do
        allow(CsvValidator.new(file_path, employer)).to receive(:call).and_return(OpenStruct.new(valid?: true))

        post "/api/v1/employers/#{employer_id}/earnings", params: { file: file }
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when requests are not valid' do
      before do
        allow(CsvValidator.new(file_path, employer)).to receive(:call).and_return(OpenStruct.new(valid?: true))

        post "/api/v1/employers/#{employer_id}/earnings", params: {}
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Employee can't be blank, Earning date can't be blank, Amount can't be blank/)
      end
    end

    context 'with no file upload' do
      context 'when request is valid' do
        before { post "/api/v1/employers/#{employer_id}/earnings", params: valid_attributes }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when an invalid request' do
        before { post "/api/v1/employers/#{employer_id}/earnings", params: {} }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a failure message' do
          expect(response.body).to match(/Validation failed: Employee can't be blank, Earning date can't be blank, Amount can't be blank/)
        end
      end
    end
  end

  describe 'PUT /employers/:employer_id/earnings/:id' do
    let(:valid_attributes) { { employee_id: '22773373' } }

    before { put "/api/v1/employers/#{employer_id}/earnings/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the Earnings' do
        updated_earning = Earning.find(id)
        expect(updated_earning.employee_id).to match(/22773373/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Earning/)
      end
    end
  end

  describe 'DELETE /employers/:employer_id/earnings/:id' do
    before { delete "/api/v1/employers/#{employer_id}/earnings/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
