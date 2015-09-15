class Api::V1::MerchantsController < ApplicationController
  def show
    respond_with json: Merchant.find_by(id: params[:id])
  end
end
