class Api::V1::InvoiceItemsController < ApplicationController
  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    respond_with InvoiceItem.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with InvoiceItem.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with InvoiceItem.random
  end

  def invoice
    respond_with InvoiceItem.find_by(id: params[:id]).invoice
  end

  def item
    respond_with InvoiceItem.find_by(id: params[:id]).item
  end
end
