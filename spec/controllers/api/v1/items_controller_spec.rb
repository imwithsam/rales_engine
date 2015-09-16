require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
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
