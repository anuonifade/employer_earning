# frozen_string_literal: true

module Api
  module V1
    class EmployersController < ApplicationController
      include ExceptionHandler

      before_action :set_employer, only: %i[show update destroy]

      def index
        employers = Employer.all.order(created_at: :desc)
        render json: employers, status: :ok
      end

      def create
        employer = Employer.create!(employer_params)

        render json: employer, status: :created
      end

      def show
        render json: @employer, status: :ok
      end

      def update
        @employer.update(employer_params)
        head :no_content
      end

      def destroy
        @employer.destroy
        head :no_content
      end

      private

      def employer_params
        params.permit(:name, :mapping)
      end

      def set_employer
        @employer = Employer.find(params[:id])
      end
    end
  end
end
