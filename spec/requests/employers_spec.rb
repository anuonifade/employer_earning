# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employers API' do
  let!(:employer) { create_list(:employer, 10) }
  let(:employer_id) { employer.first.id }

  # Test suite for GET /api/v1/employers
  describe 'GET API /employers' do
    before { get '/api/v1/employers' }

    it 'returns employers' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/employers/:id
  describe 'GET API /employers/:id' do
    before { get "/api/v1/employers/#{employer_id}" }

    context 'when the record exists' do
      it 'returns the employer' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(employer_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:employer_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Employer/)
      end
    end
  end

  # Test suite for POST api/v1/employers
  describe 'POST API /employers' do
    # valid payload
    let(:valid_attributes) do
      {
        name: 'Test Employer',
        mapping: {
          'employee' => 'employee_id',
          'netAmount': ['amount', '$'],
          'earningDate': ['earning_date', 'DD/MM/YYYY']
        }
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/employers', params: valid_attributes }

      it 'creates a todo' do
        expect(json['name']).to eq('Test Employer')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/employers', params: { mapping: {} } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/employers
  describe 'PUT API /employers/:id' do
    let(:valid_attributes) { { name: 'Updated Employer' } }

    context 'when the record exists' do
      before { put "/api/v1/employers/#{employer_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1/employers/:id
  describe 'DELETE API /employers/:id' do
    before { delete "/api/v1/employers/#{employer_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
