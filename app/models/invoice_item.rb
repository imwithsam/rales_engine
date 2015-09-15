class InvoiceItem < ActiveRecord::Base
  include Finders

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      invoice_item = find_by_id(row["id"]) || new
      invoice_item.update(invoice_item_params(row))
      invoice_item.save!
    end
  end

  private

  def self.invoice_item_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:item_id, :invoice_id, :quantity, :unit_price)
  end
end
