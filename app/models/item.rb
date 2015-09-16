class Item < ActiveRecord::Base
  include Finders

  belongs_to :merchant

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      item = find_by_id(row["id"]) || new
      item.update(item_params(row))
      item.save!
    end
  end

  private

  def self.item_params(row)
    params = ActionController::Parameters.new(row.to_hash)
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
