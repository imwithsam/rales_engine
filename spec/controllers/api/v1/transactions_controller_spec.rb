require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  describe "#index" do
    it "returns all transactions" do
      Transaction.create(credit_card_number: "4242424242424242")
      Transaction.create(credit_card_number: "4242424242424242")
      Transaction.create(credit_card_number: "4242424242424242")

      get :index, format: :json
      transactions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transactions.count).to eq(3)
    end
  end

  describe "#show" do
    it "returns an transaction" do
      transaction_1 = Transaction.create(credit_card_number: "4242424242424242")
      Transaction.create(credit_card_number: "4343434343434343")
      Transaction.create(credit_card_number: "4343434343434343")

      get :show, format: :json, id: transaction_1.id
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transaction[:credit_card_number]).to eq(transaction_1.credit_card_number)
    end
  end

  describe "#find" do
    it "finds an transaction by credit_card_number" do
      transaction_1 = Transaction.create(credit_card_number: "4242424242424242")
      Transaction.create(credit_card_number: "4343434343434343")
      Transaction.create(credit_card_number: "4343434343434343")

      get :find, format: :json, credit_card_number: transaction_1.credit_card_number
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transaction[:credit_card_number]).to eq(transaction_1.credit_card_number)
    end
  end

  describe "#find_all" do
    it "finds all transactions by credit_card_number" do
      transaction_1 = Transaction.create(credit_card_number: "4242424242424242")
      Transaction.create(credit_card_number: "4242424242424242")
      Transaction.create(credit_card_number: "4343434343434343")

      get :find_all, format: :json, credit_card_number: transaction_1.credit_card_number
      transactions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transactions.count).to eq(2)
    end
  end

  describe "#random" do
    it "returns a random transaction" do
      transaction_1 = Transaction.create(credit_card_number: "4242424242424242")
      transaction_2 = Transaction.create(credit_card_number: "4343434343434343")
      transaction_3 = Transaction.create(credit_card_number: "4444444444444444")

      get :random, format: :json
      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transaction[:credit_card_number]).to satisfy do |credit_card_number|
        [transaction_1.credit_card_number,
         transaction_2.credit_card_number,
         transaction_3.credit_card_number].include?(credit_card_number)
      end
    end
  end

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
