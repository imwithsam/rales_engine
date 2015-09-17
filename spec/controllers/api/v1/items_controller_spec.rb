require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  describe "#index" do
    it "returns all items" do
      Item.create(name: "Brick")
      Item.create(name: "Anvil")
      Item.create(name: "Dynamite")

      get :index, format: :json
      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(items.count).to eq(3)
    end
  end

  describe "#show" do
    it "returns an item" do
      item_1 = Item.create(name: "Brick")
      Item.create(name: "Anvil")
      Item.create(name: "Dynamite")

      get :show, format: :json, id: item_1.id
      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(item[:name]).to eq(item_1.name)
    end
  end

  describe "#find" do
    it "finds an item by name" do
      item_1 = Item.create(name: "Brick")
      Item.create(name: "Anvil")
      Item.create(name: "Dynamite")

      get :find, format: :json, name: item_1.name
      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(item[:name]).to eq(item_1.name)
    end
  end

  describe "#find_all" do
    it "finds all items by name" do
      item_1 = Item.create(name: "Brick")
      Item.create(name: "Brick")
      Item.create(name: "Dynamite")

      get :find_all, format: :json, name: item_1.name
      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(items.count).to eq(2)
    end
  end

  describe "#random" do
    it "returns a random item" do
      item_1 = Item.create(name: "Brick")
      item_2 = Item.create(name: "Anvil")
      item_3 = Item.create(name: "Dynamite")

      get :random, format: :json
      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(item[:name]).to satisfy do |name|
        [item_1.name,
         item_2.name,
         item_3.name].include?(name)
      end
    end
  end

  describe "#invoice_items" do
    it "returns a collection of associated invoice_items" do
      item = Item.create(name: "Bricks")
      item.invoice_items.create(quantity: 1, unit_price: 100)
      item.invoice_items.create(quantity: 3, unit_price: 300)
      item.invoice_items.create(quantity: 2, unit_price: 200)

      get :invoice_items, format: :json, id: item.id
      invoice_items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_items.count).to eq(3)
      invoice_items.each do |invoice_item|
        expect(invoice_item[:item_id]).to eq(item.id)
      end
    end
  end

  describe "#merchant" do
    it "returns the associated merchant" do
      merchant = Merchant.create(name: "Acme Corporation")
      item = merchant.items.create(name: "Bricks")

      get :merchant, format: :json, id: item.id
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(result[:name]).to eq(merchant.name)
    end
  end
end
