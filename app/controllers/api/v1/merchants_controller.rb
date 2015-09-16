class Api::V1::MerchantsController < ApplicationController
  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by(find_params)
  end

  def find_all
    respond_with Merchant.where(find_params)
  end

  def random
    respond_with Merchant.random
  end

  def items
    respond_with Merchant.find_by(id: params[:id]).items
  end

  def invoices
    respond_with Merchant.find_by(id: params[:id]).invoices
  end

  def most_revenue
    respond_with Merchant
      .all
      .sort_by { |merchant| merchant.revenue }
      .reverse
      .take(quantity)
  end

  def most_items
    respond_with Merchant
      .all
      .sort_by { |merchant| merchant.items_sold }
      .reverse
      .take(quantity)
  end

  private

  def quantity
    params[:quantity].to_i
  end

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
