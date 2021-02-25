# frozen_string_literal: true

module Api
  module V1
    class EarningsController < ApplicationController
      include ExceptionHandler

      before_action :set_employer
      before_action :set_employer_earning, only: %i[show update destroy]

      def index
        render json: @employer.earnings.all, status: :ok
      end

      def create
        if earning_params[:file].present?
          file_path = earning_params[:file].path

          csv = CsvValidator.new(file_path, @employer).call
          if csv.valid?
            result = CsvProcessor.new(file_path, @employer).call
            render json: result.data, status: result.status
          else
            render json: { message: csv.message }, status: csv.status
          end
        else
          @employer.earnings.create!(earning_params)
          render json: @employer.earnings.last, status: :created
        end
      end

      def show
        render json: @earning, status: :ok
      end

      def update
        @employer.earnings.update(earning_params)
        head :no_content
      end

      def destroy
        @employer.destroy
        head :no_content
      end

      private

      def earning_params
        params.permit(:employer_id, :employee_id, :earning_date, :amount, :file)
      end

      def set_employer
        @employer = Employer.find(params[:employer_id])
      end

      def set_employer_earning
        @earning = @employer.earnings.find_by!(id: params[:id]) if @employer
      end
    end
  end
end
