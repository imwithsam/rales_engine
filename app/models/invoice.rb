class Invoice < ActiveRecord::Base
  include Finders

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      invoice = find_by_id(row["id"]) || new
      invoice.update(invoice_params(row))
      invoice.save!
    end
  end

  private

  def self.invoice_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:customer_id, :merchant_id, :status)
  end
end
