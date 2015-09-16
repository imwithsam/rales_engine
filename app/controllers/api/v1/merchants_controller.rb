class Api::V1::MerchantsController < ApplicationController
  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with Merchant.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with Merchant.random
  end

  def items
    respond_with Item.where(merchant_id: params[:id])
  end

  def invoices
    respond_with Invoice.where(merchant_id: params[:id])
  end
end
