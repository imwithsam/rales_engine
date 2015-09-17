require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  describe "#index" do
    it "returns all merchants" do
      Merchant.create(name: "Acme Corporation")
      Merchant.create(name: "Beta Corporation")
      Merchant.create(name: "C Corporation")

      get :index, format: :json
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchants.count).to eq(3)
    end
  end

  describe "#show" do
    it "returns a merchant" do
      merchant_1 = Merchant.create(name: "Acme Corporation")
      Merchant.create(name: "Beta Corporation")
      Merchant.create(name: "C Corporation")

      get :show, format: :json, id: merchant_1.id
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant[:name]).to eq(merchant_1.name)
    end
  end

  describe "#find" do
    it "finds a merchant by name" do
      merchant_1 = Merchant.create(name: "Acme Corporation")
      Merchant.create(name: "Beta Corporation")
      Merchant.create(name: "C Corporation")

      get :find, format: :json, name: merchant_1.name
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant[:name]).to eq(merchant_1.name)
    end
  end

  describe "#find_all" do
    it "finds all merchants by name" do
      merchant_1 = Merchant.create(name: "Acme Corporation")
      Merchant.create(name: "Acme Corporation")
      Merchant.create(name: "C Corporation")

      get :find_all, format: :json, name: merchant_1.name
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchants.count).to eq(2)
    end
  end

  describe "#random" do
    it "returns a random merchant" do
      merchant_1 = Merchant.create(name: "Acme Corporation")
      merchant_2 = Merchant.create(name: "Beta Corporation")
      merchant_3 = Merchant.create(name: "C Corporation")

      get :random, format: :json
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant[:name]).to satisfy do |name|
        [merchant_1.name, merchant_2.name, merchant_3.name].include?(name)
      end
    end
  end

  describe "#items" do
    it "returns a collection of items associated with that merchant" do
      merchant = Merchant.create(name: "Acme Corporation")
      merchant.items.create(
        name: "Explosive Tennis Balls",
        description: "Tickle your friends! Surprise your opponent!",
        unit_price: 120000)
      merchant.items.create(
        name: "American Wrought Anvils",
        description: "They ring like a bell.",
        unit_price: 10000)
      merchant.items.create(
        name: "Instant Tunnel",
        description: "For a smashing good time!",
        unit_price: 1995)

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
