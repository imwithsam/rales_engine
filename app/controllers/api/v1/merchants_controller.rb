class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def show
    respond_with json: Merchant.find_by(id: params[:id])
  end
end
