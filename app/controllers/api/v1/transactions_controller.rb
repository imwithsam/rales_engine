class Api::V1::TransactionsController < ApplicationController
  def show
    respond_with json: Transaction.find_by(id: params[:id])
  end

  def find
    respond_with json: Transaction.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with json: Transaction.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with json: Transaction.random
  end
end
