class Api::V1::ItemsController < ApplicationController
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
end
