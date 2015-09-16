require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  describe "#invoice" do
    it "returns the associated invoice" do
      invoice = Invoice.create(status: "shipped")
      transaction = invoice.transactions.create(result: "success")

      get :invoice, format: :json, id: transaction.id
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(result[:status]).to eq(invoice.status)
    end
  end
end
