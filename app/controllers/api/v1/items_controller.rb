class Api::V1::ItemsController < ApplicationController
  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def find
    respond_with Item.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with Item.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with Item.random
  end

  def invoice_items
    respond_with Item.find_by(id: params[:id]).invoice_items
  end

  def merchant
    respond_with Item.find_by(id: params[:id]).merchant
  end
end
