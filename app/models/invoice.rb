class Invoice < ActiveRecord::Base
  include Finders

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
