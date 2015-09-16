require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  describe "#items" do
    it "returns a collection of items associated with that merchant" do
      merchant = Merchant.create(name: "Acme Corporation")
      merchant.items.create(
        name: "Explosive Tennis Balls",
        description: "Tickle your friends! Surprise your opponent!",
        unit_price: "120000")
      merchant.items.create(
        name: "American Wrought Anvils",
        description: "They ring like a bell.",
        unit_price: "10000")
      merchant.items.create(
        name: "Instant Tunnel",
        description: "For a smashing good time!",
        unit_price: "1995")

      get :items, format: :json, id: merchant.id
      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(items.count).to eq(3)
      items.each do |item|
        expect(item[:merchant_id]).to eq(merchant.id)
      end
    end
  end

  describe "#invoices" do
    it "returns a collection of invoices associated with that merchant" do
      merchant = Merchant.create(name: "Acme Corporation")
      merchant.invoices.create(status: "shipped")
      merchant.invoices.create(status: "shipped")
      merchant.invoices.create(status: "shipped")

      get :invoices, format: :json, id: merchant.id
      invoices = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoices.count).to eq(3)
      invoices.each do |invoice|
        expect(invoice[:merchant_id]).to eq(merchant.id)
      end
    end
  end
end
