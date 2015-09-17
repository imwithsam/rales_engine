require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  describe "#index" do
    it "returns all customers" do
      Customer.create(first_name: "Jane", last_name: "Doe")
      Customer.create(first_name: "John", last_name: "Doe")
      Customer.create(first_name: "Sam", last_name: "Brock")

      get :index, format: :json
      customers = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customers.count).to eq(3)
    end
  end

  describe "#show" do
    it "returns a customer" do
      customer_1 = Customer.create(first_name: "Jane", last_name: "Doe")
      Customer.create(first_name: "John", last_name: "Doe")
      Customer.create(first_name: "Sam", last_name: "Brock")

      get :show, format: :json, id: customer_1.id
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customer[:first_name]).to eq(customer_1.first_name)
    end
  end

  describe "#find" do
    it "finds a customer by first name" do
      customer_1 = Customer.create(first_name: "Jane", last_name: "Doe")
      Customer.create(first_name: "John", last_name: "Doe")
      Customer.create(first_name: "Sam", last_name: "Brock")

      get :find, format: :json, first_name: customer_1.first_name
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customer[:first_name]).to eq(customer_1.first_name)
    end
  end

  describe "#find_all" do
    it "finds all customers by last name" do
      customer_1 = Customer.create(first_name: "Jane", last_name: "Doe")
      Customer.create(first_name: "John", last_name: "Doe")
      Customer.create(first_name: "Sam", last_name: "Brock")

      get :find_all, format: :json, last_name: customer_1.last_name
      customers = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customers.count).to eq(2)
    end
  end

  describe "#random" do
    it "returns a random customer" do
      customer_1 = Customer.create(first_name: "Jane", last_name: "Doe")
      customer_2 = Customer.create(first_name: "John", last_name: "Doe")
      customer_3 = Customer.create(first_name: "Sam", last_name: "Brock")

      get :random, format: :json
      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customer[:first_name]).to satisfy do |first_name|
        [customer_1.first_name,
         customer_2.first_name,
         customer_3.first_name].include?(first_name)
      end
    end
  end

  describe "#invoices" do
    it "returns a collection of associated invoices" do
      customer = Customer.create(first_name: "Jane", last_name: "Doe")
      customer.invoices.create(status: "shipped")
      customer.invoices.create(status: "shipped")
      customer.invoices.create(status: "shipped")

      get :invoices, format: :json, id: customer.id
      invoices = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoices.count).to eq(3)
      invoices.each do |invoice|
        expect(invoice[:customer_id]).to eq(customer.id)
      end
    end
  end

  describe "#transactions" do
    it "returns a collection of associated transactions" do
      customer = Customer.create(first_name: "Jane", last_name: "Doe")
      invoice = customer.invoices.create(status: "shipped")
      invoice.transactions.create(
        credit_card_number: "4242424242424242",
        result: "failed")
      invoice.transactions.create(
        credit_card_number: "4242424242424242",
        result: "failed")
      invoice.transactions.create(
        credit_card_number: "4242424242424242",
        result: "success")

      get :transactions, format: :json, id: customer.id
      transactions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transactions.count).to eq(3)
      transactions.each do |transaction|
        expect(transaction[:invoice_id]).to eq(invoice.id)
      end
    end
  end
end
