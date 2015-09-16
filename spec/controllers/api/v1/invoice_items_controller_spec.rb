require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
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
end
