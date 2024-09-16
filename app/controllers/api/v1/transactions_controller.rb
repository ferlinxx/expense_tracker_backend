class Api::V1::TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        user_id = params[:user_id]
        @transactions = Transaction.where({user_id: user_id}).order(:created_at ).reverse_order
        render json: { message: "transactions selected successfully!", transactions: @transactions }
    end

    def new
        @transaction = Transaction.new
    end

    def create
        @transaction = Transaction.new(transaction_params)

        if @transaction.save
            render json: { message: "Transaction created successfully!", transaction: @transaction }
        else
            render json: { error: @transaction.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def transaction_params
        params.require(:transaction).permit(:user_id, :category_id, :amount, :comment)
    end
end
