class Item < ActiveRecord::Base
  include Finders

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      item = find_by_id(row["id"]) || new
      item.update(
        name: item_params(row)[:name],
        description: item_params(row)[:description],
        unit_price: item_params(row)[:unit_price].to_f / 100,
        merchant_id: item_params(row)[:merchant_id],
        created_at: item_params(row)[:created_at],
        updated_at: item_params(row)[:updated_at])
      item.save!
    end
  end

  private

  def self.item_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:name,
                  :description,
                  :unit_price,
                  :merchant_id,
                  :created_at,
                  :updated_at)
  end
end
