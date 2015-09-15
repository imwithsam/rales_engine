class Api::V1::MerchantsController < ApplicationController
  def show
    respond_with json: Merchant.find_by(id: params[:id])
  end

  def find
    respond_with json: Merchant.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with json: Merchant.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with json: Merchant.random
  end
end
