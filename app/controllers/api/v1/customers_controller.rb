class Api::V1::CustomersController < ApplicationController
  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    respond_with Customer.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with Customer.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with Customer.random
  end

  def invoices
    respond_with Customer.find_by(id: params[:id]).invoices
  end

  def transactions
    respond_with Customer.find_by(id: params[:id]).transactions
  end
end
