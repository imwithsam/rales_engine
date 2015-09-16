class InvoiceItem < ActiveRecord::Base
  include Finders

  belongs_to :invoice
  belongs_to :item

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      invoice_item = find_by_id(row["id"]) || new
      invoice_item.update(
        item_id: invoice_item_params(row)[:item_id],
        invoice_id: invoice_item_params(row)[:invoice_id],
        quantity: invoice_item_params(row)[:quantity],
        unit_price: invoice_item_params(row)[:unit_price].to_f / 100,
        created_at: invoice_item_params(row)[:created_at],
        updated_at: invoice_item_params(row)[:updated_at])
      invoice_item.save!
    end
  end

  private

  def self.invoice_item_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:item_id,
                  :invoice_id,
                  :quantity,
                  :unit_price,
                  :created_at,
                  :updated_at)
  end
end
