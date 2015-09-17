require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  describe "#index" do
    it "returns all invoices" do
      Invoice.create(status: "shipped")
      Invoice.create(status: "canceled")
      Invoice.create(status: "canceled")

      get :index, format: :json
      invoices = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoices.count).to eq(3)
    end
  end

  describe "#show" do
    it "returns a invoice" do
      invoice_1 = Invoice.create(status: "shipped")
      Invoice.create(status: "canceled")
      Invoice.create(status: "canceled")

      get :show, format: :json, id: invoice_1.id
      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice[:status]).to eq(invoice_1.status)
    end
  end

  describe "#find" do
    it "finds a invoice by status" do
      invoice_1 = Invoice.create(status: "shipped")
      Invoice.create(status: "canceled")
      Invoice.create(status: "canceled")

      get :find, format: :json, status: invoice_1.status
      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice[:status]).to eq(invoice_1.status)
    end
  end

  describe "#find_all" do
    it "finds all invoices by status" do
      invoice_1 = Invoice.create(status: "shipped")
      Invoice.create(status: "shipped")
      Invoice.create(status: "canceled")

      get :find_all, format: :json, status: invoice_1.status
      invoices = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoices.count).to eq(2)
    end
  end

  describe "#random" do
    it "returns a random invoice" do
      invoice_1 = Invoice.create(status: "shipped")
      invoice_2 = Invoice.create(status: "canceled")
      invoice_3 = Invoice.create(status: "canceled")

      get :random, format: :json
      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice[:status]).to satisfy do |status|
        [invoice_1.status,
         invoice_2.status,
         invoice_3.status].include?(status)
      end
    end
  end

  describe "#transactions" do
    it "returns a collection of associated transactions" do
      invoice = Invoice.create(status: "shipped")
      invoice.transactions.create(
        credit_card_number: "4242424242424242",
        result: "failed")
      invoice.transactions.create(
        credit_card_number: "4242424242424242",
        result: "failed")
      invoice.transactions.create(
        credit_card_number: "4242424242424242",
        result: "success")

      get :transactions, format: :json, id: invoice.id
      transactions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transactions.count).to eq(3)
      transactions.each do |transaction|
        expect(transaction[:invoice_id]).to eq(invoice.id)
      end
    end
  end

  describe "#invoice_items" do
    it "returns a collection of associated invoice_items" do
      invoice = Invoice.create(status: "shipped")
      invoice.invoice_items.create(quantity: 1, unit_price: 100)
      invoice.invoice_items.create(quantity: 3, unit_price: 300)
      invoice.invoice_items.create(quantity: 2, unit_price: 200)

      get :invoice_items, format: :json, id: invoice.id
      invoice_items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_items.count).to eq(3)
      invoice_items.each do |invoice_item|
        expect(invoice_item[:invoice_id]).to eq(invoice.id)
      end
    end
  end

  describe "#items" do
    it "returns a collection of associated items" do
      invoice = Invoice.create(status: "shipped")
      invoice.items.create(
        name: "Explosive Tennis Balls",
        description: "Tickle your friends! Surprise your opponent!",
        unit_price: 120000)
      invoice.items.create(
        name: "American Wrought Anvils",
        description: "They ring like a bell.",
        unit_price: 10000)
      invoice.items.create(
        name: "Instant Tunnel",
        description: "For a smashing good time!",
        unit_price: 1995)

      get :items, format: :json, id: invoice.id
      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(items.count).to eq(3)
    end
  end

  describe "#customer" do
    it "returns the associated customer" do
      customer = Customer.create(first_name: "Jane", last_name: "Doe")
      invoice = customer.invoices.create(status: "shipped")

      get :customer, format: :json, id: invoice.id
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(result[:first_name]).to eq(customer.first_name)
      expect(result[:last_name]).to eq(customer.last_name)
    end
  end

  describe "#merchant" do
    it "returns the associated merchant" do
      merchant = Merchant.create(name: "Acme Corporation")
      invoice = merchant.invoices.create(status: "shipped")

      get :merchant, format: :json, id: invoice.id
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(result[:name]).to eq(merchant.name)
    end
  end
end
