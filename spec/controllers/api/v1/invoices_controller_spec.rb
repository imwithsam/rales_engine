require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
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
end
