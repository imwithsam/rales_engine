class Api::V1::TransactionsController < ApplicationController
  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    respond_with Transaction.find_by(find_params)
  end

  def find_all
    respond_with Transaction.where(find_params)
  end

  def random
    respond_with Transaction.random
  end

  def invoice
    respond_with Transaction.find_by(id: params[:id]).invoice
  end

  private

  def find_params
    params.permit(:id,
                  :invoice_id,
                  :credit_card_number,
                  :result,
                  :created_at,
                  :updated_at)
  end
end
