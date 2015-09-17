require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  describe "#index" do
    it "returns all invoice_items" do
      InvoiceItem.create(quantity: 1)
      InvoiceItem.create(quantity: 2)
      InvoiceItem.create(quantity: 2)

      get :index, format: :json
      invoice_items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_items.count).to eq(3)
    end
  end

  describe "#show" do
    it "returns an invoice_item" do
      invoice_item_1 = InvoiceItem.create(quantity: 1)
      InvoiceItem.create(quantity: 2)
      InvoiceItem.create(quantity: 2)

      get :show, format: :json, id: invoice_item_1.id
      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_item[:quantity]).to eq(invoice_item_1.quantity)
    end
  end

  describe "#find" do
    it "finds an invoice_item by quantity" do
      invoice_item_1 = InvoiceItem.create(quantity: 1)
      InvoiceItem.create(quantity: 2)
      InvoiceItem.create(quantity: 2)

      get :find, format: :json, quantity: invoice_item_1.quantity
      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_item[:quantity]).to eq(invoice_item_1.quantity)
    end
  end

  describe "#find_all" do
    it "finds all invoice_items by quantity" do
      invoice_item_1 = InvoiceItem.create(quantity: 1)
      InvoiceItem.create(quantity: 1)
      InvoiceItem.create(quantity: 2)

      get :find_all, format: :json, quantity: invoice_item_1.quantity
      invoice_items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_items.count).to eq(2)
    end
  end

  describe "#random" do
    it "returns a random invoice_item" do
      invoice_item_1 = InvoiceItem.create(quantity: 1)
      invoice_item_2 = InvoiceItem.create(quantity: 2)
      invoice_item_3 = InvoiceItem.create(quantity: 2)

      get :random, format: :json
      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_item[:quantity]).to satisfy do |quantity|
        [invoice_item_1.quantity,
         invoice_item_2.quantity,
         invoice_item_3.quantity].include?(quantity)
      end
    end
  end

  describe "#invoice" do
    it "returns the associated invoice" do
      invoice = Invoice.create(status: "shipped")
      invoice_item = invoice.invoice_items.create(quantity: 1, unit_price: 100)

      get :invoice, format: :json, id: invoice_item.id
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(result[:status]).to eq(invoice.status)
    end
  end

  describe "#item" do
    it "returns the associated item" do
      item = Item.create(name: "Bricks")
      invoice_item = item.invoice_items.create(quantity: 1, unit_price: 100)

      get :item, format: :json, id: invoice_item.id
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(result[:name]).to eq(item.name)
    end
  end
end
