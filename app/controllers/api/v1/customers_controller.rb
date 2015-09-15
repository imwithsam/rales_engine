class Api::V1::CustomersController < ApplicationController
  def show
    respond_with json: Customer.find_by(id: params[:id])
  end

  def find
    respond_with json: Customer.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with json: Customer.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with json: Customer.random
  end
end
