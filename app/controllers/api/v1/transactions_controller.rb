class Api::V1::TransactionsController < ApplicationController
  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    respond_with Transaction.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with Transaction.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with Transaction.random
  end

  def invoice
    respond_with Transaction.find_by(id: params[:id]).invoice
  end
end
