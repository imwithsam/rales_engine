class Merchant < ActiveRecord::Base
  include Finders

  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      merchant = find_by_id(row["id"]) || new
      merchant.update(merchant_params(row))
      merchant.save!
    end
  end

  def revenue
    @revenue ||= paid_invoices.reduce(0) {
      |sum, paid_invoice| sum + paid_invoice.total }
  end

  def items_sold
    @items_sold ||= paid_invoices.reduce(0) {
      |sum, paid_invoice| sum + paid_invoice.total_quantity }
  end

  def revenue(date)
    paid_invoices.select { |invoice| invoice.created_at == date }.reduce(0) {
      |sum, invoice| sum + invoice.total }
  end

  private

  def paid_invoices
    @paid_invoices ||= invoices.select { |invoice| invoice.paid? }
  end

  def transactions_by_date(date)
    successful_transactions = transactions.where(result: "success")
    successful_transactions.where(created_at: date)
    byebug
  end

  def self.merchant_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:name, :created_at, :updated_at)
  end
end
