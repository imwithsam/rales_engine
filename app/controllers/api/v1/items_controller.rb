class Api::V1::ItemsController < ApplicationController
  def show
    respond_with json: Item.find_by(id: params[:id])
  end

  def find
    respond_with json: Item.find_like_by(attribute, params[attribute])
  end

  def find_all
    respond_with json: Item.find_all_like_by(attribute, params[attribute])
  end

  def random
    respond_with json: Item.random
  end
end
