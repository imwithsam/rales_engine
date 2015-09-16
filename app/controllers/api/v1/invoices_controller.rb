class Api::V1::InvoicesController < ApplicationController
  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def find
    respond_with Invoice.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with Invoice.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with Invoice.random
  end

  def transactions
    respond_with Transaction.where(invoice_id: params[:id])
  end

  def invoice_items
    respond_with InvoiceItem.where(invoice_id: params[:id])
  end
end
