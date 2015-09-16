require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
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

  xdescribe "#transactions" do
    it "returns a collection of associated transactions" do
      customer = Customer.create(first_name: "Jane", last_name: "Doe")
      customer.transactions.create(
        credit_card_number: "4242424242424242",
        result: "failed")
      customer.transactions.create(
        credit_card_number: "4242424242424242",
        result: "failed")
      customer.transactions.create(
        credit_card_number: "4242424242424242",
        result: "success")

      get :transactions, format: :json, id: customer.id
      transactions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transactions.count).to eq(3)
      transactions.each do |transaction|
        expect(transaction[:customer_id]).to eq(customer.id)
      end
    end
  end
end
