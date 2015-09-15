class Api::V1::InvoiceItemsController < ApplicationController
  def show
    respond_with json: InvoiceItem.find_by(id: params[:id])
  end

  def find
    respond_with json: InvoiceItem.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with json: InvoiceItem.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with json: InvoiceItem.random
  end
end