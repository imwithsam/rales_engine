class Api::V1::InvoicesController < ApplicationController
  def show
    respond_with json: Invoice.find_by(id: params[:id])
  end

  def find
    respond_with json: Invoice.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with json: Invoice.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with json: Invoice.random
  end
end
